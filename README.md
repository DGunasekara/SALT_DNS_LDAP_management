# SALT_DNS_LDAP_management
This is a repo where the testing and modification is done for tasks for DNS and LDAP management.

**The files are under modification and to be updated with the testing**

Tasks are listed below:

### 1. LDAP / User Account Management

### 2. DNS Server Management

in `dns`, there is a directory `/srv/salt/` there are files to be added in the SALT-Master

Tested on ubuntu 24 server and BIND9 was installed using `init.sls` from SALT-Master.

Phrase 1: It is monitoring DNS service and restart automatically on failure.

after addign files in dns directory

`sudo salt 'server-id state.apply dns`

after ading scheduler file

`sudo salt 'dns' state.apply scheduler.bind-watch`

to check the scheduled tasks

`sudo salt 'dns' schedule.list`



