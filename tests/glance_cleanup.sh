#!/bin/bash

set -ex

sudo mysql -u root << EOF
DROP DATABASE glance;
EOF"""
