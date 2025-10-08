# Ensure the mail service (Postfix) stays active on the minion
check-mail-service:
  service.running:
    - name: postfix
    - enable: True
    - reload: True
    - retry:
        attempts: 3
        interval: 10
