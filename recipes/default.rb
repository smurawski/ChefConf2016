#
# Cookbook Name:: dsc_workshop
# Recipe:: default
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

powershell_script 'xWebAdministration' do
  code <<-EOH
    install-packageprovider nuget -force -forcebootstrap
    install-module xWebAdministration -force -requiredversion 1.10.0.0
  EOH
  not_if '(Get-Module xWebAdministration -list) -ne $null'
end

local_configuration_manager 'Setup defaults'
