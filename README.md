# SALT_DNS_LDAP_management
This is a repo where the testing and modification is done for tasks for DNS and LDAP management.

**The files are under modification and to be updated with the testing**

Install SALT
```
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public \
  | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp

curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources \
  | sudo tee /etc/apt/sources.list.d/salt.sources


sudo apt update
sudo apt install -y salt-minion
```

Added the master ip to /etc/salt/minion file

Services :
``
sudo systemctl restart salt-minion
sudo systemctl enable salt-minion
``

Tasks are listed below:

### 1. DNS Server Management

in `dns`, there is a directory `/srv/salt/` there are files to be added in the SALT-Master

Tested on ubuntu 24 server and BIND9 was installed using `init.sls` from SALT-Master.

Phrase 1: It is monitoring DNS service and restart automatically on failure.

after addign files in dns directory

`sudo salt 'server-id state.apply dns`

after ading scheduler file

`sudo salt 'dns' state.apply scheduler.bind-watch`

to check the scheduled tasks

`sudo salt 'dns' schedule.list`

### 2. MySQL Service Monitoring

Use `mysql/monitor.sls` to ensure the MySQL service stays enabled and is restarted automatically if it stops:

```
sudo salt '<minion-id>' state.apply mysql.monitor
```

You can also deploy a scheduler job that re-applies the service check every minute:

```
sudo salt '<minion-id>' state.apply scheduler.mysql-watch
```

Afterwards, verify the job is registered with:

```
sudo salt '<minion-id>' schedule.list
```

### 3. LDAP Service Monitoring

Use `ldap/monitor.sls` to keep the LDAP (slapd) service enabled and running automatically:

```
sudo salt '<minion-id>' state.apply ldap.monitor
```

To deploy a scheduler job that re-applies the service check every minute:

```
sudo salt '<minion-id>' state.apply scheduler.ldap-watch
```

Afterwards, verify the job registration with:

```
sudo salt '<minion-id>' schedule.list
```
### 4. Mail Service Monitoring

Use `mail/monitor.sls` to keep the Postfix mail service enabled and running automatically:

```
sudo salt '<minion-id>' state.apply mail.monitor
```

To deploy a scheduler job that re-applies the service check every minute:

```
sudo salt '<minion-id>' state.apply scheduler.mail-watch
```

Afterwards, verify the job registration with:

```
sudo salt '<minion-id>' schedule.list
```



