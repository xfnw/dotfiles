use strict;
use warnings;
use Irssi;

our $VERSION = '0.0.1';
our %IRSSI = (
    authors     => 'launchd',
    contact     => 'me@zpld.me',
    name        => 'chghost',
    description => 'implement support for https://ircv3.net/specs/extensions/chghost.html',
    license     => 'MIT',
    changed     => '5/20/2021'
);

Irssi::theme_register([
    chghost   => '{channick_hilight $0} {nickhost $1} has changed hostname to {hilight $2}',
]);

Irssi::signal_add('event chghost', sub {
    my ($server, $data, $nick, $oldhost) = @_;

    my @parts = split m/ /, $data;
    my $newhost = "$parts[0]\@$parts[1]";

    # Print the notification to all shared channels, and the nick's query if any
    for my $c ($server->channels) {
        $c->printformat(MSGLEVEL_NICKS, 'chghost', $nick, $oldhost, $newhost) if $c->nick_find($nick);
    }
    my $q = $server->query_find($nick);
    $q->printformat(MSGLEVEL_NICKS, 'chghost', $nick, $oldhost, $newhost) if defined $q;
    Irssi::signal_stop();
});
    

Irssi::signal_add('event connected', sub {
    my ($server) = @_;

    if ($server->{chat_type} eq 'IRC')
    {
          $server->irc_server_cap_toggle('chghost', 1);
    }
});


if (!Irssi::Irc::Server->can('irc_server_cap_toggle')) {
    die 'this version of irssi is not supported';
}

for my $server (Irssi::servers()) {
    if ($server->{chat_type} eq 'IRC')
    {
          $server->irc_server_cap_toggle('chghost', 1);
    }
}
