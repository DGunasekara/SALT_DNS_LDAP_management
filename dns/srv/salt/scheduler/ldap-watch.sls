# Ensure the LDAP service is checked regularly via the minion scheduler
/etc/salt/minion.d/ldap-watch.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - contents: |
        schedule:
          ldap-watch:
            function: state.single
            args:
              - service.running
            kwargs:
              name: slapd
              enable: True
            seconds: 60
            run_on_start: True
            splay: 10
            jid_include: True
            maxrunning: 1

ldap-schedule-reload:
  module.run:
    - name: schedule.reload
    - require:
      - file: /etc/salt/minion.d/ldap-watch.conf
