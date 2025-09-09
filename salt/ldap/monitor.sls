slapd-beacon:
  beacons.present:
    - name: service
    - enable: True
    - beacon_module: service
    - services:
        slapd: { interval: 30 }

# Reactor will catch beacon events and ensure service.running
