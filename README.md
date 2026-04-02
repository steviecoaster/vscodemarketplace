# VSCodeMarketplace

A PowerShell module that wraps the Visual Studio Code Marketplace public Gallery API, letting you search, download, install, and uninstall VS Code extensions entirely from the command line.

## Features

- **Search** the Marketplace by keyword or exact extension ID
- **Download** extensions as `.vsix` files for offline or air-gapped use
- **Install** extensions directly via the `code` CLI — from a saved extension object, a VSIX URL, or a local file
- **Uninstall** extensions by ID using the `code` CLI
- Pipeline support — find, save, and install in a single one-liner

## Requirements

- PowerShell 5.1 or PowerShell 7+
- The `code` CLI must be on your `PATH` (required for `Install-VSCodeExtension` and `Uninstall-VSCodeExtension`)

## Installation

### From the PowerShell Gallery

#### Windows PowerShell

```powershell
Install-Module -Name VSCodeMarketplace
```

#### PowerShell 7+

```powershell
Install-PSResource VSCodeMarketplace
```

### Manually

```powershell
git clone https://github.com/<your-username>/VSCodeMarketplace.git
Import-Module .\VSCodeMarketplace\VSCodeMarketPlace.psd1
```

## Functions

| Function | Description |
|---|---|
| [`Find-VSCodeExtension`](#find-vscodeextension) | Search the VS Code Marketplace |
| [`Save-VSCodeExtension`](#save-vscodeextension) | Download extensions as VSIX files |
| [`Install-VSCodeExtension`](#install-vscodeextension) | Install extensions via the `code` CLI |
| [`Uninstall-VSCodeExtension`](#uninstall-vscodeextension) | Uninstall extensions via the `code` CLI |

---

### Find-VSCodeExtension

Queries the VS Code Marketplace Gallery API and returns matching extensions with key metadata. Supports fuzzy search by keyword and exact lookup by extension ID.

**Syntax**

```powershell
# Fuzzy search
Find-VSCodeExtension [-Query] <string> [-PageSize <int>] [-SortBy <string>]

# Exact lookup
Find-VSCodeExtension -ExtensionId <string> [-Version <string>] [-PageSize <int>] [-SortBy <string>]
```

**Parameters**

| Parameter | Description | Default |
|---|---|---|
| `-Query` | Keyword to search for | *(required)* |
| `-ExtensionId` | Exact `publisher.name` ID | *(required in exact mode)* |
| `-Version` | Specific version to target | Latest |
| `-PageSize` | Number of results (1–100) | `10` |
| `-SortBy` | `Relevance`, `Downloads`, `Rating`, `PublishedDate` | `Relevance` |

**Output properties:** `Publisher`, `ExtensionId`, `DisplayName`, `Version`, `TargetPlatforms`, `Downloads`, `Rating`, `Description`, `VsixUrl`

**Examples**

```powershell
# Search by keyword
Find-VSCodeExtension -Query "git"

# Search sorted by most downloads, returning top 20
Find-VSCodeExtension -Query "python" -PageSize 20 -SortBy Downloads

# Look up a specific extension
Find-VSCodeExtension -ExtensionId "eamodio.gitlens"

# Look up a specific version
Find-VSCodeExtension -ExtensionId "eamodio.gitlens" -Version "16.3.0"
```

---

### Save-VSCodeExtension

Downloads one or more VS Code extensions as `.vsix` files. Accepts pipeline input from `Find-VSCodeExtension` or a direct URL.

**Syntax**

```powershell
# From extension object (pipeline)
Save-VSCodeExtension -Extension <PSCustomObject[]> [-Destination <string>]

# From URL
Save-VSCodeExtension -Url <string[]> [-Destination <string>]
```

**Parameters**

| Parameter | Description | Default |
|---|---|---|
| `-Extension` | Extension object(s) from `Find-VSCodeExtension` | *(required)* |
| `-Url` | Direct VSIX download URL(s) | *(required in URL mode)* |
| `-Destination` | Folder to save the `.vsix` file(s) | Current directory |

**Examples**

```powershell
# Save a specific extension to C:\vsix
Find-VSCodeExtension -ExtensionId "eamodio.gitlens" | Save-VSCodeExtension -Destination C:\vsix

# Save multiple search results
Find-VSCodeExtension -Query "python" -PageSize 3 | Save-VSCodeExtension -Destination C:\vsix

# Save from a direct URL
Save-VSCodeExtension -Url "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/eamodio/vsextensions/gitlens/16.3.0/vspackage"
```

---

### Install-VSCodeExtension

Installs a VS Code extension using the `code` CLI. Can install directly from a pipeline extension object, a VSIX URL, or a local `.vsix` file.

**Syntax**

```powershell
# From extension object (pipeline)
Install-VSCodeExtension -Extension <PSCustomObject> [-Destination <string>] [-CodeExecutable <string>]

# From URL
Install-VSCodeExtension -Url <string> [-Destination <string>] [-CodeExecutable <string>]

# From local file
Install-VSCodeExtension -File <string> [-CodeExecutable <string>]
```

**Parameters**

| Parameter | Description | Default |
|---|---|---|
| `-Extension` | Extension object from `Find-VSCodeExtension` | *(required)* |
| `-Url` | VSIX download URL | *(required in URL mode)* |
| `-File` | Path to a local `.vsix` file | *(required in file mode)* |
| `-Destination` | Temp folder for downloaded VSIX | `$env:TEMP` |
| `-CodeExecutable` | Path to the `code` binary | Auto-detected via `Get-Command` |

**Examples**

```powershell
# Find and install in one pipeline
Find-VSCodeExtension -ExtensionId "eamodio.gitlens" | Install-VSCodeExtension

# Install from a local VSIX file
Install-VSCodeExtension -File "C:\vsix\eamodio.gitlens-16.3.0.vsix"

# Install from a direct URL
Install-VSCodeExtension -Url "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/eamodio/vsextensions/gitlens/16.3.0/vspackage"
```

---

### Uninstall-VSCodeExtension

Uninstalls a VS Code extension by its `publisher.name` ID using the `code` CLI.

**Syntax**

```powershell
Uninstall-VSCodeExtension -Extension <string> [-CodeExecutable <string>]
```

**Parameters**

| Parameter | Description | Default |
|---|---|---|
| `-Extension` | The `publisher.name` ID of the extension to remove | *(required)* |
| `-CodeExecutable` | Path to the `code` binary | Auto-detected via `Get-Command` |

**Examples**

```powershell
# Uninstall GitLens
Uninstall-VSCodeExtension -Extension "eamodio.gitlens"
```

---

## Common Pipelines

```powershell
# Search → Save → Install in one line
Find-VSCodeExtension -ExtensionId "ms-python.python" | Install-VSCodeExtension

# Download the top 5 most-downloaded Git extensions
Find-VSCodeExtension -Query "git" -PageSize 5 -SortBy Downloads | Save-VSCodeExtension -Destination C:\vsix

# Find a specific version and save it offline
Find-VSCodeExtension -ExtensionId "ms-vscode.csharp" -Version "2.0.0" | Save-VSCodeExtension -Destination C:\offline-extensions
```

## Author

**Stephen Valdinger** — [VSCodeMarketplace v1.0.0](VSCodeMarketPlace.psd1)

## License

Copyright (c) Stephen Valdinger. All rights reserved.
