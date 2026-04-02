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

```powershell
Uninstall-VSCodeExtension [-Extension] <string[]> [[-CodeExecutable] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  None

## DESCRIPTION

Calls the VS Code CLI with --uninstall-extension to remove the specified
extension.
The extension is identified by its qualified name in
publisher.extensionname format (e.g.
'eamodio.gitlens').

## EXAMPLES

### EXAMPLE 1

```powershell
Uninstall-VSCodeExtension -Extension 'eamodio.gitlens'
```

Uninstalls the GitLens extension from VS Code.

### EXAMPLE 2

```powershell
Uninstall-VSCodeExtension -Extension 'eamodio.gitlens','ms-python.python'
```

Uninstalls multiple extensions in a single call by passing an array directly.

### EXAMPLE 3

```powershell
Get-VSCodeExtension -ExtensionId 'eamodio.gitlens' | Uninstall-VSCodeExtension
```

Retrieves the installed GitLens extension object and pipes it directly to Uninstall-VSCodeExtension.

### EXAMPLE 4

```powershell
Get-VSCodeExtension | Where-Object Name -like 'ms-python.*' | Uninstall-VSCodeExtension
```

Uninstalls all installed extensions whose publisher is ms-python.

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

One or more qualified extension names to uninstall, in publisher.extensionname format
(e.g. 'eamodio.gitlens'). Accepts multiple values and pipeline input by property name,
mapping the Name property returned by Get-VSCodeExtension.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases: [Name]
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
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

### PSCustomObject

Objects returned by Get-VSCodeExtension. The Name property is bound to the -Extension parameter.

## OUTPUTS

## NOTES

## RELATED LINKS

None

