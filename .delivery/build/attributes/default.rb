#
# Cookbook Name:: build
# Attributes:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_attribute 'delivery-red-pill'

default['chef-server-acceptance'] = {}
default['chef-server-acceptance']['identifier'] = 'standalone-clean'
default['chef-server-acceptance']['upgrade'] = false
default['chef-server-acceptance']['delivery-path'] ='/opt/chefdk/embedded/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games'

# By including this recipe we trigger a matrix of acceptance envs specified
# in the node attribute node['delivery-red-pill']['acceptance']['matrix']
if node['delivery']['change']['stage'] == 'acceptance'
  default['delivery-red-pill']['acceptance']['matrix'] = [
    # fresh install of chef_server_version
    'standalone_clean_aws' # ,
    #'tier_clean_aws',
    # 'ha_clean_aws',

    # chef_server_latest_released_version > chef_server_version upgrade testing
    #'standalone_upgrade_aws',
    #'tier_upgrade_aws',
    # 'ha_upgrade_aws',

    # OSC 11.latest > chef_server_version upgrade testing (standalone only)
    #'standalone_osc_upgrade_aws',

    # EC 11.latest > chef_server_version upgrade testing
    #'standalone_ec_upgrade_aws',
    #'tier_ec_upgrade_aws',
    # 'ha_ec_upgrade_aws'
  ]
end

default['chef_server_latest_released_version'] = '12.1.2'
default['chef_server_latest_released_repo'] = 'omnibus-stable-local'
default['chef_server_latest_released_integration_builds'] = false

default['chef_server_test_version'] = '12.2.0'
default['chef_server_test_repo'] = 'omnibus-current-local'
default['chef_server_test_integration_builds'] = true

# Set this attribute to a direct download link (jenkins url) to supercede the chef_server_test-* artifactory attributes
# default['chef_server_test_url_override'] = 'http://wilson.ci.chef.co/view/Chef%20Server%2012/job/chef-server-12-build/lastSuccessfulBuild/architecture=x86_64,platform=ubuntu-10.04,project=chef-server,role=builder/artifact/omnibus/pkg/chef-server-core_12.2.0+20150901045019-1_amd64.deb'

default['ami'] = {
  'ubuntu-14.04' => 'ami-3d50120d',
  'ubuntu-12.04' => 'ami-0f47053f'
}