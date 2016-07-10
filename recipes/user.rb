#
# Cookbook Name:: dsc_workshop
# Recipe:: user
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

dsc_resource 'testuser' do
  resource :user
  property :username, 'testuser'
  property :password, ps_credential('P2ssw0rd!')
end
