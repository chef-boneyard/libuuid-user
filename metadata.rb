name             'libuuid-user'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Apache-2.0'
description      'Set a non-login shell for the libuuid user on Ubuntu/Debian and validate that it is correct.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.1'

%w(ubuntu debian).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/libuuid-user'
issues_url 'https://github.com/chef-cookbooks/libuuid-user/issues'
chef_version '>= 12.1' if respond_to?(:chef_version)
