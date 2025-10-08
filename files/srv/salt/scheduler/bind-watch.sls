# Drop a dedicated schedule file on the minion and reload the scheduler
/etc/salt/minion.d/bind-watch.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - contents: |
        schedule:
          bind-watch:
            function: state.single
            args:
              - service.running
            kwargs:
              name: bind9        # change to 'named' on Alpine/RHEL
              enable: True
            seconds: 60
            run_on_start: True
            splay: 10
            jid_include: True
            maxrunning: 1

schedule-reload:
  module.run:
    - name: schedule.reload
    - require:
      - file: /etc/salt/minion.d/bind-watch.conf
