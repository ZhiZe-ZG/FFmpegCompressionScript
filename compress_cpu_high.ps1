# ./compress_cpu_high.ps1 ./inputs/ ./outputs/
param (
    [string]$InPath,
    [string]$OutPath
)

$SuffixList = @(".mp4", ".mkv")
$OutSuffix = ".mp4"

$SourceFiles = Get-ChildItem $InPath

foreach ($SourceFile in $SourceFiles) {
  $InPutSuffix = $SourceFile.Name.Split(".")[-1]
  $InPutSuffix = "." + $InPutSuffix
  if ($SuffixList.Contains($InPutSuffix)){
    Write-Output "Now Processing:"
    Write-Output $SourceFile
    $OutFilePath = $OutPath + $SourceFile.Name.Replace($InPutSuffix, $OutSuffix)
    Write-Output $OutFilePath
    ffmpeg -hide_banner -i $SourceFile -c:v libx264 -crf 18 -preset:v medium -profile:v high -c:a aac  $OutFilePath
  }
}
