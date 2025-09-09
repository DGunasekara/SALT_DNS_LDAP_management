{%- for z in pillar['dns']['zones'] %}
/etc/bind/zones/{{ z.name }}.db:
  file.managed:
    - source: salt://dns/files/zone.db.j2
    - template: jinja
    - context: { zone: {{ z|tojson }} }
    - makedirs: True

validate-{{ z.name }}:
  cmd.run:
    - name: named-checkzone {{ z.name }} /etc/bind/zones/{{ z.name }}.db
    - onchanges:
    - file: /etc/bind/zones/{{ z.name }}.db

reload-{{ z.name }}:
  cmd.wait:
    - name: rndc reload {{ z.name }}
    - watch:
    - cmd: validate-{{ z.name }}

{%- endfor %}
