# Glance Snap

This repository contains the source code of the snap for the OpenStack Image
service, Glance.

## Installing this snap

The glance snap can be installed directly from the snap store:

    sudo snap install --edge glance

The glance snap is working towards publication across tracks for
OpenStack releases. The edge channel for each track will contain the tip
of the OpenStack project's master or stable branch, with the beta, candidate,
and stable channels being reserved for released versions. The same version
will be published progressively to beta, then candidate, and then stable once
CI validation completes for the channel. This should result in an experience
such as:

    sudo snap install --channel=ocata/stable glance
    sudo snap install --channel=pike/edge glance

## Configuring glance

The glance snap gets its default configuration from the following $SNAP
and $SNAP_COMMON locations:

    /snap/glance/current/etc/
    └── glance
        ├── glance-api.conf
        ├── glance-manage.conf
        └── glance-registry.conf

    /var/snap/glance/common/etc/
    └── glance
        └── glance.conf.d
            └── glance-snap.conf

The glance snap supports configuration updates via its $SNAP_COMMON writable
area. The default glance configuration can be overridden as follows:

    /var/snap/glance/common/etc/
    └── glance
        ├── glance.conf.d
        │   ├── glance-snap.conf
        │   ├── database.conf
        │   └── keystone.conf
        ├── glance-api.conf
        ├── glance-manage.conf
        └── glance-registry.conf

The glance configuration can be overridden or augmented by writing
configuration snippets to files in the glance.conf.d directory.

Alternatively, glance configuration can be overridden by adding full config
files to the glance/ directory. If overriding in this way, you'll need to
either point your config at additional config files located in $SNAP, or
add those to $SNAP_COMMON as well.

## Logging glance

The services for the glance snap will log to its $SNAP_COMMON writable area:
/var/snap/glance/common/log.

## Restarting glance services

To restart all glance services:

    sudo systemctl restart snap.glance.*

or an individual service can be restarted by dropping the wildcard and
specifying the full service name.

## Building the glance snap

Simply clone this repository and then install and run snapcraft:

    git clone https://github.com/openstack/snap-glance
    sudo apt install snapcraft
    cd snap-glance
    snapcraft

## Support

Please report any bugs related to this snap at:
[Launchpad](https://bugs.launchpad.net/snap-glance/+filebug).

Alternatively you can find the OpenStack Snap team in `#openstack-snaps` on
Freenode IRC.
