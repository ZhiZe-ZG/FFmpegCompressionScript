# ./process_old_game_capture.ps1 ./inputs/ ./outputs/
param (
  [string]$InPath="./in/",
  [string]$OutPath="./out/",
  [string]$DeviceName = "CPU"
)

# constant variables
$SuffixList = @(".mp4", ".mkv")
$OutSuffix = ".mp4"

# check device
if ($DeviceName -eq "CPU") {
  # $Device = "libx264"
}
elseif ($DeviceName -eq "GPU_NVIDIA") {
  Write-Output "Warning!!! The compression quality of GPU is generally worse than that of CPU!"
  Write-Output "This taske not use GPU yet!"
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
      ffmpeg -hide_banner -i $SourceFile -c:v libx264 -crf 18 -preset:v veryslow -profile:v high -c:a aac  $OutFilePath
    }
    elseif ($DeviceName -eq "GPU_NVIDIA") {
      # not tested yet
      ffmpeg -hide_banner -i $SourceFile -c:v h264_nvenc -gpu $GPUNumber -cq 18 -multipass 2 -preset:v p7 -profile:v 2 -c:a aac  $OutFilePath
    }
  }
}
