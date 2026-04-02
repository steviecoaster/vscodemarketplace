function Save-VSCodeExtension {
    <#
.SYNOPSIS
    Downloads one or more VS Code extensions as VSIX files.

.DESCRIPTION
    Downloads VS Code extensions as VSIX files to a specified destination folder.
    Supports two modes of operation:

    - Extension mode: accepts extension objects piped from Find-VSCodeExtension.
      The filename is derived automatically from the object's ExtensionId and Version.

    - URL mode: accepts one or more raw vspackage URLs from the VS Code Marketplace API.
      The filename is parsed directly from the URL segments.

    In both modes, each downloaded file is returned as a FileInfo object.

.PARAMETER Extension
    One or more extension objects returned by Find-VSCodeExtension.
    Accepts pipeline input. Cannot be combined with -Url.

.PARAMETER Url
    One or more raw VS Code Marketplace vspackage URLs.
    Expected format: .../publishers/{publisher}/vsextensions/{name}/{version}/vspackage
    Cannot be combined with -Extension.

.PARAMETER Destination
    The folder to save downloaded VSIX files to. Defaults to the current directory.

.OUTPUTS
    System.IO.FileInfo for each downloaded file.

.EXAMPLE
    Find-VSCodeExtension -Query "python" | Out-GridView -PassThru | Save-VSCodeExtension

    Searches for Python-related extensions, lets the user pick from a grid view,
    and downloads the selected extensions to the current directory.

.EXAMPLE
    Find-VSCodeExtension -Query "git" -SortBy Downloads | Save-VSCodeExtension -Destination C:\vsix

    Downloads the top git extensions by download count to C:\vsix.

.EXAMPLE
    Save-VSCodeExtension -Url "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/python/2025.4.0/vspackage"

    Downloads a specific extension version directly using its vspackage URL.

.EXAMPLE
    $urls = (Find-VSCodeExtension -Query "pylance").VsixUrl
    Save-VSCodeExtension -Url $urls -Destination C:\vsix

    Extracts the VsixUrl from search results and passes it directly via -Url.
#>
    [CmdletBinding(DefaultParameterSetName = 'extension', HelpUri = 'https://steviecoaster.github.io/VSCodeMarketplace/VSCodeMarketplace/Save-VSCodeExtension/')]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'extension')]
        [PSCustomObject[]]
        $Extension,

        [Parameter(Mandatory, ParameterSetName = 'url')]
        [String[]]
        $Url,

        [Parameter()]
        [string]
        $Destination = $PWD
    )

    process {

        switch ($PSCmdlet.ParameterSetName) {
            'extension' {
                $Extension | Foreach-Object {
                    $fileName = "$($_.ExtensionId)-$($_.Version).vsix"
                    $outPath = Join-Path $Destination $fileName
                    Write-Verbose "Downloading $($_.ExtensionId) -> $outPath"
                    Invoke-WebRequest -Uri $_.VsixUrl -OutFile $outPath
                    Get-Item $outPath
                }
            }

            'url' {
                $Url | ForEach-Object {
                    $parts = $_.Split('/')
                    $ExtId = $parts[7] + '.' + $parts[9]
                    $ExtVersion = $parts[10]
                    $fileName = "$($ExtId)-$($ExtVersion).vsix"
                    $outPath = Join-Path $Destination $fileName
                    Write-Verbose "Downloading $ExtId -> $outPath"
                    Invoke-WebRequest -Uri $_ -OutFile $outPath
                    Get-Item $outPath
                }
            }
        }

    }
}