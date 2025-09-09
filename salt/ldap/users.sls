{%- for u in pillar.get('ldap', {}).get('hr', {}).get('users', []) %}
/root/add-{{ u.uid }}.ldif:
  file.managed:
    - source: salt://ldap/files/add-user.ldif.j2
    - template: jinja
    - context: { user: {{ u|tojson }} }

create-{{ u.uid }}:
  cmd.run:
    - name: ldapadd -x -D '{{ pillar['ldap']['admin_dn'] }}' -w '{{ pillar['ldap']['admin_pw'] }}' -f /root/add-{{ u.uid }}.ldif
    - unless: "ldapsearch -x -D '{{ pillar['ldap']['admin_dn'] }}' -w '{{ pillar['ldap']['admin_pw'] }}' -b '{{ pillar['ldap']['base_dn'] }}' 'uid={{ u.uid }}' | grep '^dn:'"
    - require:
      - service: slapd-service
{%- endfor %}
