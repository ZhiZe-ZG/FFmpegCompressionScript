# ./compress_cpu_high.ps1 ./inputs/ ./outputs/
param (
    [string]$InPath,
    [string]$OutPath
)

$SuffixList = @(".wav", ".WAV", ".s3m", ".ogg")
$OutSuffix = ".aac"

$SourceFiles = Get-ChildItem $InPath

foreach ($SourceFile in $SourceFiles) {
  $InPutSuffix = $SourceFile.Name.Split(".")[-1]
  $InPutSuffix = "." + $InPutSuffix
  if ($SuffixList.Contains($InPutSuffix)){
    Write-Output "Now Processing:"
    Write-Output $SourceFile
    $OutFilePath = $OutPath + $SourceFile.Name.Replace($InPutSuffix, $OutSuffix)
    Write-Output $OutFilePath
    ffmpeg -hide_banner -i $SourceFile -c:a aac  $OutFilePath
  }
}
