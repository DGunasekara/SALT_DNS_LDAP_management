{#
Salt state to add a list of LDAP users in bulk.
Requires pillar data under `ldap:users` and connection details in
`ldap:bind`.
#}
{% set bind = salt['pillar.get']('ldap:bind', {}) %}
{% set users = salt['pillar.get']('ldap:users', []) %}

{% if not bind %}
raise-missing-bind-config:
  test.fail_without_changes:
    - name: "Missing LDAP bind configuration in pillar key 'ldap:bind'"
{% endif %}

{% for user in users %}
create-{{ user.get('uid', loop.index) }}-ldap-user:
  ldap.entry_present:
    - bind:
        host: {{ bind.get('host', 'ldap://127.0.0.1') | json }}
        binddn: {{ bind.get('binddn', '') | json }}
        bindpw: {{ bind.get('bindpw', '') | json }}
        port: {{ bind.get('port', 389) }}
        starttls: {{ bind.get('starttls', False) }}
    - dn: {{ user['dn'] | json }}
    - attributes:
        objectClass: {{ (user.get('objectClass') or ['inetOrgPerson', 'organizationalPerson', 'person', 'top']) | json }}
        cn: {{ user.get('cn', user.get('uid')) | json }}
        sn: {{ user.get('sn', user.get('uid')) | json }}
{% for attr, value in user.items() if attr not in ['dn', 'cn', 'sn', 'uid', 'objectClass'] %}
        {{ attr }}: {{ value | json }}
{% endfor %}
{% endfor %}

{% if not users %}
no-ldap-users-defined:
  test.show_notification:
    - text: "No entries under pillar key 'ldap:users'; nothing to do."
{% endif %}
