#
# Cookbook Name:: qa-chef-server-cluster
# Recipes:: frontend-upgrade
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
  action :upgrade
  package_url node['qa-chef-server-cluster']['chef-server']['url']
  install_method node['qa-chef-server-cluster']['chef-server']['install_method']
  version node['qa-chef-server-cluster']['chef-server']['version']
  integration_builds node['qa-chef-server-cluster']['chef-server']['integration_builds']
  repository node['qa-chef-server-cluster']['chef-server']['repo']
end

chef_package 'manage' do
  action :upgrade
  package_url node['qa-chef-server-cluster']['opscode-manage']['url']
  install_method node['qa-chef-server-cluster']['opscode-manage']['install_method']
  version node['qa-chef-server-cluster']['opscode-manage']['version']
  integration_builds node['qa-chef-server-cluster']['opscode-manage']['integration_builds']
  repository node['qa-chef-server-cluster']['opscode-manage']['repo']
  reconfigure true
  not_if { current_server.product_name == 'open_source_chef' }
end

