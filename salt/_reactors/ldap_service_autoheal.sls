{% if 'slapd' in data.get('services', {}) %}
slapd-restart:
  local.service.running:
    - tgt: {{ data['id'] }}
    - arg:
      - name: slapd
{% endif %}
