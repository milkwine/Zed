package Zed::Plugin::Exe::Cmd;
use Zed::Plugin;

use Zed::SSHPool;
use Zed::Config::Env;
use Zed::Config::Space;
use Zed::Output;

use strict;

=head1 SYNOPSIS

    cmd CMD 
    ex:
        cmd ls /
        cmd echo hello

=cut


our %CMD = ( quote_args => 0, stderr_discard => 1);

invoke "cmd" => sub {
    my (@cmd, $ssh_opt, @host) = @_;

    return unless @host = targets();

    debug("host: ", \@host );

    $ssh_opt = env("ssh_options");
    my $has_private_key = ref $ssh_opt eq "HASH" and $ssh_opt->{key_path};

    if($cmd[0] eq 'sudo' && !$has_private_key)
    {
        my $pwd = passwd();
        shift @cmd;
        @cmd = ( { stdin_data => "$pwd\n", %CMD }, 'sudo -k;', 'sudo', '-S', '-p', '', '--', @cmd );

    }else{

        @cmd = ( { %CMD }, @cmd );
    }
    
    debug("last cmd: |" => \@cmd);

    Zed::SSHPool::run(\@host => 'cmd', @cmd);
};

1;
