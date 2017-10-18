#!/bin/bash

set -ex

source $BASE_DIR/admin-openrc

sudo mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS glance;
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' \
  IDENTIFIED BY 'glance';
EOF

while sudo [ ! -d /var/snap/glance/common/etc/glance/ ]; do sleep 0.1; done;
sudo cp -r $BASE_DIR/etc/snap-glance/* /var/snap/glance/common/etc/
# sudo cp -r $BASE_DIR/etc/* /var/snap/glance/common/etc/

openstack user show glance || {
    openstack user create --domain default --password glance glance
    openstack role add --project service --user glance admin
}

openstack service show image || {
    openstack service create --name glance --description "OpenStack Image" image
    for endpoint in internal admin public; do
        openstack endpoint create --region RegionOne \
            image $endpoint http://localhost:9292 || :
    done
}

# Manually define alias if snap isn't installed from snap store.
# Otherwise, snap store defines this alias automatically.
snap aliases glance | grep glance-manage || sudo snap alias glance.manage glance-manage

sudo glance-manage db_sync

sudo systemctl restart snap.glance.*

while ! nc -z localhost 9292; do sleep 0.1; done;

openstack image show cirros || {
    [ -f $HOME/images/cirros-0.3.5-x86_64-disk.img ] || {
        export http_proxy=$SNAPSTACK_HTTP_PROXY
        mkdir -p $HOME/images
        wget \
          http://download.cirros-cloud.net/0.3.5/cirros-0.3.5-x86_64-disk.img \
          -O ${HOME}/images/cirros-0.3.5-x86_64-disk.img
        unset http_proxy
    }
    openstack image create --file ${HOME}/images/cirros-0.3.5-x86_64-disk.img \
        --public --container-format=bare --disk-format=qcow2 cirros
}
