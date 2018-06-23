cd vagrant
vagrant up
./write-ssh-config.ps1
cd ../ansible
bash -c "ansible-galaxy install geerlingguy.postgresql"
bash -c "ansible-playbook postgres-playbook.yml"
