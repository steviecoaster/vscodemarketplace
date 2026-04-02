function Uninstall-VSCodeExtension {
    <#
.SYNOPSIS
    Uninstalls a VS Code extension using the Code CLI.

.DESCRIPTION
    Calls the VS Code CLI with --uninstall-extension to remove the specified
    extension. The extension is identified by its qualified name in
    publisher.extensionname format (e.g. 'eamodio.gitlens').

.PARAMETER Extension
    One or more qualified extension names to uninstall, in publisher.extensionname format
    (e.g. 'eamodio.gitlens'). Accepts multiple values and pipeline input by property name,
    mapping the Name property returned by Get-VSCodeExtension.

.PARAMETER CodeExecutable
    Path to the VS Code CLI executable (e.g. code.exe or code-insiders.exe).

.EXAMPLE
    Uninstall-VSCodeExtension -Extension 'eamodio.gitlens'

    Uninstalls the GitLens extension from VS Code.

.EXAMPLE
    Get-VSCodeExtension -ExtensionId 'eamodio.gitlens' | Uninstall-VSCodeExtension

    Retrieves the installed GitLens extension object and pipes it directly to
    Uninstall-VSCodeExtension to remove it.

.EXAMPLE
    Get-VSCodeExtension | Where-Object Name -like 'ms-python.*' | Uninstall-VSCodeExtension

    Uninstalls all installed extensions whose publisher is ms-python.
#>
    [CmdletBinding(HelpUri = 'https://steviecoaster.github.io/vscodemarketplace/VSCodeMarketplace/Uninstall-VSCodeExtension/')]
    Param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Name')]
        [String[]]
        $Extension,

        [Parameter()]
        [String]
        $CodeExecutable = ((Get-Command code).Source)
    )
    
    process {
        foreach ($ext in $Extension) {
            $Statements = @('--uninstall-extension', $ext)
            & $CodeExecutable @Statements
        }
    }
}