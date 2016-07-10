#
# Cookbook Name:: dsc_workshop
# Recipe:: website
#
# Copyright 2016 Chef Software
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'dsc_workshop::default'

dsc_resource 'webserver' do
  resource :windowsfeature
  property :name, 'web-server'
end

dsc_resource 'website' do
  resource :xwebsite
  module_name ps_module_spec('xWebAdministration', '1.10.0.0')
  property :name, 'Default Web Site'
  property :state, 'Stopped'
end

directory 'c:/sites/coffee' do
  recursive true
  action :create
end

file 'c:/sites/coffee/index.html' do
  content 'hi'
  action :create
end

dsc_resource 'newwebsite' do
  resource :xwebsite
  module_name ps_module_spec('xWebAdministration', '1.10.0.0')
  property :name, 'Coffee'
  property :state, 'Started'
  property :physicalpath, 'c:\sites\coffee'
  property :bindinginfo , cim_instance_array(
                            'MSFT_xWebBindingInformation',
                            Protocol: 'http',
                            Port: 80
                          )
end
