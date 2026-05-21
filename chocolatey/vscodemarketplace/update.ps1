#import-module au

# Remove any stale AU functions left in scope from a previous run
Remove-Item Function:au_SearchReplace -ErrorAction SilentlyContinue

$moduleName = 'VSCodeMarketplace'

function global:au_BeforeUpdate() {
    do {
        $tempPath = Join-Path -Path $env:TEMP -ChildPath ([GUID]::NewGuid()).ToString()
    }
    while (Test-Path $tempPath)

    New-Item -Path $tempPath -ItemType Directory | Out-Null

    # Save-PSResource creates: $tempPath\VSCodeMarketplace\<version>\*
    Save-PSResource -Name $moduleName -Version $Latest.ModuleVersion -Path $tempPath -TrustRepository

    $modulePath = Join-Path -Path $tempPath -ChildPath $moduleName -AdditionalChildPath $Latest.ModuleVersion

    # Stage contents under a named folder so the ZIP root is VSCodeMarketplace\
    # Without this, Get-ChocolateyUnzip extracts files directly into the Modules folder
    # instead of into Modules\VSCodeMarketplace\
    $stageModulePath = Join-Path -Path $tempPath -ChildPath 'stage' -AdditionalChildPath $moduleName
    New-Item -Path $stageModulePath -ItemType Directory | Out-Null
    Copy-Item -Path "$modulePath\*" -Destination $stageModulePath -Recurse

    $zipPath = Join-Path -Path $tempPath -ChildPath "$moduleName.zip"
    # Compress the folder itself (not \*) so the ZIP root is VSCodeMarketplace\
    Compress-Archive -Path (Join-Path -Path $tempPath -ChildPath 'stage' -AdditionalChildPath $moduleName) -DestinationPath $zipPath -CompressionLevel Optimal

    Move-Item -Path $zipPath -Destination 'tools\' -Force
}

function global:au_GetLatest {
    $module = Find-PSResource -Name $moduleName -Repository PSGallery
    $version = $module.Version.ToString()

    return @{
        Version       = $version
        ModuleVersion = $version
    }
}

# ChecksumFor is none because the ZIP is generated locally during update, not downloaded
update -ChecksumFor none -NoCheckChocoVersion