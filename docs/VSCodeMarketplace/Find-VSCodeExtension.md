---
document type: cmdlet
external help file: VSCodeMarketPlace-Help.xml
HelpUri: 'https://steviecoaster.github.io/vscodemarketplace/VSCodeMarketplace/Find-VSCodeExtension/'
Locale: en-US
Module Name: VSCodeMarketPlace
ms.date: 04/01/2026
PlatyPS schema version: 2024-05-01
title: Find-VSCodeExtension
---

# Find-VSCodeExtension

## SYNOPSIS

Searches the Visual Studio Code Marketplace via the public Gallery API.

## SYNTAX

### fuzzy (Default)

```
Find-VSCodeExtension [-Query] <string> [-PageSize <int>] [-SortBy <string>] [<CommonParameters>]
```

### exact

```
Find-VSCodeExtension -ExtensionId <string> [-Version <string>] [-PageSize <int>] [-SortBy <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Queries the VS Code Marketplace extension gallery and returns matching
extensions with key metadata such as publisher, name, version, download
count, and VSIX download URL.

Supports two modes of operation:

- Fuzzy mode (-Query): performs a text search across the marketplace,
  returning up to -PageSize results ranked by the chosen sort order.

- Exact mode (-ExtensionId): performs a precise lookup by qualified
  extension name (publisher.extensionname), returning only that extension.
  Optionally, -Version can be used to resolve a specific version; if the
  requested version is not found, the latest version is returned with a
  warning.

## EXAMPLES

### EXAMPLE 1

Find-VSCodeExtension -Query "git"

Text search returning the top 10 most relevant git-related extensions.

### EXAMPLE 2

Find-VSCodeExtension -Query "python" -PageSize 20 -SortBy Downloads

Returns the top 20 Python extensions sorted by download count.

### EXAMPLE 3

Find-VSCodeExtension -ExtensionId "eamodio.gitlens"

Exact lookup for GitLens, returning the latest published version.

### EXAMPLE 4

Find-VSCodeExtension -ExtensionId "eamodio.gitlens" -Version "16.3.0"

Exact lookup for a specific version of GitLens.

### EXAMPLE 5

Find-VSCodeExtension -ExtensionId "eamodio.gitlens" | Save-VSCodeExtension -Destination C:\vsix

Downloads the latest GitLens VSIX to C:\vsix.

## PARAMETERS

### -ExtensionId

The qualified extension name in publisher.extensionname format
(e.g.
'eamodio.gitlens').
Performs an exact lookup.
Cannot be combined
with -Query.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: exact
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PageSize

Number of results to return in fuzzy mode.
Defaults to 10, max 100.
Has no effect in exact mode since only one extension is returned.

```yaml
Type: System.Int32
DefaultValue: 10
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

### -Query

The search term(s) to look for in the marketplace.
Used for fuzzy/text
search.
Cannot be combined with -ExtensionId.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: fuzzy
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SortBy

Sort order for fuzzy mode results.
Valid values:
  Relevance     - Best match for the search query (default)
  Downloads     - Most downloaded extensions
  Rating        - Highest rated extensions
  PublishedDate - Newest extensions

```yaml
Type: System.String
DefaultValue: Relevance
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

### -Version

The specific version to resolve when using -ExtensionId
(e.g.
'16.3.0').
If omitted, the latest version is returned.
If the
requested version does not exist, falls back to latest with a warning.
Only valid with -ExtensionId.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: exact
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

## OUTPUTS

### PSCustomObject with the following properties:
  Publisher

{{ Fill in the Description }}

## NOTES

API reference: https://github.com/microsoft/vscode/blob/main/src/vs/platform/extensionManagement/common/extensionGalleryService.ts


## RELATED LINKS

{{ Fill in the related links here }}

