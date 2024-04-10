 # Nvidia GPU
 # usage:
 # ./compress_gpu_normal.ps1 ./inputs/ ./outputs/ 0
param (
    [string]$InPath,
    [string]$OutPath,
    [int]$GPUNumber
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
    ffmpeg -hide_banner -i $SourceFile -c:v h264_nvenc -gpu $GPUNumber -cq 28 -multipass 2 -preset:v p7 -profile:v 2 -c:a aac  $OutFilePath
  }
}

# -gpu n set use gpu n
# https://arstech.net/choose-gpu-in-ffmpeg/
# Write-Output $OutPath
# Get-ChildItem $InPath | Where-Object {$_.Name.EndsWith(".mp4")}
