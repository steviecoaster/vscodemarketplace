---
document type: cmdlet
external help file: VSCodeMarketPlace-Help.xml
HelpUri: 'https://steviecoaster.github.io/vscodemarketplace/VSCodeMarketplace/Get-VSCodeExtension/'
Locale: en-US
Module Name: VSCodeMarketPlace
ms.date: 04/02/2026
PlatyPS schema version: 2024-05-01
title: Get-VSCodeExtension
---

# Get-VSCodeExtension

## SYNOPSIS

Returns VS Code extensions currently installed in the local VS Code instance.

## SYNTAX

```powershell
Get-VSCodeExtension [[-ExtensionId] <string[]>] [-IncludeVersions] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  None

## DESCRIPTION

Retrieves the list of VS Code extensions installed in the current user's
VS Code environment by invoking the `code --list-extensions` CLI command.

By default, each extension object has a Name property (the qualified
publisher.extensionname ID) and an empty Version property. Use
-IncludeVersions to populate the Version property with the installed
version string.

Optionally, -ExtensionId can be used to filter results to one or more
specific extensions by their qualified publisher.extensionname ID.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-VSCodeExtension
```

Returns all installed extensions with the Name property populated and Version empty.

### EXAMPLE 2

```powershell
Get-VSCodeExtension -IncludeVersions
```

Returns all installed extensions with both Name and Version populated.

### EXAMPLE 3

```powershell
Get-VSCodeExtension -ExtensionId "eamodio.gitlens" -IncludeVersions
```

Returns only the GitLens extension entry with version information included.

### EXAMPLE 4

```powershell
Get-VSCodeExtension -ExtensionId "eamodio.gitlens" | Uninstall-VSCodeExtension
```

Retrieves the GitLens extension object and pipes it to Uninstall-VSCodeExtension to remove it.

## PARAMETERS

### -ExtensionId

One or more qualified extension IDs in publisher.extensionname format
(e.g. 'eamodio.gitlens') to filter the results. If omitted, all installed
extensions are returned.

```yaml
Type: System.String[]
DefaultValue: ''
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

### -IncludeVersions

When specified, retrieves version information alongside each extension name
by passing --show-versions to the code CLI. Without this switch the Version
property on each returned object will be empty.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

None

## OUTPUTS

### PSCustomObject with the following properties:

  Name    - The qualified publisher.extensionname ID  
  Version - The installed version string (populated only when -IncludeVersions is used)

## NOTES

Requires the `code` CLI to be available on the system PATH.

## RELATED LINKS

None
