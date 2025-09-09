{% if pillar['dns'].get('dnssec', {}).get('enabled', False) %}
{{ pillar['dns']['dnssec']['keydir'] }}:
  file.directory:
    - user: bind
    - group: bind
    - mode: '0750'

/usr/local/sbin/dnssec-rollover.sh:
  file.managed:
    - source: salt://dns/files/dnssec-rollover.sh.j2
    - template: jinja
    - mode: '0750'

{%- for z in pillar['dns']['zones'] %}
dnssec-cron-{{ z.name }}:
  cron.present:
    - name: "/usr/local/sbin/dnssec-rollover.sh {{ z.name }} {{ pillar['dns']['dnssec']['keydir'] }}"
    - user: root
    - minute: {{ pillar['dns']['dnssec']['rollover_cron'].split()[0] }}
    - hour: {{ pillar['dns']['dnssec']['rollover_cron'].split()[1] }}
    - daymonth: {{ pillar['dns']['dnssec']['rollover_cron'].split()[2] }}
    - month: {{ pillar['dns']['dnssec']['rollover_cron'].split()[3] }}
    - dayweek: {{ pillar['dns']['dnssec']['rollover_cron'].split()[4] }}
{%- endfor %}
{% endif %}
