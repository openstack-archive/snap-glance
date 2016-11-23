# Glance Snap

This repository contains the source code of the snap for the OpenStack Image
service, Glance.

## Installing this snap

The glance snap can be installed directly from the snap store:

    sudo snap install [--edge] glance

## Configuring Glance

Snaps run in an AppArmor and seccomp confined profile, so don't read
configuration from `/etc/glance` on the hosting operating system install.

This snap supports configuration via the $SNAP\_COMMON writable area for the
snap:

    etc
    ├── glance
    │   ├── glance-api.conf
    │   └── glance-registry.conf
    └── glance.conf.d
        ├── database.conf
        ├── glance-snap.conf
        └── keystone.conf

The glance daemons (api and registry) can be configured in a few ways.

Firstly each daemon will detect and read `etc/glance/glance-<daemon>.conf`
if it exists so you can just place all configuration in this file for each
daemon.

Alternatively all daemons will load all configuration files from
`etc/glance.conf.d` - in the above example, database and keystone authtoken
onfiguration is shared across both daemons using configuration snippets in
separate files in `etc/glance.conf.d`.

For reference, $SNAP\_COMMON is typically located under
`/var/snap/glance/common`.

## Managing Glance

Currently all snap binaries must be run as root; for example, to run the
glance-manage binary use:

    sudo glance.manage

## Restarting Glance services

To restart all glance services:

    sudo systemctl restart snap.glance.*

or use the individual service name:

    sudo systemctl restart snap.glance.api
    sudo systemctl restart snap.glance.registry

## Support

Please report any bugs related to this snap on
[Launchpad](https://bugs.launchpad.net/snap-glance/+filebug).

Alternatively you can find the OpenStack Snap team in `#openstack-snaps`
on Freenode IRC.
