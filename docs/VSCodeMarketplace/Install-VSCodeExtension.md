---
document type: cmdlet
external help file: VSCodeMarketPlace-Help.xml
HelpUri: 'https://steviecoaster.github.io/vscodemarketplace/VSCodeMarketplace/Install-VSCodeExtension/'
Locale: en-US
Module Name: VSCodeMarketPlace
ms.date: 04/01/2026
PlatyPS schema version: 2024-05-01
title: Install-VSCodeExtension
---

# Install-VSCodeExtension

## SYNOPSIS

Installs a VS Code extension using the Code CLI.

## SYNTAX

### extension (Default)

```
Install-VSCodeExtension -Extension <psobject> [-Destination <string>] [-CodeExecutable <string>]
 [<CommonParameters>]
```

### url

```
Install-VSCodeExtension -Url <string> [-Destination <string>] [-CodeExecutable <string>]
 [<CommonParameters>]
```

### file

```
Install-VSCodeExtension -File <string> [-Destination <string>] [-CodeExecutable <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Installs a VS Code extension in one of three ways:

- Extension mode: accepts an extension object returned by Find-VSCodeExtension,
  downloads the VSIX to the Chocolatey tools directory, and installs it.

- URL mode: accepts a raw VS Code Marketplace vspackage URL and downloads the
  VSIX before installing.
If the URL ends in .vsix, it is treated as a local
  file path (used by Chocolatey's Package Internalizer after internalization)
  and installed directly without downloading.

- File mode: accepts a path to an existing .vsix file and installs it directly.

## EXAMPLES

### EXAMPLE 1

Find-VSCodeExtension -ExtensionId 'eamodio.gitlens' | Install-VSCodeExtension -CodeExecutable 'C:\Program Files\Microsoft VS Code\bin\code.cmd'

Downloads and installs the latest GitLens extension.

### EXAMPLE 2

Install-VSCodeExtension -Url 'https://marketplace.visualstudio.com/_apis/public/gallery/publishers/eamodio/vsextensions/gitlens/16.3.0/vspackage' -CodeExecutable $codeExe

Downloads and installs a specific GitLens version.

### EXAMPLE 3

Install-VSCodeExtension -File 'C:\packages\gitlens.vsix' -CodeExecutable $codeExe

Installs a locally available VSIX file.

## PARAMETERS

### -CodeExecutable

Path to the VS Code CLI executable (e.g.
code.exe or code-insiders.exe).

```yaml
Type: System.String
DefaultValue: ((Get-Command code).Source)
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Destination

The folder used to store the downloaded VSIX before installation.
Defaults to $env:TEMP.
In Chocolatey scripts, pass $toolsDir.

```yaml
Type: System.String
DefaultValue: $env:TEMP
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Extension

An extension object returned by Find-VSCodeExtension.
Accepts pipeline input.
Cannot be combined with -Url or -File.

```yaml
Type: System.Management.Automation.PSObject
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: extension
  Position: Named
  IsRequired: true
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -File

Path to a local .vsix file to install directly.
Cannot be combined with -Extension or -Url.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: file
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Url

A raw VS Code Marketplace vspackage URL, or a local path to a .vsix file
(as substituted by Chocolatey's Package Internalizer).
Cannot be combined with -Extension or -File.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: url
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

{{ Fill in the Description }}

## OUTPUTS

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

