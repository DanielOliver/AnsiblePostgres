# Get the Vagrant SSH with paths for Windows-Subsystem-Linux
$fileText = vagrant ssh-config | ForEach-Object {$_ -replace 'C:/', '/mnt/c/'}

# Save vagrant SSH to this path
$vagrantFolder = "~/.vagrant_keys"
bash -c "mkdir -p $vagrantFolder"
bash -c "chmod 700 $vagrantFolder"
# Each of the private key files
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

# Ansible likes absolute path instead of tilda for home path.
$ansibleCfg = Get-Content "../ansible/ansible.cfg" | ForEach-Object { $_ -replace "(~)|(/home/[^/]*)", (bash -c "readlink -e ~") } 
$ansibleCfg | Out-File "../ansible/ansible.cfg" -Encoding ASCII
