[System.IO.DirectoryInfo] $ModuleRoot = (Get-Item -Path $PSScriptRoot).Parent.Parent
[String] $ManifestPath = "$($ModuleRoot.FullName)\$($ModuleRoot.Name).psd1"
[Hashtable] $Manifest = Invoke-Expression -Command (Get-Content -Path $ManifestPath -Raw)
[String[]] $FoldersToScan = @("Classes", "Private", "Public")
[String[]] $ScannedFiles = @()
foreach ($Folder in $FoldersToScan)
{
    Get-ChildItem -Path "$(Join-Path -Path $ModuleRoot.FullName -ChildPath $Folder)" -Recurse -File |
        Select-Object -ExpandProperty FullName | ForEach-Object {
            $ScannedFiles += $_.Replace($ModuleRoot.FullName, "")
        }
}
[String[]] $ManifestFiles = $Manifest.NestedModules

# Identify files referenced in the manifest that are not found in the scanned folders.
[String[]] $MissingReferencedFiles = $ManifestFiles | Where-Object { $_ -notin $ScannedFiles }
if ($MissingReferencedFiles)
{
    $WarningMessage = "The following files exist in the module manifest but are not found in the scanned " +
    "folders: '$($FoldersToScan -join "', '")'."
    Write-Warning $WarningMessage

    $MissingReferencedFiles | ForEach-Object { Write-Warning $_ }
}

# Identify files in the scanned folders that are not found in the manifest.
[String[]] $MissingScannedFiles = $ScannedFiles | Where-Object { $_ -notin $ManifestFiles }
if ($MissingScannedFiles)
{
    $WarningMessage = "The following files exist in the scanned directories but are not referenced in the " +
    "module manifest."
    Write-Warning $WarningMessage

    $MissingScannedFiles | ForEach-Object { Write-Warning $_ }
}

if ($MissingReferencedFiles -or $MissingScannedFiles)
{
    exit 1
}