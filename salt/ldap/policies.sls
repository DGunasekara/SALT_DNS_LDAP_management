/etc/sudoers.d/ldap:
  file.managed:
    - source: salt://ldap/files/sudoers_ldap.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: '0440'
