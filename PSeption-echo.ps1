
# The Echo version of this script
# It "Echoes out" your script to a temp file, and then runs that script.
# Not nearly as fancy as the other version, but pretty cool none the less.

function PSeption {
  param($File)

  $fitem = Get-Item $File
  $dir = $fitem.DirectoryName
  $fname = $fitem.BaseName

  $lines = Get-Content -Path $File
  $out_str = "@echo off`n"
  $out_str += "set WD=%~dp0`n"

  # Prime the pump...
  $out_str += "ECHO `"#`" > `"%WD%PSHELLFILE.ps1`"`n"
  foreach ($line in $lines) {
    if ($line -match "\S+") {
      $out_str += "ECHO $line >> `"%WD%PSHELLFILE.ps1`"`n"
    }
  }

  $out_str += "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"%WD%PSHELLFILE.ps1`"`n"
  $out_str += "rem del `"%WD%PSHELLFILE.ps1`"`n"

  Write-Output "writing to: `"$dir\$fname.bat`""
  Set-Content -Path "$dir/$fname.bat" -Value $out_str
}

# Quine it
PSeption -File PSeption.ps1
