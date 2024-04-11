# compress each folder separately
param (
    [string]$InPath = "./in/"
    # [string]$OutPath = "./out/"
)

# Define the path to the 7-Zip executable
$7zipPath = "7z"

# Get all child folders in the specified path
$folders = Get-ChildItem -Path $InPath -Directory

# Loop through each folder
foreach ($folder in $folders) {
    # Define the name of the archive (folder name + .zip)
    $archiveName = $folder.FullName + ".7z"
    $files = Get-ChildItem -Path $folder.FullName

    # Use 7-Zip to compress the folder
    & $7zipPath a -t7z -mx7 $archiveName $files
}