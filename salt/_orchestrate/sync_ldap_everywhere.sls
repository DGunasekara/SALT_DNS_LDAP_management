# Apply LDAP schema/config and user changes to all LDAP servers
run-highstate-ldap:
  salt.state:
    - tgt: 'roles:ldap'
    - tgt_type: grain
    - sls:
      - ldap.schemas
      - ldap.users
      - ldap.passwords
      - ldap.groups
      - ldap.disable_delete
