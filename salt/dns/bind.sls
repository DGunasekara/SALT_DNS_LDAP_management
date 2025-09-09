bind-pkgs:
  pkg.installed:
    - names:
    - bind9
    - dnsutils

/etc/bind/named.conf.options:
  file.managed:
    - source: salt://dns/files/named.conf.options.j2
    - template: jinja
    - user: root
    - group: bind
    - mode: '0644'

/etc/bind/named.conf.local:
  file.managed:
    - source: salt://dns/files/named.conf.local.j2
    - template: jinja

bind9:
  service.running:
    - enable: True
    - watch:
    - file: /etc/bind/named.conf.options
    - file: /etc/bind/named.conf.local
