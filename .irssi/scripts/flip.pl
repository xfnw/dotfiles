use strict;
use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = "1.0";
%IRSSI = (
    authors => 'LickTheCheese',
    name => 'flip bot',
    description => 'a bot that you get coins from lol',
    license => 'GNU GPL v2 or later',
);

sub event_privmsg {
my ($server, $data, $nick, $mask, $target) =@_;
my ($target, $text) = $data =~ /^(\S*)\s:(.*)/;
        if ( index($text, "cheese flips tails and wins") != -1 ) {
	    $server->command ( "msg $target ,sendcoins leekthecheese 100" );
            $server->command ( "msg $target ,flip tails all" );
      	}
}
Irssi::signal_add('event privmsg', 'event_privmsg');
