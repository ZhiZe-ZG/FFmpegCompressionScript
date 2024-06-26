# This script is used to process the videos made by me and will be posted.
# ./process_post_video.ps1 ./inputs/ ./outputs/
param (
    [string]$InPath = "./in/",
    [string]$OutPath = "./out/"
)

Write-Output "Input Path: $InPath"
Write-Output "Output Path: $OutPath"

$SuffixList = @(".mp4", ".mkv")
$OutSuffix = ".mkv"

$SourceFiles = Get-ChildItem $InPath

foreach ($SourceFile in $SourceFiles) {
  $InPutSuffix = "." + $SourceFile.Name.Split(".")[-1]
  if ($SuffixList.Contains($InPutSuffix)){
    Write-Output "Now Processing: $SourceFile"
    $OutFilePath = $OutPath + $SourceFile.Name.Replace($InPutSuffix, $OutSuffix)
    Write-Output "Output As: $OutFilePath"
    ffmpeg -i $SourceFile -map 0:0 -map 0:1 -c:v libx264 -crf 18 -preset:v veryslow -profile:v high -c:a aac -ar 48000 -metadata:s:v:0 'language=zho' -metadata:s:a:0 'language=zho' $OutFilePath
  }
}
