slapd-pkgs:
  pkg.installed:
    - names:
    - slapd
    - ldap-utils

/etc/ldap/ldap.conf:
  file.managed:
    - source: salt://ldap/files/ldap.conf.j2
    - template: jinja
    - context:
        uri: {{ pillar['ldap']['uri'] }}
        base: {{ pillar['ldap']['base_dn'] }}
    - user: root
    - group: root
    - mode: '0644'

slapd-service:
  service.running:
    - name: slapd
    - enable: True
    - watch:
      - file: /etc/ldap/ldap.conf
