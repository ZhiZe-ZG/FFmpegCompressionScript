#!/usr/bin/env nu
# ./compress_folder_av1_opus.nu ./inputs/ ./outputs/
def main [
  in_path: string = "./in/"
  out_path: string = "./out/"
] {
  let suffix_list = [
    ".mp4"
    ".mkv"
    ".avi"
    ".wmv"
    ".flv"
    ".mov"
    ".m4v"
    ".webm"
  ]

  mkdir $out_path

  print $"Input Path: ($in_path)"
  print $"Output Path: ($out_path)"

  let source_files = (ls $in_path | where type == file)

  for source_file in $source_files {
    let file_info = ($source_file.name | path parse)
    let input_suffix = ($".($file_info.extension)" | str downcase)

    if ($suffix_list | any {|suffix| $suffix == $input_suffix }) {
      let output_name = $"($file_info.stem).mp4"
      let input_path = $source_file.name
      let output_path = ($out_path | path join $output_name)

      print $"Now Processing: ($source_file.name)"
      print $"Output As: ($output_path)"

      ffmpeg -hide_banner -y -threads 0 -i $input_path -map "0:v?" -map "0:a?" -c:v libaom-av1 -crf 30 -cpu-used 8 -c:a libopus -movflags "+faststart" $output_path
    }
  }
}
