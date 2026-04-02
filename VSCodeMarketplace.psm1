$Public = @(Get-ChildItem -Path "$PSScriptRoot\public\*.ps1" -ErrorAction SilentlyContinue)

foreach ($file in $Public) {
    try {
        . $file.FullName
    }
    catch {
        Write-Error "Failed to import $($file.FullName): $_"
    }
}