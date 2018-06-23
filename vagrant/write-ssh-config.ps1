# vagrant up
$fileText = vagrant ssh-config | ForEach-Object {$_ -replace 'C:/', '/mnt/c/'}

$vagrantFolder = "~/.vagrant_keys"
bash -c "mkdir -p $vagrantFolder"
bash -c "chmod 700 $vagrantFolder"
$bashkeyFiles = $fileText | Select-String -Pattern "/mnt/c" -CaseSensitive
foreach ($item in $bashkeyFiles) {
    $index = $bashkeyFiles.IndexOf($item)
    $oldFilename = $item -replace '^(.*)/mnt/c/', '/mnt/c/'
    $newFilename = $vagrantFolder + "/private_key" + $index
    bash -c "cp $oldFilename $newFilename"
    bash -c "chmod 600 $newFilename"
    $fileText = $fileText | ForEach-Object { $_ -replace $oldFilename, $newFilename }
}
$fileText | Out-File -FilePath "vagrant-ssh.cfg" -Encoding ASCII
bash -c "mv ./vagrant-ssh.cfg $vagrantFolder/vagrant-ssh.cfg"
bash -c "chmod 644 $vagrantFolder/vagrant-ssh.cfg"

$ansibleCfg = Get-Content "../ansible/ansible.cfg" | ForEach-Object { $_ -replace "(~)|(/home/[^/]*)", (bash -c "readlink -e ~") } 
$ansibleCfg | Out-File "../ansible/ansible.cfg" -Encoding ASCII
