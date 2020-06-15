Development Stop
================

Hi everyone, I took over this plugin many years ago and have since moved on to other methods of maintaining my library. If someone wants to fork it and take over i'm happy to let this go as i don't have the need for this plugin anymore.


RHYTHMBOX FILEORGANIZER
=======================

Please help with testing this new release!
A lot of big changes have happened  that need testing before i can be comfortable with a stable release.

-------------------------------------
WARNING, ONGOING DEVELOPMENT VERSION.
-------------------------------------

 * Please be aware that for the moment this repo may have bugs
   that i haven't noticed in my testing.
 * I have tested all current features and they work as expected
   (But that isn't a promise it will be stable for you)

Welcome to version 3.91-dev

This update removes a lot of code that doesn't have any real purpose in the current rhythmbox.

I have dropped dbops.py and simplified the database naming using urllib.parse.

We no longer look for cover art as this has changed from older versions of rhythmbox.

Instead of updating tags this feature is removed.

So far in testing the changes are setting correct paths but the files are sometimes becoming 'missing'
The files move and update but I think this may be due to my large library (180,000)
and that testing has been done over sshfs as well as local files.




1.0 Install
2.0 Usage & Main Features
2.1 Other Features
3.0 Configuration and customisation
3.1 Compilation Support
3.2 Plugin Preferences Window
4.0 Change History
5.0 Contribute
6.0 Links

1.0 INSTALL
-----------

To install from the terminal using make:
make install

To check the dependencies, then install using python:
python3 ./install.py

If you want to install manually, extract to the following directory:
 * $HOME/.local/share/rhythmbox/plugins/fileorganizer/

You can test python dependencies by running:
python3 -c "import depends_test; depends_test.check()"

Possible extra requirements are:
 * python-configparser (I have to confirm this but i think it's a default module in python 3.2+)
 * gir1.2-notify-0.7 (Debian name, GObject notify library)
 * dconf-editor (to make changes to the rhythmbox library settings)


2.0 USAGE & MAIN FEATURES
-------------------------

This plugin is pretty simple but it has a few complicated features under the hood.

Once the plugin is installed, simply enable it in Rhythmbox. A restart of rhythmbox will be required to detect the plugin if it was open when you installed.

When the plugin is enabled, you will notice an option in the right-click menu of music items (like songs) that will read 'Organize selection'. Clicking this will organize the selected files following a defined structure (see 3. Configuration and customisation) for both folders and filenames. That's all there is to it.


2.1 OTHER FEATURES

Intelligent duplicate backup:
 * When two songs have the same name, the plugin moves the file to a backup directory. 
 * If you lose a file, you'll probably in a folder named 'backup' in the root of your music library.

Move all non music files with your music:
 * When enabled, Fileorganizer will move files like text files and pictures with that music file.
 * This is great for keeping all files organised, not just music.


Log file for all actions:
 * The log file is an invaluable tool to see what happens when running fileorganizer. 
 * By default this file is hidden in your home folder: $HOME/.fileorganizer.log


3.0 CONFIGURATION AND CUSTOMISATION
-----------------------------------

The output when running 'Organize Selection' is set from dconf-editor using default Rhythmbox settings:
 * org.gnome.rhythmbox.library/layout-filename (Is the filename for your output)
 * org.gnome.rhythmbox.library/layout-path (Is the folder path for your output)
 * org.gnome.rhythmbox.rhythmdb/locations (Is your library path)

Using these, your final output becomes:
 * library + layout-path + layout-filename

The Locations setting can actually be multiple locations, the first value is always taken by the plugin.

The Variables for layout_path and layout_filename follow the same values as rhythmbox:
 * %at -- album title
 * %aa -- album artist (Album artist will use track artist if it does not exist)
 * %aA -- album artist (lowercase)
 * %as -- album artist sortname
 * %aS -- album artist sortname (lowercase)
 * %ay -- album release year
 * %an -- album disc number
 * %aN -- album disc number, zero padded
 * %ag -- album genre
 * %aG -- album genre (lowercase)
 * %tn -- track number (i.e 8)
 * %tN -- track number, zero padded (i.e 08)
 * %tt -- track title
 * %ta -- track artist
 * %tA -- track artist (lowercase)

Variables not ported yet:
 * %ts -- track artist sortname
 * %tS -- track artist sortname (lowercase)


3.1 COMPILATION SUPPORT

Fileorganizer will use the album artist tag which is a part of rhythmbox and replace the artist field. For example:
 * Path: /music/$artist/$year $album/$disc-$track - $title
 * Input: /music/new/spawn soundtrack/01 - filter & the crystal method - trip like i do.mp3
 * Set Album Artist to 'Various' in Rhythmbox.
 * Output: /music/Various/1997 Spawn/1-01 - Can't You (Trip Like I Do).mp3


3.2 PLUGIN PREFERENCES WINDOW

The preferences window gives you the ability to switch features on or off.

Preview Mode
 * If enabled, 'Organize Selection' will only check for changes and open a text report after completion.

File/Folder Cleanup
 * If enabled, files within the same folder that aren't music files are moved as well

Remove Empty Folders
 * If the source folder is empty after moving, delete the folder

Log File:
 * Set the filename of the log file (the base path is your home folder)

Strip NTFS Chars
 * Strip out characters that Windows can't handle.
   (NTFS actually supports more characters than Windows allows)



4.0 CHANGE HISTORY
------------------

3.99*-dev-*
 * Removed tag update options and code
 * Removed cover art import, the naming/format has changed
 * Using urllib.parse to encode DB imports

3.*-dev-*
 * Added python script install.py to check all imports.
   (Also added uninstall.py)
 * Removed older v2.99 zip file
 * Removed INSTALL & UNINSTALL (these were just calls to make anyway)
 * Ongoing pylint/refactor changes.
 * Update config window to remove depreciated widgets. (requires GTK+ 3.0)
 * Move conf template into base plugin dir

Update 2015/05/05:
 * added strip_ntfs option (Care of @sirfz)
   [https://github.com/lachlan-00/rb-fileorganizer/commit/d8cf611f969a1fc250e7348b4e53285d13f950f3]

3.2013.09.16:
Currently running on RB 3.0
 * Tag Library python-eyed3 not available for python 3.

2.0.1-2 features include:
Preview Mode
 * Files are not moved or changed in any way while in preview mode.
 * When completed up to two text files will open showing changes or possibly damaged files.
 * To enable preview mode, set enable it in the preferences window.
Update Tags After Relocation
 * The plugin now uses python-eyeD3 for checking tag values.
 * After organising the selected files, fileorganizer will update the mp3 tags for you to 

2.0 features include:
 * GTK3 Rhythmbox 3/GIT support
 * Moved settings from Gconf to Gsettings
 * Random bug fixes
 * New code base [1]

1.1 features include:
 * UI Implemented
 * Configuration File
 * Import cover art from the source folder to the RB cache if found.
 * Ability to disable file/folder cleanup and other features.

1.0.3-2 features include:
 * Fixes to backup support.
 * UTF-8 encoding support.
 * Fixed move folder contents with files.
 * Notification on completion using pynotify.
 * More code cleanup and additions.

1.0.3 features include:
 * File management of non music files.
 * A physical log file stored in the home folder.
 * Moved the backup folder to the root of the music library.
 * Compilation support using rhythmbox's album artist field.

1.0.2 features include:
 * Support for Rhythmbox > 0.13.1
 * Added $disc and $year support.


5.0 CONTRIBUTE
--------------

To contribute, please refer to our github page [2]


6.0 LINKS
---------

[1] http://code.launchpad.net/~lachlan-00/rb-fileorganizer/legacy
[2] https://github.com/lachlan-00/rb-fileorganizer
