/usr/local/sbin/backup_ldap.sh:
  file.managed:
    - source: salt://ldap/files/backup_ldap.sh.j2
    - template: jinja
    - mode: '0750'

ldap-backup-cron:
  cron.present:
    - name: '/usr/local/sbin/backup_ldap.sh'
    - user: root
    - minute: {{ pillar['ldap']['backup']['schedule'].split()[0] }}
    - hour: {{ pillar['ldap']['backup']['schedule'].split()[1] }}
    - daymonth: {{ pillar['ldap']['backup']['schedule'].split()[2] }}
    - month: {{ pillar['ldap']['backup']['schedule'].split()[3] }}
    - dayweek: {{ pillar['ldap']['backup']['schedule'].split()[4] }}
