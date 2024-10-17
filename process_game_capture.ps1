# This script is used to process the captured game videos.
# Example:
# ./process_game_capture.ps1 ./inputs/ ./outputs/
param (
  [string]$InPath="./in/",
  [string]$OutPath="./out/",
  [string]$DeviceName = "CPU"
)

# GPU index number
$GPUNumber = 0 # usually just one GPU and the index number is 0

# constant variables
$SuffixList = @(".mp4", ".mkv", ".avi")
$OutSuffix = ".mp4"

# check device
if ($DeviceName -eq "CPU") {
  # $Device = "libx264"
}
elseif ($DeviceName -eq "GPU_NVIDIA") {
  Write-Output "Warning!!! The compression quality of GPU is generally worse than that of CPU!"
  Write-Output "It give a larger file size with the same compression quality!"
  Write-Output "Sometimes it may even be larger than the original file!"
  Write-Output "This task not use GPU yet!"
  exit
  # $Device = "h264_nvenc"
}
else {
  Write-Output "Device Name Error!"
  exit
}

# get source file paths
if (Test-Path $InPath) {
  $SourceFiles = Get-ChildItem $InPath
}
else{
  Write-Output "Input Path Error!"
  exit
}

# make sure output path exists
if (-not (Test-Path $OutPath)) {
  New-Item -ItemType Directory -Force -Path $OutPath
}

foreach ($SourceFile in $SourceFiles) {
  $InPutSuffix = $SourceFile.Name.Split(".")[-1]
  $InPutSuffix = "." + $InPutSuffix
  if ($SuffixList.Contains($InPutSuffix)) {
    Write-Output "Now Processing:"
    Write-Output $SourceFile
    $OutFilePath = $OutPath + $SourceFile.Name.Replace($InPutSuffix, $OutSuffix)
    Write-Output $OutFilePath
    if ($DeviceName -eq "CPU"){
      # The -map 0 select all tracks
      ffmpeg -hide_banner -i $SourceFile -map 0 -c:v libx264 -crf 18 -preset:v veryslow -profile:v high -c:a aac  $OutFilePath
    }
    elseif ($DeviceName -eq "GPU_NVIDIA") {
      # not fully tested yet
      ffmpeg -hide_banner -i $SourceFile -map 0 -c:v h264_nvenc -gpu $GPUNumber -cq 18 -multipass 2 -preset:v slow -profile:v high -c:a aac  $OutFilePath
    }
  }
}
