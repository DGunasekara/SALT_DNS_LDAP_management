# Install BIND9
bind9:
  pkg.installed:
    - name: bind9

# Ensure service is running and enabled
bind9-service:
  service.running:
    - name: bind9
    - enable: True
    - reload: True
    - watch:
      - pkg: bind9
      - file: /etc/bind/named.conf.options
      - file: /etc/bind/named.conf.local

# Deploy basic config (optional)
named-conf-options:
  file.managed:
    - name: /etc/bind/named.conf.options
    - source: salt://dns/named.conf.options
    - user: root
    - group: root
    - mode: 644

named-conf-local:
  file.managed:
    - name: /etc/bind/named.conf.local
    - source: salt://dns/named.conf.local
    - user: root
    - group: root
    - mode: 644
