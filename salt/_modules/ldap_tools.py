# -*- coding: utf-8 -*-
# Simple wrappers around ldapmodify/ldappasswd so you can call from SLS with module.run
import subprocess

__virtualname__ = 'ldap_tools'

def __virtual__():
    return __virtualname__

def modify(ldif_path, binddn, password, uri='ldap://127.0.0.1'):
    cmd = ['ldapmodify', '-x', '-H', uri, '-D', binddn, '-w', password, '-f', ldif_path]
    return __salt__['cmd.run_all'](' '.join(map(lambda x: x if ' ' not in x else '"%s"' % x, cmd)))

def set_password(dn, new_password, binddn, password, uri='ldap://127.0.0.1'):
    cmd = ['ldappasswd', '-x', '-H', uri, '-D', binddn, '-w', password, '-s', new_password, dn]
    return __salt__['cmd.run_all'](' '.join(map(lambda x: x if ' ' not in x else '"%s"' % x, cmd)))
