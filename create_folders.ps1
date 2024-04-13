# create folder for each file
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
    $folderName = $file.FullName.Replace($suffixName, "")
    # create folder
    New-Item -ItemType Directory -Force -Path $folderName
    # move file to folder
    Move-Item -Path $file.FullName -Destination $folderName
}