---
document type: cmdlet
external help file: VSCodeMarketPlace-Help.xml
HelpUri: 'https://steviecoaster.github.io/vscodemarketplace/VSCodeMarketplace/Uninstall-VSCodeExtension/'
Locale: en-US
Module Name: VSCodeMarketPlace
ms.date: 04/01/2026
PlatyPS schema version: 2024-05-01
title: Uninstall-VSCodeExtension
---

# Uninstall-VSCodeExtension

## SYNOPSIS

Uninstalls a VS Code extension using the Code CLI.

## SYNTAX

### __AllParameterSets

```
Uninstall-VSCodeExtension [-Extension] <string> [[-CodeExecutable] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Calls the VS Code CLI with --uninstall-extension to remove the specified
extension.
The extension is identified by its qualified name in
publisher.extensionname format (e.g.
'eamodio.gitlens').

## EXAMPLES

### EXAMPLE 1

Uninstall-VSCodeExtension -Extension 'eamodio.gitlens' -CodeExecutable 'C:\Program Files\Microsoft VS Code\bin\code.cmd'

Uninstalls the GitLens extension from VS Code.

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
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Extension

The qualified extension name to uninstall, in publisher.extensionname format
(e.g.
'eamodio.gitlens').

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
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

## OUTPUTS

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

