{%- for u in pillar.get('ldap', {}).get('hr', {}).get('users', []) %}
/root/pass-{{ u.uid }}.ldif:
  file.managed:
    - source: salt://ldap/files/set-password.ldif.j2
    - template: jinja
    - context: { user: {{ u|tojson }} }

setpw-{{ u.uid }}:
  cmd.run:
    - name: ldapmodify -x -D '{{ pillar['ldap']['admin_dn'] }}' -w '{{ pillar['ldap']['admin_pw'] }}' -f /root/pass-{{ u.uid }}.ldif
    - onchanges:
    - file: /root/pass-{{ u.uid }}.ldif
{%- endfor %}
