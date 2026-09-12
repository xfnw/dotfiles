use strict;
use Irssi;

use vars qw($VERSION %IRSSI);
$VERSION = "1.0";
%IRSSI =
( name => "nn"
, description => "window number but checks if the number is taken"
, license => "CC0-1.0"
);

Irssi::command_bind("nn", sub {
	my($data, $server, $witem) = @_;
	if (Irssi::window_find_refnum($data)) {
		Irssi::active_win->print("refnum " . $data . " already in use");
	} else {
		Irssi::command("WINDOW NUMBER " . $data);
	}
});
