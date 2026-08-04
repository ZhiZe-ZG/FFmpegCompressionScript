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
      let input_path = ($in_path | path join $source_file.name)
      let output_path = ($out_path | path join $output_name)

      print $"Now Processing: ($source_file.name)"
      print $"Output As: ($output_path)"

      ffmpeg -hide_banner -y -i $input_path -map "0:v?" -map "0:a?" -map_metadata 0 -map_chapters 0 -c:v libaom-av1 -crf 30 -b:v 0 -cpu-used 4 -row-mt 1 -pix_fmt yuv420p -c:a libopus -b:a 128k -tag:v "av01" -tag:a "opus" -movflags "+faststart" -sn -dn $output_path
    }
  }
}
