# Ensure the MySQL service is checked regularly via the minion scheduler
/etc/salt/minion.d/mysql-watch.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - contents: |
        schedule:
          mysql-watch:
            function: state.single
            args:
              - service.running
            kwargs:
              name: mysql
              enable: True
            seconds: 60
            run_on_start: True
            splay: 10
            jid_include: True
            maxrunning: 1

mysql-schedule-reload:
  module.run:
    - name: schedule.reload
    - require:
      - file: /etc/salt/minion.d/mysql-watch.conf
