# Ensure the Apache HTTP service stays active on the minion
check-apache-service:
  service.running:
    - name: apache2
    - enable: True
    - reload: True
    - retry:
        attempts: 3
        interval: 10
