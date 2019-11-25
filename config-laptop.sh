#!/bin/bash
sudo chef-client --local-mode -o 'recipe[chef-yum-docker::default]','recipe[laptop::default]'  
