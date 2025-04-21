#!/bin/bash

podman pod stop Bastion_Guacamole

podman pod rm Bastion_Guacamole

podman pod prune
