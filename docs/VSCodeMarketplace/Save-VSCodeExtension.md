---
document type: cmdlet
external help file: VSCodeMarketPlace-Help.xml
HelpUri: 'https://steviecoaster.github.io/VSCodeMarketplace/VSCodeMarketplace/Save-VSCodeExtension/'
Locale: en-US
Module Name: VSCodeMarketPlace
ms.date: 04/01/2026
PlatyPS schema version: 2024-05-01
title: Save-VSCodeExtension
---

# Save-VSCodeExtension

## SYNOPSIS

Downloads one or more VS Code extensions as VSIX files.

## SYNTAX

### extension (Default)

```
Save-VSCodeExtension -Extension <psobject[]> [-Destination <string>] [<CommonParameters>]
```

### url

```
Save-VSCodeExtension -Url <string[]> [-Destination <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Downloads VS Code extensions as VSIX files to a specified destination folder.
Supports two modes of operation:

- Extension mode: accepts extension objects piped from Find-VSCodeExtension.
  The filename is derived automatically from the object's ExtensionId and Version.

- URL mode: accepts one or more raw vspackage URLs from the VS Code Marketplace API.
  The filename is parsed directly from the URL segments.

In both modes, each downloaded file is returned as a FileInfo object.

## EXAMPLES

### EXAMPLE 1

Find-VSCodeExtension -Query "python" | Out-GridView -PassThru | Save-VSCodeExtension

Searches for Python-related extensions, lets the user pick from a grid view,
and downloads the selected extensions to the current directory.

### EXAMPLE 2

Find-VSCodeExtension -Query "git" -SortBy Downloads | Save-VSCodeExtension -Destination C:\vsix

Downloads the top git extensions by download count to C:\vsix.

### EXAMPLE 3

Save-VSCodeExtension -Url "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/python/2025.4.0/vspackage"

Downloads a specific extension version directly using its vspackage URL.

### EXAMPLE 4

$urls = (Find-VSCodeExtension -Query "pylance").VsixUrl
Save-VSCodeExtension -Url $urls -Destination C:\vsix

Extracts the VsixUrl from search results and passes it directly via -Url.

## PARAMETERS

### -Destination

The folder to save downloaded VSIX files to.
Defaults to the current directory.

```yaml
Type: System.String
DefaultValue: $PWD
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

One or more extension objects returned by Find-VSCodeExtension.
Accepts pipeline input.
Cannot be combined with -Url.

```yaml
Type: System.Management.Automation.PSObject[]
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

### -Url

One or more raw VS Code Marketplace vspackage URLs.
Expected format: .../publishers/{publisher}/vsextensions/{name}/{version}/vspackage
Cannot be combined with -Extension.

```yaml
Type: System.String[]
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

### System.Management.Automation.PSObject[]

{{ Fill in the Description }}

## OUTPUTS

### System.IO.FileInfo for each downloaded file.

{{ Fill in the Description }}

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

