function Install-VSCodeExtension {
    <#
.SYNOPSIS
    Installs a VS Code extension using the Code CLI.

.DESCRIPTION
    Installs a VS Code extension in one of three ways:

    - Extension mode: accepts an extension object returned by Find-VSCodeExtension,
      downloads the VSIX to the Chocolatey tools directory, and installs it.

    - URL mode: accepts a raw VS Code Marketplace vspackage URL and downloads the
      VSIX before installing. If the URL ends in .vsix, it is treated as a local
      file path (used by Chocolatey's Package Internalizer after internalization)
      and installed directly without downloading.

    - File mode: accepts a path to an existing .vsix file and installs it directly.

.PARAMETER Extension
    An extension object returned by Find-VSCodeExtension. Accepts pipeline input.
    Cannot be combined with -Url or -File.

.PARAMETER Url
    A raw VS Code Marketplace vspackage URL, or a local path to a .vsix file
    (as substituted by Chocolatey's Package Internalizer).
    Cannot be combined with -Extension or -File.

.PARAMETER File
    Path to a local .vsix file to install directly.
    Cannot be combined with -Extension or -Url.

.PARAMETER Destination
    The folder used to store the downloaded VSIX before installation.
    Defaults to $env:TEMP. In Chocolatey scripts, pass $toolsDir.

.PARAMETER CodeExecutable
    Path to the VS Code CLI executable (e.g. code.exe or code-insiders.exe).

.EXAMPLE
    Find-VSCodeExtension -ExtensionId 'eamodio.gitlens' | Install-VSCodeExtension -CodeExecutable 'C:\Program Files\Microsoft VS Code\bin\code.cmd'

    Downloads and installs the latest GitLens extension.

.EXAMPLE
    Install-VSCodeExtension -Url 'https://marketplace.visualstudio.com/_apis/public/gallery/publishers/eamodio/vsextensions/gitlens/16.3.0/vspackage' -CodeExecutable $codeExe

    Downloads and installs a specific GitLens version.

.EXAMPLE
    Install-VSCodeExtension -File 'C:\packages\gitlens.vsix' -CodeExecutable $codeExe

    Installs a locally available VSIX file.
#>
    [CmdletBinding(DefaultParameterSetName = 'extension', HelpUri = 'https://steviecoaster.github.io/vscodemarketplace/VSCodeMarketplace/Install-VSCodeExtension/')]
    Param(
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'extension')]
        [PSCustomObject]
        $Extension,

        [Parameter(Mandatory, ParameterSetName = 'url')]
        [String]
        $Url,

        [Parameter(Mandatory, ParameterSetName = 'file')]
        [String]
        $File,

        [Parameter()]
        [String]
        $Destination = $env:TEMP,

        [Parameter()]
        [String]
        $CodeExecutable = ((Get-Command code).Source)
    )

    process {
        $vsixPath = switch ($PSCmdlet.ParameterSetName) {
            'extension' {
                ($Extension | Save-VSCodeExtension -Destination $Destination).FullName
            }

            'url' {
                if ($Url -like '*.vsix') {
                    $Url
                }
                else {
                    (Save-VSCodeExtension -Url $Url -Destination $Destination).FullName
                }
            }

            'file' {
                $File
            }
        }

        $Statements = @('--install-extension', $vsixPath)
        & $CodeExecutable @Statements
    }

}