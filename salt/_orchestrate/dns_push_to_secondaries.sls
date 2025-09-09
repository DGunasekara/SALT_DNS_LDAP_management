# After zone changes, reload primary and notify secondaries
reload-all-zones:
 salt.function:
   - name: cmd.run
   - tgt: {{ pillar['dns']['primary'] }}
   - arg:
   - 'for z in $(grep -E "zone \".*\"" /etc/bind/named.conf.local | awk '{print $2}' | tr -d '"'); do rndc reload $z; done'

notify-secondaries:
  salt.function:
    - name: cmd.run
    - tgt: {{ pillar['dns']['primary'] }}
    - arg:
      - 'rndc notify'
