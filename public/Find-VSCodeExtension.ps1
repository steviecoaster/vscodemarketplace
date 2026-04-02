function Find-VSCodeExtension {
    <#
.SYNOPSIS
    Searches the Visual Studio Code Marketplace via the public Gallery API.

.DESCRIPTION
    Queries the VS Code Marketplace extension gallery and returns matching
    extensions with key metadata such as publisher, name, version, download
    count, and VSIX download URL.

    Supports two modes of operation:

    - Fuzzy mode (-Query): performs a text search across the marketplace,
      returning up to -PageSize results ranked by the chosen sort order.

    - Exact mode (-ExtensionId): performs a precise lookup by qualified
      extension name (publisher.extensionname), returning only that extension.
      Optionally, -Version can be used to resolve a specific version; if the
      requested version is not found, the latest version is returned with a
      warning.

.PARAMETER Query
    The search term(s) to look for in the marketplace. Used for fuzzy/text
    search. Cannot be combined with -ExtensionId.

.PARAMETER ExtensionId
    The qualified extension name in publisher.extensionname format
    (e.g. 'eamodio.gitlens'). Performs an exact lookup. Cannot be combined
    with -Query.

.PARAMETER Version
    The specific version to resolve when using -ExtensionId
    (e.g. '16.3.0'). If omitted, the latest version is returned. If the
    requested version does not exist, falls back to latest with a warning.
    Only valid with -ExtensionId.

.PARAMETER PageSize
    Number of results to return in fuzzy mode. Defaults to 10, max 100.
    Has no effect in exact mode since only one extension is returned.

.PARAMETER SortBy
    Sort order for fuzzy mode results. Valid values:
      Relevance     - Best match for the search query (default)
      Downloads     - Most downloaded extensions
      Rating        - Highest rated extensions
      PublishedDate - Newest extensions

.OUTPUTS
    PSCustomObject with the following properties:
      Publisher, ExtensionId, DisplayName, Version, TargetPlatforms,
      Downloads, Rating, Description, VsixUrl

.EXAMPLE
    Find-VSCodeExtension -Query "git"

    Text search returning the top 10 most relevant git-related extensions.

.EXAMPLE
    Find-VSCodeExtension -Query "python" -PageSize 20 -SortBy Downloads

    Returns the top 20 Python extensions sorted by download count.

.EXAMPLE
    Find-VSCodeExtension -ExtensionId "eamodio.gitlens"

    Exact lookup for GitLens, returning the latest published version.

.EXAMPLE
    Find-VSCodeExtension -ExtensionId "eamodio.gitlens" -Version "16.3.0"

    Exact lookup for a specific version of GitLens.

.EXAMPLE
    Find-VSCodeExtension -ExtensionId "eamodio.gitlens" | Save-VSCodeExtension -Destination C:\vsix

    Downloads the latest GitLens VSIX to C:\vsix.

.NOTES
    API reference: https://github.com/microsoft/vscode/blob/main/src/vs/platform/extensionManagement/common/extensionGalleryService.ts
#>
    [CmdletBinding(DefaultParameterSetName = 'fuzzy', HelpUri = 'https://steviecoaster.github.io/VSCodeMarketplace/VSCodeMarketplace/Find-VSCodeExtension/')]
    param(
        [Parameter(Mandatory, Position = 0, ParameterSetName = 'fuzzy')]
        [string]
        $Query,

        [Parameter(ParameterSetName = 'exact', Mandatory)]
        [String]
        $ExtensionId,

        [Parameter(ParameterSetName = 'exact')]
        [String]
        $Version,

        [Parameter()]
        [ValidateRange(1, 100)]
        [int]
        $PageSize = 10,

        [Parameter()]
        [ValidateSet('Relevance', 'Downloads', 'Rating', 'PublishedDate')]
        [string]
        $SortBy = 'Relevance'
    )

    # Map friendly sort names to API sort order values
    $sortMap = @{
        Relevance     = 0
        PublishedDate = 10
        Downloads     = 4
        Rating        = 12
    }

    $criteria = switch ($PSCmdlet.ParameterSetName) {
        'fuzzy' {
            @(
                @{ filterType = 8; value = 'Microsoft.VisualStudio.Code' }   # target platform
                @{ filterType = 10; value = $Query }                          # search text
            )
        }

        'exact' {
            @(
                @{ filterType = 8; value = 'Microsoft.VisualStudio.Code' }   # target platform
                @{ filterType = 7; value = $ExtensionId }                    # exact qualified name (publisher.extensionname)
            )
        }
    }

    $uri = 'https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery'

    $body = @{
        filters    = @(
            @{
                criteria   = $criteria
                pageSize   = $PageSize
                pageNumber = 1
                sortBy     = $sortMap[$SortBy]
                sortOrder  = 0
            }
        )
        assetTypes = @()
        flags      = 914   # includes statistics, versions, and install count
    } | ConvertTo-Json -Depth 10

    $headers = @{
        'Content-Type' = 'application/json'
        'Accept'       = 'application/json;api-version=7.2-preview.1'
    }

    $searchTerm = if ($PSCmdlet.ParameterSetName -eq 'exact') { $ExtensionId } else { $Query }
    Write-Verbose "Querying VS Code Marketplace for: '$searchTerm' (sort: $SortBy, pageSize: $PageSize)"

    $response = Invoke-RestMethod -Uri $uri -Method Post -Body $body -Headers $headers

    $extensions = $response.results[0].extensions

    if (-not $extensions -or $extensions.Count -eq 0) {
        Write-Warning "No extensions found for: '$searchTerm'"
        return
    }

    $extensions | ForEach-Object {
        $ext = $_

        # Pull download count from statistics array if available
        $downloads = ($ext.statistics | Where-Object { $_.statisticName -eq 'install' } | Select-Object -ExpandProperty value -ErrorAction SilentlyContinue)
        $rating = ($ext.statistics | Where-Object { $_.statisticName -eq 'averagerating' } | Select-Object -ExpandProperty value -ErrorAction SilentlyContinue)

        $publisher = $ext.publisher.publisherName
        $extensionName = $ext.extensionName

        # versions[] is sorted by lastUpdated, not version number — sort explicitly to find the true latest
        $latestVersion = $ext.versions |
        Select-Object -ExpandProperty version -Unique |
        Sort-Object { try { [System.Version]$_ } catch { [System.Version]'0.0.0' } } -Descending |
        Select-Object -First 1

        # If a specific version was requested, use it; otherwise use the latest
        $resolvedVersion = if ($Version -and ($ext.versions.version -contains $Version)) {
            $Version
        }
        elseif ($Version) {
            Write-Warning "Version '$Version' not found for '$publisher.$extensionName'. Returning latest ($latestVersion)."
            $latestVersion
        }
        else {
            $latestVersion
        }

        $vsixUrl = "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/$publisher/vsextensions/$extensionName/$resolvedVersion/vspackage"

        # Collect all target platforms available for the resolved version
        # Each platform ships as a separate entry in versions[] with the same version number
        $targetPlatforms = @(
            $ext.versions |
            Where-Object { $_.version -eq $resolvedVersion } |
            ForEach-Object { if ($_.targetPlatform) { $_.targetPlatform } else { 'universal' } } |
            Sort-Object -Unique
        )

        [PSCustomObject]@{
            Publisher       = $publisher
            ExtensionId     = "$publisher.$extensionName"
            DisplayName     = $ext.displayName
            Version         = $resolvedVersion
            TargetPlatforms = $targetPlatforms
            Downloads       = if ($downloads) { [int]$downloads } else { 0 }
            Rating          = if ($rating) { [math]::Round($rating, 1) } else { 'N/A' }
            Description     = $ext.shortDescription
            VsixUrl         = $vsixUrl
        }
    }
}