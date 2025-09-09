dns:
  primary: dns1.learn.ac.lk
  secondaries:
    - dns2.learn.ac.lk
    - dns3.learn.ac.lk
  bind:
    allow_transfer: [192.0.2.2, 192.0.2.3]
    also_notify: [192.0.2.2, 192.0.2.3]
    listen_on: [127.0.0.1, 0.0.0.0]
    recursion: false
  zones:
    - name: learn.ac.lk
      ttl: 3600
      soa:
        mname: ns1.learn.ac.lk.
        rname: hostmaster.learn.ac.lk.
        serial_strategy: epoch # or "pillar"
      ns: [ns1.learn.ac.lk., ns2.learn.ac.lk.]
      a:
        - { name: '@', ip: 203.143.1.10 }
        - { name: 'idp', ip: 203.143.1.20 }
      cname:
        - { name: 'www', target: '@' }
      txt:
        - { name: '@', text: 'v=spf1 mx -all' }
  dnssec:
    enabled: true
    keydir: /etc/bind/keys
    rollover_cron: '15 2 * * 0' # weekly check
