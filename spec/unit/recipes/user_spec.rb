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

describe 'dsc_workshop::user' do
  context 'When on Windows 2012 R2' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012R2')
      runner.converge(described_recipe)
    end

    before do
      expect_any_instance_of(Chef::Resource::DscResource).to receive(:ps_credential).
        with('P2ssw0rd!').
        and_return('P2ssw0rd!')
    end

    it 'uses dsc_resource to ensure a testuser is present' do
      expect(chef_run).to run_dsc_resource('testuser').with(
        resource: :user,
        properties: {
          username: 'testuser',
          password: 'P2ssw0rd!'
        }
      )
    end
  end
end
