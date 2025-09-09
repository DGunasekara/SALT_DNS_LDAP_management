{%- for uid in pillar.get('ldap', {}).get('hr', {}).get('disabled_uids', []) %}
/root/disable-{{ uid }}.ldif:
  file.managed:
    - source: salt://ldap/files/disable-user.ldif.j2
    - template: jinja
    - context: { uid: '{{ uid }}' }

disable-{{ uid }}:
  cmd.run:
    - name: ldapmodify -x -D '{{ pillar['ldap']['admin_dn'] }}' -w '{{ pillar['ldap']['admin_pw'] }}' -f /root/disable-{{ uid }}.ldif
    - unless: "ldapsearch -x -D '{{ pillar['ldap']['admin_dn'] }}' -w '{{ pillar['ldap']['admin_pw'] }}' -b '{{ pillar['ldap']['base_dn'] }}' '(&(uid={{ uid }})(|(shadowExpire=1)(pwdAccountLockedTime=*)))' | grep '^dn:'"
{%- endfor %}
