function Get-VSCodeExtension {
    <#
.SYNOPSIS
    Returns VS Code extensions currently installed in the local VS Code instance.

.DESCRIPTION
    Retrieves the list of VS Code extensions installed in the current user's
    VS Code environment by invoking the `code --list-extensions` CLI command.

    By default, each extension object has a Name property (the qualified
    publisher.extensionname ID) and an empty Version property. Use
    -IncludeVersions to populate the Version property with the installed
    version string.

    Optionally, -ExtensionId can be used to filter results to one or more
    specific extensions by their qualified publisher.extensionname ID.

.PARAMETER ExtensionId
    One or more qualified extension IDs in publisher.extensionname format
    (e.g. 'eamodio.gitlens') to filter the results. If omitted, all installed
    extensions are returned.

.PARAMETER IncludeVersions
    When specified, retrieves version information alongside each extension name
    by passing --show-versions to the code CLI. Without this switch the Version
    property on each returned object will be empty.

.OUTPUTS
    PSCustomObject with the following properties:
      Name    - The qualified publisher.extensionname ID
      Version - The installed version string (populated only when -IncludeVersions is used)

.EXAMPLE
    Get-VSCodeExtension

    Returns all installed extensions with the Name property populated and Version empty.

.EXAMPLE
    Get-VSCodeExtension -IncludeVersions

    Returns all installed extensions with both Name and Version populated.

.EXAMPLE
    Get-VSCodeExtension -ExtensionId "eamodio.gitlens" -IncludeVersions

    Returns only the GitLens extension entry with version information included.

.EXAMPLE
    Get-VSCodeExtension -ExtensionId "eamodio.gitlens" | Uninstall-VSCodeExtension

    Retrieves the GitLens extension object and pipes it to Uninstall-VSCodeExtension to remove it.

.NOTES
    Requires the `code` CLI to be available on the system PATH.
    Output objects are pipeline-compatible with Uninstall-VSCodeExtension.
#>
    [CmdletBinding()]
    Param(

        [Parameter()]
        [String[]]
        $ExtensionId,

        [Parameter()]
        [Switch]
        $IncludeVersions
    )

    end {

        $extensions = & code --list-extensions $(if ($IncludeVersions) { '--show-versions'})
        
        $extensionObjects = $extensions | Foreach-Object {
            [pscustomobject]@{
                Name = $_.Split('@')[0]
                Version = $_.Split('@')[1]
            }
        }

        if($ExtensionId){
            $extensionObjects | Where-Object { $_.Name -in $ExtensionId}
        }
        else {
            $extensionObjects
        }

    }
}