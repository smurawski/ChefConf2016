#
# Cookbook Name:: dsc_workshop
# Spec:: default
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


require 'spec_helper'

describe 'dsc_workshop::website' do
  context 'When on Windows 2012 R2' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012R2')
      runner.converge(described_recipe)
    end

    before do
      stub_command("(Get-Module xWebAdministration -list) -ne $null").and_return(true)
      allow_any_instance_of(Chef::Resource::DscResource).to receive(:cim_instance_array).and_return('binding_info')
    end

    it 'uses dsc_resource to validate the web-server windows feature' do
      expect(chef_run).to run_dsc_resource('webserver').with(
        resource: :windowsfeature,
        properties: {
          name: 'web-server'
        }
      )
    end

    it 'uses dsc_resource to validate the default website is stopped' do
      expect(chef_run).to run_dsc_resource('website').with(
        resource: :xwebsite,
        module_name: "@{ModuleName='xWebAdministration';RequiredVersion='1.10.0.0'}",
        properties: {
          name: 'Default Web Site',
          state: 'Stopped'
        }
      )
    end

    it 'uses dsc_resource to validate a new website exits' do
      expect(chef_run).to run_dsc_resource('newwebsite').with(
        resource: :xwebsite,
        module_name: "@{ModuleName='xWebAdministration';RequiredVersion='1.10.0.0'}",
        properties: {
          name: 'Coffee',
          state: 'Started',
          physicalpath: 'c:\sites\coffee',
          bindinginfo: 'binding_info'
        }
      )
    end
  end
end
