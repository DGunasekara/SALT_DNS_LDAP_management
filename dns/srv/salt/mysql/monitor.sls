# Ensure the MySQL service stays active on the minion
check-mysql-service:
  service.running:
    - name: mysql
    - enable: True
    - reload: True
    - retry:
        attempts: 3
        interval: 10
