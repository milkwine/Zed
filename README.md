# NAME

Zed - Remote execution shell over SSH

# SYNOPSIS

    # Just run zed
    > zed

    Welcome nobody~!
    (Type 'help' to show more commands)

    # set your username used by ssh/scp
    > nobody@zed> set username foo

    # add a group servers
    > foo@zed> add first_group
    myserver1.bar.com
    myserver{2~9}.bar.com
    [CTRL+D]
    add servers hosts[9] suc!

    # show the servers added just now
    > foo@zed> dump first_group

    # use a group as your target
    > foo@zed> use first_group 

    # run command over ssh
    > foo@zed> cmd ls /tmp

    # run command with sudo
    > foo@zed> cmd sudo ls /root

    # port detection
    > foo@zed> port 80
    
    # checkout the results to group
    > foo@zed> checkout

    # then you can use the suc group
    > foo@zed> use default.suc

    # show more commands
    > help

# DESCRIPTION

Zed is remote execution shell over SSH with many plugins to help you to manage servers.

Features below:

- execution over SSH
- transfer file over scp
- port detection
- flexible way to manage targets
- easy to type cmd with completion

(Servers will not disconnect until you quit. So Large mount of servers may cause memory problem)

# ENV

    $ENV{ZED_HOME}: zed working dir, default $HOME/.zed

# CONF

    $ENV{ZED_HOME}/Space: 

      #targets defined here.
      ---
      foo:
      - 127.0.0.1
      none: ~

    $ENV{ZED_HOME}/Env: 

      ---
      username: nobody

      #idc is the name of a regex to identify servers group.
      #batch idc 1. Pick 1 server of each group identified by regex idc to build new targets.
      batch:
        idc: ^.+?\..+?\.(.+?)\.

      #short command to complete real command
      macro:
        ip: cmd /sbin/ip addr|grep inet|grep -v 127.0.0.1|awk "{print \$2}"|awk -F"/" "{print \$1}"

      #plugins to load
      plugin:
      - Zed::Plugin::Sys::Echo
      ...
      - Zed::Plugin::Host::Checkout

# AUTHOR

SiYu Zhao <zuyis@cpan.org>

# COPYRIGHT

Copyright 2016- SiYu Zhao

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO
