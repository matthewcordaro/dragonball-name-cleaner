# Get file list in directory
$files = Get-ChildItem -Path $sourceDir | Where-Object {! $_.PSIsContainer }

foreach($file in $files){
  $newName = $file.Name
  # Only Operate on the correct files
  if (!($file.Name.Substring(0,6) -eq "[DBNL]")) {
    # Truncate first part "[DBNL] "
    $newName = $newName.Remove(0,7)
    
    # Remove last ~20 after 'DR' 
    # like: " [DR] [xx...xx]"
    $indexOfDR = $newName.IndexOf(" [DR]")
    $indexOfMKV = $newName.IndexOf(".mkv")
    $deleteNum = $indexOfMKV - $indexOfDR
    $newName = $newName.Remove($indexOfDR,$deleteNum)
    
    Rename-Item $file.Name $newName
  }
}
