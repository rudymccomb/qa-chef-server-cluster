#
# Cookbook Name:: qa-chef-server-cluster
# Recipes:: frontend
#
# Author: Patrick Wright <patrick@chef.io>
# Copyright (C) 2015, Chef Software, Inc. <legal@getchef.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'qa-chef-server-cluster::node-setup'

chef_package current_server.package_name do
  package_url node['qa-chef-server-cluster']['chef-server']['url']
  version node['qa-chef-server-cluster']['chef-server']['version']
  channel node['qa-chef-server-cluster']['chef-server']['channel']
  config node['qa-chef-server-cluster']['chef-server-config']
  reconfigure true
end

chef_package 'manage' do
  package_url node['qa-chef-server-cluster']['opscode-manage']['url']
  version node['qa-chef-server-cluster']['opscode-manage']['version']
  channel node['qa-chef-server-cluster']['opscode-manage']['channel']
  reconfigure true
  not_if { current_server.product_name == 'open_source_chef' }
end

# TODO: (pwright) Run again for all I care!!!  Not really.  Temp hack for lack of dns
execute 'add hosts entry' do
  command "echo '#{node['ipaddress']} #{node['fqdn']} #{node['qa-chef-server-cluster']['chef-server']['api_fqdn']}' >> /etc/hosts"
end

# TODO: check this out from chef-server cookbook
# ruby_block 'ensure node can resolve API FQDN' do
#   extend ChefServerCoobook::Helpers
#   block { repair_api_fqdn }
#   only_if { api_fqdn_node_attr }
#   not_if { api_fqdn_resolves }
# end
