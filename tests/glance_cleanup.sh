#!/bin/bash

set -ex

sudo mysql -u root << EOF
DROP DATABASE IF EXISTS glance;
EOF
