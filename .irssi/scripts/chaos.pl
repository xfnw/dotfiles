use strict;
use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = "1.0";
%IRSSI = (
    authors => 'LickTheCheese',
    name => 'stop banning me khux',
    description => 'what did i ever do to you',
    license => 'GNU GPL v2 or later',
);

sub bit
{
       my($server) =@_;


        $server->command("MSG #chaos ,kick *");
        $server->command("KICK #chaos BitBot");

}

sub ub
{
        my($server) = @_;
        
        $server->command("JOIN #chaos");
        Irssi::timeout_add_once(10, "bit", $server );        
}


sub uchaos
{
	my($data, $server, $witem, $time, $text) = @_;

	$server->command("MSG ChanServ UNBAN #chaos");
        Irssi::timeout_add_once(300, "ub", $server );        
	
}

Irssi::command_bind uchaos => \&uchaos;

