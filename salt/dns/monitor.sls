bind-beacon:
  beacons.present:
    - name: service
    - enable: True
    - beacon_module: service
    - services:
        bind9: { interval: 30 }
