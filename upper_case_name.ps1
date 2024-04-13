# rename all files with upper case
param (
    [string]$InPath = "./in/"
    # [string]$OutPath = "./out/"
)

# Define the path to the 7-Zip executable
# $7zipPath = "7z"

# Get all child folders in the specified path
$files = Get-ChildItem -Path $InPath -File

# Loop through each folder
foreach ($file in $files) {
    $suffixName = "." + $file.Name.Split(".")[-1]
    # Define the name of the archive (folder name + .zip)
    $fileNewName = $file.FullName.Replace($suffixName, "").ToUpper() + $suffixName
    # Rename file
    Rename-Item -Path $file.FullName -NewName $fileNewName
}