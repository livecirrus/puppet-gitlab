# init -> packages -> user -> setup -> install -> config -> service  
 class gitlab::setup inherits gitlab {
     
  vcsrepo {"${gitlab::git_home}/gitlab-shell":
    provider  => git,
    ensure    => present,
    source    => "${gitlab::gitlabshell_sources}",
    revision  => "${gitlab::gitlabshell_branch}",
    user     =>  "${gitlab::git_user}"
  }  

  vcsrepo {"${gitlab::git_home}/gitlab":
    provider  => git,
    ensure    => present,
    source    => "${gitlab::gitlab_sources}",
    revision  => "${gitlab::gitlab_branch}",
    user     =>  "${gitlab::git_user}"
  }  
   
  # Copy the gitlab-shell config
  file { "${gitlab::git_home}/gitlab-shell/config.yml":
    ensure    =>  file,
    content   =>  template('gitlab/gitlab-shell.erb'),
    owner     =>  "${gitlab::git_user}",
    group     =>  'git',
    require   =>  [
              Vcsrepo["${gitlab::git_home}/gitlab-shell"],
              Vcsrepo["${gitlab::git_home}/gitlab"],
                  ],
  }
  
  
  # Copy the gitlab config
  file { "${gitlab::git_home}/gitlab/config/gitlab.yml":
    ensure    =>  file,
    content   =>  template("gitlab/gitlab.yml.${gitlab::gitlab_branch}.erb"),
    owner     =>  "${gitlab::git_user}",
    group     =>  'git',  
    require   =>  [
              Vcsrepo["${gitlab::git_home}/gitlab-shell"],
              Vcsrepo["${gitlab::git_home}/gitlab"],
                  ],
  }
  
  # Copy the Unicorn config
  file { "${gitlab::git_home}/gitlab/config/unicorn.rb":
    ensure    =>  file,
    content   =>  template("gitlab/unicorn.rb.${gitlab::gitlab_branch}.erb"),
    owner     =>  "${gitlab::git_user}",
    group     =>  'git',
    require   =>  [
              Vcsrepo["${gitlab::git_home}/gitlab-shell"],
              Vcsrepo["${gitlab::git_home}/gitlab"],
                  ],
  }
  
  # Copy the database config
  file { "${gitlab::git_home}/gitlab/config/database.yml":
    ensure    =>  file,
    content   =>  template('gitlab/database.yml.erb'),
    owner     =>  "${gitlab::git_user}",
    group     =>  'git',
    mode      =>  '0640',
    require   =>  [
              Vcsrepo["${gitlab::git_home}/gitlab-shell"],
              Vcsrepo["${gitlab::git_home}/gitlab"],
                  ],
  }

}# end setup.pp
