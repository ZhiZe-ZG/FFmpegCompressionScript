# Update all mirror git repositories in the specified directory
param (
    [string]$WorkPath
)

Get-ChildItem -Path $WorkPath --Directory -Filter ".git" | ForEach-Object {
    $repoPath = $_.DirectoryName
    Write-Host "Updating repository at $repoPath"
    Set-Location -Path $repoPath
    git remote update
}