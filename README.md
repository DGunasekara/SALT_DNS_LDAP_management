# SALT_DNS_LDAP_management
This is a repo where the testing and modification is done for tasks for DNS and LDAP management.

**The files are under modification and to be updated with the testing**

Tasks are listed below:

1. LDAP / User Account Management
  - Provision new user accounts via Salt States or custom modules.
  - Reset passwords and enforce expiry policies.
  - Disable or delete accounts for students/staff who have left.
  - Synchronize LDAP schemas and configurations across multiple servers.
  - Monitor LDAP service health and automatically restart if failed.
  - Perform automated periodic backups of the LDAP database.
  - Update user group memberships dynamically based on HR or enrollment systems.
  - Push access policies (sudoers, group access) based on LDAP roles.

2. DNS Server Management
  - Add, update, and delete DNS records dynamically.
  - Perform zone file syntax validation before deployment.
  - Generate zone files from templates.
  - Monitor DNS service and restart automatically on failure.
  - Automate DNSSEC key rollovers and deployment.
  - Propagate zone changes to secondary DNS servers.
  - Track and audit DNS configuration changes with Git integration.

### Repo layout
```
salt/
  top.sls
  ldap/
    init.sls # meta include for ldap states
    server.sls # install & configure slapd
    schemas.sls # sync schemas
    users.sls # provision users
    passwords.sls # reset/expire passwords
    disable_delete.sls # disable or delete accounts
    groups.sls # dynamic group membership from HR pillar
    policies.sls # sudoers, access policies
    backup.sls # automated backups + rotation
    monitor.sls # beacons + service watch
    files/
      ldap.conf.j2
      olcDatabase-config.ldif.j2
      olcDatabase-mdb.ldif.j2
      add-user.ldif.j2
      set-password.ldif.j2
      disable-user.ldif.j2
      delete-user.ldif.j2
      group-membership.ldif.j2
      sudoers_ldap.conf.j2
      backup_ldap.sh.j2
  dns/
    init.sls # meta include for dns states
    bind.sls # install & base config
    zones.sls # create/validate/deploy zones from templates
    dnssec.sls # keys + rollover automation
    monitor.sls # beacons + service watch
    git_audit.sls # Git tracking for /etc/bind
    files/
      named.conf.options.j2
      named.conf.local.j2
      zone.db.j2
      dnssec-rollover.sh.j2
  _reactors/
    ldap_service_autoheal.sls
    dns_service_autoheal.sls
  _orchestrate/
    sync_ldap_everywhere.sls
    dns_push_to_secondaries.sls
  _modules/
    ldap_tools.py # optional helpers (wrap ldapmodify/ldappasswd)

pillar/
  top.sls
  ldap.sls
  dns.sls

```
