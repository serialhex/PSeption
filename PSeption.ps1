
function PSeption {
  param($File)

  $fitem = Get-Item $File
  $dir = $fitem.DirectoryName
  $fname = $fitem.BaseName

  $raw_bytes = Get-Content -Path $File -Encoding Byte -Raw
  $out_str = "PowerShell -NoProfile -ExecutionPolicy Bypass -Command `n"
  foreach ($byte in $raw_bytes) {
    # Escape characters provided by:
    # https://www.robvanderwoude.com/escapechars.php
    switch ($byte) {
      {[int][char]'!' -eq $_} {
        $out_str += "^^!"
        Break
      }

      {[int][char]'^' -eq $_} {
        $out_str += "^^"
        Break
      }

      {[int][char]'&' -eq $_} {
        $out_str += "^&"
        Break
      }

      {[int][char]'<' -eq $_} {
        $out_str += "^<"
        Break
      }

      {[int][char]'>' -eq $_} {
        $out_str += "^>"
        Break
      }

      {[int][char]'|' -eq $_} {
        $out_str += "^|"
        Break
      }

      {[int][char]'&' -eq $_} {
        $out_str += "^&"
        Break
      }

      {[int][char]'%' -eq $_} {
        $out_str += "%%"
        Break
      }

      {[int][char]"`n" -eq $_} {
        $out_str += "\`n"
        Break
      }

      default { $out_str += [char]$_ }
    }
  }

  $out_str += "`n}"

  Write-Output "writing to: `"$dir\$fname.bat`""
  Set-Content -Path "$dir/$fname.bat" -Value $out_str
}


# Quine it
# PSeption -File PSeption.ps1

PSeption -File $args[0]
