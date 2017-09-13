
include:
  - .keyring
  - ..configuration

install rgw:
  pkg.installed:
    - name: ceph-radosgw

{% for role in salt['pillar.get']('rgw_configurations', [ 'rgw' ]) %}
start {{ role }}:
  service.running:
    - name: ceph-radosgw@{{ role + "." + grains['host'] }}
    - enable: True
    - watch:
        - file: /etc/ceph/ceph.conf

{% endfor %}

