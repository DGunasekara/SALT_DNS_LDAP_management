check-bind9:
  service.running:
    - name: bind9
    - enable: True
    - restart: True
