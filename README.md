# Glance Snap

This repository contains the source code of the snap for the OpenStack Image
service, Glance.

## Installing this snap

The glance snap can be installed directly from the snap store:

    sudo snap install --edge --classic glance

The glance snap is working towards publication across tracks for
OpenStack releases. The edge channel for each track will contain the tip
of the OpenStack project's master branch, with the beta, candidate and
release channels being reserved for released versions. These three channels
will be used to drive the CI process for validation of snap updates. This
should result in an experience such as:

    sudo snap install --classic --channel=ocata/stable glance
    sudo snap install --classic --channel=pike/edge glance

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
        └── conf.d
            └── glance-snap.conf

The glance snap supports configuration updates via its $SNAP_COMMON writable
area. The default glance configuration can be overridden as follows:

    /var/snap/glance/common/etc/
    └── glance
        ├── conf.d
        │   ├── glance-snap.conf
        │   ├── database.conf
        │   └── rabbitmq.conf
        ├── glance-api.conf
        ├── glance-manage.conf
        └── glance-registry.conf

The glance configuration can be overridden or augmented by writing
configuration snippets to files in the conf.d directory.

Alternatively, glance configuration can be overridden by adding full config
files to the glance/ directory. If overriding in this way, you'll need to
either point these config files at additional config files located in $SNAP,
or add those to $SNAP_COMMON as well.

## Logging glance

The services for the glance snap will log to its $SNAP_COMMON writable area:
/var/snap/glance/common/log.

## Managing glance

The glance snap will drop privileges to run daemons and commands under
a regular user named snap-glance. Additionally, permissions and ownership
of files and directories in /var/snap/glance/common/ are modified to
restrict access from other users.

The glance snap has alias support that enables use of the well-known
glance-manage command. To enable the alias, run the following prior to
using the command:

    sudo snap alias glance.manage glance-manage

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
