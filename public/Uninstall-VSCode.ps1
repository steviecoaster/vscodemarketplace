function Uninstall-VSCodeExtension {
    <#
.SYNOPSIS
    Uninstalls a VS Code extension using the Code CLI.

.DESCRIPTION
    Calls the VS Code CLI with --uninstall-extension to remove the specified
    extension. The extension is identified by its qualified name in
    publisher.extensionname format (e.g. 'eamodio.gitlens').

.PARAMETER Extension
    The qualified extension name to uninstall, in publisher.extensionname format
    (e.g. 'eamodio.gitlens').

.PARAMETER CodeExecutable
    Path to the VS Code CLI executable (e.g. code.exe or code-insiders.exe).

.EXAMPLE
    Uninstall-VSCodeExtension -Extension 'eamodio.gitlens' -CodeExecutable 'C:\Program Files\Microsoft VS Code\bin\code.cmd'

    Uninstalls the GitLens extension from VS Code.
#>
    [CmdletBinding(HelpUri = 'https://steviecoaster.github.io/vscodemarketplace/VSCodeMarketplace/Uninstall-VSCodeExtension/')]
    Param(
        [Parameter(Mandatory)]
        [String]
        $Extension,

        [Parameter()]
        [String]
        $CodeExecutable = ((Get-Command code).Source)
    )
    
    end {
        $Statements = @('--uninstall-extension', $Extension)
        & $CodeExecutable @Statements
    }
}