use strict;
use vars qw($VERSION %IRSSI);

use Irssi;

$VERSION = '1.00';
%IRSSI = (
        authors         => 'launchd',
        contact         => 'me@zpld.me',
        name            => 'smartbans',
        description     => 'Compute good ban/quiet masks',
        license         => '',
        changed         => ""
);

sub casefold {
    return shift =~ tr/A-Z\[\]\^\\/a-z{}~|/r;
}

my %WAIT_WHO = ();

sub do_action {
    my ($server, $channel, $nickname, $mask, $account, $actions, $reason) = @_;
    my @acts = split(",", $actions);
    if ($reason eq "") {$reason = $nickname}
    $server->print($channel, "[%gsmartbans%N] channel: $channel / nick: $nickname / mask: $mask / account: \$a:$account");
    foreach (@acts) {
        if ($_ eq "quiet") {
            $server->command("QUOTE MODE $channel +q $mask");
        }
        elsif ($_ eq "ban") {
            $server->command("QUOTE MODE $channel +b $mask");
        }
        elsif ($_ eq "kick") {
            $server->command("QUOTE KICK $channel $nickname :$reason");
        }
        elsif ($_ eq "remove") {
            $server->command("QUOTE REMOVE $channel $nickname :$reason");
        }
        elsif ($_ eq "debug") {
            # nothing to do here
        }
        else {
            # do nothing
        }
    }
}

Irssi::Irc::Server::redirect_register(
    "sban whox",
    0,
    0,
    { "event 354" => 5 },
    { "event 315" => 1 },
    undef
);

Irssi::signal_add('redir sban-whox', sub {
    my ($server, $data, $nick, $address) = @_;
    my @parts = split m/ /, $data;
    if ($parts[1] ne '519') {
        Irssi::print("smartbans caught something wrong: $server $data");
    }
    else {
        my $nickname = $parts[5];
        my $username = $parts[2];
        my $address  = $parts[3];
        my $hostname = $parts[4];
        my $account  = $parts[6];


        my ($ban_user, $ban_host) = ($username, $hostname);
        my $actions = $WAIT_WHO{casefold $nickname}[0];
        my $nickname = $WAIT_WHO{casefold $nickname}[1];
        my $channel = $WAIT_WHO{casefold $nickname}[2];
        my $reason = $WAIT_WHO{casefold $nickname}[3];
        delete $WAIT_WHO{casefold $nickname};
        if ($hostname =~ m,/,) {
            if ($hostname =~ m,^(gateway|nat)/,) {
                if ($hostname =~ m,/session$, || # syn is busy
                    $hostname =~ m,/x-[a-z]+$,)  # /x- session token
                {
                    # chop of last / and onward. replace with /*
                    $hostname =~ s,/[^/]+$,/*,;
                    $ban_user = $username;
                    $ban_host = $hostname;
                    if ($hostname =~ m,gateway/web/irccloud.com,) {
                        $ban_user =~ s,^(u|s)id,\?id,;
                    }
                }
                elsif ($hostname =~ m,/ip\.([^/]+)$,) {
                    # @../ip.1.2.3.4 - just replace with @1.2.3.4
                    $ban_user = "*";
                    $ban_host = "*/ip.$1";
                }
            }
            elsif ($address == "127.0.0.1" || $address == "255.255.255.255") {
                $ban_host = $hostname;
            }
            else {
                $ban_host = $address;
            }            
        }
        elsif ($hostname =~ m/\S+\.irccloud\.com/)
        {
            $ban_user =~ s,^(u|s)id,\?id,;
            $ban_host = "*.irccloud.com";
        }
        else {
            $ban_host = $address;
        }
        if ($username =~ m,^~,) {
            $ban_user = '*';
        }
        do_action $server, $channel, $nickname, "*!$ban_user\@$ban_host", $account, $actions, $reason;
    }
});

sub on_command
{
    my($data, $server, $witem, $actions) = @_;
    if (!$witem) {
        Irssi::print("[%rsmartbans%N] The current buffer is not a channel.");
        Irssi::signal_stop();
    }
    if ($data =~ m/^(\S+)+/) {
        my @args = split(" ", $data, 2);
        my $target = $args[0];
        my $reason = "";
        if (scalar(@args) > 1)
        {
            $reason = $args[1];
        }
        my $chan = $witem->{name};
        $WAIT_WHO{casefold $target} = [$actions, $target, $chan, $reason];
        $server->redirect_event("sban whox", 1, $target, -1, undef, {
            'event 354' => 'redir sban-whox',
            ''          => 'event empty'
        });
        $server->send_raw("WHO $target %hintua,519");
    }
    else {
        # bad args, do nothing
    }
}

Irssi::command_bind('squiet', sub {
    my($data, $server, $witem) = @_;
    on_command $data, $server, $witem, 'quiet';
});

Irssi::command_bind('sban', sub {
    my($data, $server, $witem) = @_;
    on_command $data, $server, $witem, 'ban';
});

Irssi::command_bind('skb', sub {
    my($data, $server, $witem) = @_;
    on_command $data, $server, $witem, 'ban,kick';
});

Irssi::command_bind('srb', sub {
    my($data, $server, $witem) = @_;
    on_command $data, $server, $witem, 'ban,remove';
});

Irssi::command_bind('sdebug', sub {
    my($data, $server, $witem) = @_;
    on_command $data, $server, $witem, 'debug';
});
