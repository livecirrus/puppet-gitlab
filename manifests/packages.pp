# Class gitlab::packages
# Sets up rquirements for gitlab
# This class is optional, dependingo on what $gitlab_manage_packages is set to
# if set to false, you must manually install all the packages below

# init -> packages -> user -> setup -> install -> config -> service
class gitlab::packages inherits gitlab {
      
  $system_packages = [
                    'libicu-dev',
                    'python2.7',
                    'python-docutils',
                    'libxml2-dev',
                    'libxslt1-dev',
                    'python-dev',
                    'build-essential',
                    'libmysqlclient-dev',
                    'redis-server',
                    'logrotate',
                    'sudo',
                    'git-core'
                      ]
  ensure_packages($system_packages)  

}# end packages.pp
