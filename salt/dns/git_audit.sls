# Track /etc/bind in a local Git repo for diff/audit
/etc/bind/.git:
  cmd.run:
    - name: |
        set -e
        cd /etc/bind
        [ -d .git ] || git init
        git config user.name "salt"
        git config user.email "salt@{{ grains['fqdn'] }}"
        git add -A
        git commit -m "bootstrap bind config" || true
    - unless: test -d /etc/bind/.git

bind-git-commit:
  cmd.wait:
    - name: |
        cd /etc/bind
        git add -A
        git commit -m "salt update $(date -u +%F-%T)" || true
    - watch:
      - file: /etc/bind/named.conf.options
      - file: /etc/bind/named.conf.local
{%- for z in pillar['dns']['zones'] %}
      - file: /etc/bind/zones/{{ z.name }}.db
{%- endfor %}
