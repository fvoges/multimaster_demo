#!/bin/bash

rm -rf /etc/puppetlabs/puppet/environments/production/
puppet module install zack-r10k --modulepath=/etc/puppetlabs/puppet/modules/
git clone https://github.com/fvoges/multimaster_demo.git puppet/environments/production

puppet apply -t setup_r10k.pp
