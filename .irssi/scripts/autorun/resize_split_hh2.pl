use Irssi;
use strict;
use vars qw/$VERSION %IRSSI/;
$VERSION = '1.01+HH2';
%IRSSI = (
   authors     => 'David Leadbeater',
   contact     => 'dgl@dgl.cx',
   name        => 'resize_split',
   description => 'Resizes a split window when it is made active (see comments in script for details)',
   license     => 'GNU GPLv2 or later',
   url         => 'http://irssi.dgl.cx/',
);

# This script is for if you have a split window for status (or anything else)
# it makes it bigger when it's active.
# (The way I have Irssi setup is with a split status window along the top,
# created with /window show 1 in a channel window).
 
# For example you do a command that outputs a large amount of text into
# the status window such as /help or /motd (depending on what you put in
# your status window). Then simply hit alt+up and the status window resizes
# to give you more room to read the output, when you go back to another window
# the status window will automatically go back to its previous size.

# BUGS (mostly due to lack of Irssi API for split windows).
# As far as I can see there is no easy way to find out where in a split a
# window is displayed, so if more than one window is sticky inside a split
# and you set that window in the setting below this script will have problems.
# Also if you have more than 2 split windows things won't work as expected.

# Setting: resize_windows
# A space seperated list of windows that you want to be resized when you
# change to them.
# If it contains something that's not a (permanently displayed) split window
# then windows will probably end up with incorrect sizes.
Irssi::settings_add_str("misc", "resize_windows", "1");

# Don't know how to get the following info automatically from Irssi:
# Set this to the number of status bars you have that are shown only
# when a window is active
Irssi::settings_add_int("misc","resize_num_window_actonly", "0");

Irssi::signal_add("window changed", \&winchg);

sub winchg {
   my($newwin, $oldwin) = @_;
   # If a window is closed, we cannot do anything.
	return unless ref $oldwin and ref $newwin;
	
   my $height = $oldwin->{height} - $newwin->{height} + Irssi::settings_get_int("resize_num_window_actonly");
   # Work around bug in Irssi, minus numbers here
   # do weird things (i.e. grow without error
   # checking)
   return if $height < 0; 

   if(is_resized($oldwin->{refnum})) {
      $oldwin->command("^window shrink $height");
   }
   
   if(is_resized($newwin->{refnum})) {
      $newwin->command("^window grow $height");
   }
}

sub is_resized {
   for my $refnum(split ' ', Irssi::settings_get_str("resize_windows")) {
      return 1 if $refnum == $_[0];
   }
}
