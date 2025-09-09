# Example: ensure core DB config exists (cn=config LDIFs)
/root/olcDatabase-config.ldif:
  file.managed:
    - source: salt://ldap/files/olcDatabase-config.ldif.j2
    - template: jinja

apply-olcDatabase-config:
  cmd.run:
    - name: ldapmodify -Y EXTERNAL -H ldapi:/// -f /root/olcDatabase-config.ldif
    - unless: "ldapsearch -Y EXTERNAL -H ldapi:/// -b cn=config '(olcSuffix={{ pillar['ldap']['base_dn'] }})' | grep '^dn:'"
    - require:
    - service: slapd-service

/root/olcDatabase-mdb.ldif:
  file.managed:
    - source: salt://ldap/files/olcDatabase-mdb.ldif.j2
    - template: jinja

apply-olcDatabase-mdb:
  cmd.run:
    - name: ldapmodify -Y EXTERNAL -H ldapi:/// -f /root/olcDatabase-mdb.ldif
    - unless: "ldapsearch -Y EXTERNAL -H ldapi:/// -b cn=config '(olcDbDirectory=*)' | grep '^olcDbDirectory:'"
    - require:
      - cmd: apply-olcDatabase-config
