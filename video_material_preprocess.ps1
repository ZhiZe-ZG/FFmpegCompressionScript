# ./compress_cpu_high.ps1 ./inputs/ ./outputs/
param (
    [string]$InPath = "./in/",
    [string]$OutPath = "./out/"
)

Write-Output "Input Path: $InPath"
Write-Output "Output Path: $OutPath"

$SuffixList = @(".mp4", ".mkv", ".avi", ".AVI", ".bik", ".wmv", ".flv")
$OutSuffix = ".mp4"

$SourceFiles = Get-ChildItem $InPath

foreach ($SourceFile in $SourceFiles) {
  $InPutSuffix = "." + $SourceFile.Name.Split(".")[-1]
  if ($SuffixList.Contains($InPutSuffix)){
    Write-Output "Now Processing: $SourceFile"
    $OutFilePath = $OutPath + $SourceFile.Name.Replace($InPutSuffix, $OutSuffix)
    Write-Output "Output As: $OutFilePath"
    ffmpeg -i $SourceFile -c:v copy -c:a aac -filter:a "loudnorm=I=-12:LRA=9:TP=-2" $OutFilePath
  }
}
