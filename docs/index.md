# VSCodeMarketplace

A PowerShell module that wraps the Visual Studio Code Marketplace public Gallery API, letting you search, download, install, and uninstall VS Code extensions entirely from the command line.

## Features

- **Search** the Marketplace by keyword or exact extension ID
- **Download** extensions as `.vsix` files for offline or air-gapped use
- **Install** extensions directly via the `code` CLI
- **Uninstall** extensions by ID using the `code` CLI
- Full **pipeline support** — find, save, and install in a single one-liner

## Requirements

- PowerShell 5.1 or PowerShell 7+
- The `code` CLI must be on your `PATH` (required for `Install-VSCodeExtension` and `Uninstall-VSCodeExtension`)

## Quick Start

```powershell
# Import the module
Import-Module VSCodeMarketplace

# Search for an extension
Find-VSCodeExtension -Query "git"

# Find and install in one pipeline
Find-VSCodeExtension -ExtensionId "eamodio.gitlens" | Install-VSCodeExtension

# Download for offline use
Find-VSCodeExtension -ExtensionId "ms-python.python" | Save-VSCodeExtension -Destination C:\vsix

# Uninstall an extension
Uninstall-VSCodeExtension -Extension "eamodio.gitlens"
```

## Available Commands

| Command | Description |
|---|---|
| [Find-VSCodeExtension](VSCodeMarketPlace/Find-VSCodeExtension.md) | Search the VS Code Marketplace |
| [Install-VSCodeExtension](VSCodeMarketPlace/Install-VSCodeExtension.md) | Install extensions via the `code` CLI |
| [Save-VSCodeExtension](VSCodeMarketPlace/Save-VSCodeExtension.md) | Download extensions as VSIX files |
| [Uninstall-VSCodeExtension](VSCodeMarketPlace/Uninstall-VSCodeExtension.md) | Uninstall extensions via the `code` CLI |
