{% if 'bind9' in data.get('services', {}) %}
bind9-restart:
  local.service.running:
    - tgt: {{ data['id'] }}
    - arg:
    - name: bind9
{% endif %}
