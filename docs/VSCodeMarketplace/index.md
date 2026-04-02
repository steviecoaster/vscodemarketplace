# VSCodeMarketPlace Module

## Description

A wrapper for the VSCode marketplace that allows searching, saving, installing, and uninstalling VSCode extensions.

**Module Version:** 1.0.0  
**Author:** Stephen Valdinger  
**Module GUID:** 46decfeb-9e8d-4771-9ce0-18a9d5fd02d6

## Commands

### [Find-VSCodeExtension](Find-VSCodeExtension.md)

Searches the Visual Studio Code Marketplace via the public Gallery API. Supports fuzzy keyword search and exact lookup by extension ID.

### [Install-VSCodeExtension](Install-VSCodeExtension.md)

Installs a VS Code extension using the Code CLI. Accepts pipeline input from `Find-VSCodeExtension`, a direct VSIX URL, or a local `.vsix` file.

### [Save-VSCodeExtension](Save-VSCodeExtension.md)

Downloads one or more VS Code extensions as `.vsix` files. Useful for offline or air-gapped environments.

### [Uninstall-VSCodeExtension](Uninstall-VSCodeExtension.md)

Uninstalls a VS Code extension by its `publisher.name` ID using the Code CLI.
