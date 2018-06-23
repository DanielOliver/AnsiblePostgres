# AnsiblePostgres

Example PostgreSQL install with Ansible on Vagrant for local machine testing.

## Environment

Here's what my installs look like:

* Windows 10 Home Edition
* [VirtualBox 5.2.8][0]
    * _Note that this is installed as administrator._
* [Vagrant 2.1.1][2]
* [Windows Subsystem For Linux (Ubuntu 16.04)][1]
* [pgAdmin 4 v3.0][4]

On that Windows Subsystem for Linux I have these installed:

* Python 2.7.12
* [Ansible 2.5.0][3]

## pgAdmin credentials

Now on local machine open up pgAdmin and add three new servers.

* Names: db0, db1, db2
* Host: 127.0.0.1
* Ports: 5432, 5433, 5434
* Maintenance DB: example_db
* User: example_user
* Password: supersecure

[0]: https://www.virtualbox.org/
[1]: https://docs.microsoft.com/en-us/windows/wsl/install-win10
[2]: https://www.vagrantup.com/
[3]: https://docs.ansible.com/ansible/2.5/user_guide/windows_faq.html
[4]: https://www.pgadmin.org/
