{%- for u in pillar.get('ldap', {}).get('hr', {}).get('users', []) %}
/root/groups-{{ u.uid }}.ldif:
  file.managed:
    - source: salt://ldap/files/group-membership.ldif.j2
    - template: jinja
    - context: { user: {{ u|tojson }} }

apply-groups-{{ u.uid }}:
  cmd.run:
    - name: ldapmodify -x -D '{{ pillar['ldap']['admin_dn'] }}' -w '{{ pillar['ldap']['admin_pw'] }}' -f /root/groups-{{ u.uid }}.ldif
    - unless: "{% for g in u.get('groups', []) %}ldapsearch -x -D '{{ pillar['ldap']['admin_dn'] }}' -w '{{ pillar['ldap']['admin_pw'] }}' -b '{{ pillar['ldap']['base_dn'] }}' '(&(cn={{ g }})(memberUid={{ u.uid }}))' | grep '^dn:' && {% endfor %} true"
{%- endfor %}
