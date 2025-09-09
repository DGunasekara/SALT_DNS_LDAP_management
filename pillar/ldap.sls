ldap:
  domain: learn.ac.lk
  base_dn: dc=learn,dc=ac,dc=lk
  admin_dn: cn=admin,dc=learn,dc=ac,dc=lk
  admin_pw: "{{ vault.ldappw | default('CHANGEME') }}" # recommend sops/age vault
  uri: ldapi:/// # or ldap://127.0.0.1
  servers:
    - idp1.learn.ac.lk
    - idp2.learn.ac.lk

# HR feed to drive user/group states (example structure)
hr:
  users:
    - uid: s12345
      cn: Student One
      sn: One
      givenName: Student
      mail: s12345@learn.ac.lk
      ou: Students
      groups: [students, linux-club]
      shell: /bin/bash
    - uid: jsmith
      cn: John Smith
      sn: Smith
      givenName: John
      mail: jsmith@learn.ac.lk
      ou: Staff
      groups: [staff, sysadmin]
      shell: /bin/bash
  disabled_uids: ["olduser1", "graduated2024"]

backup:
  dir: /var/backups/ldap
  keep_days: 14
  schedule: '0 2 * * *' # daily 02:00
