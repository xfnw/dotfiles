

" some custom commands
"
" insert mom templates
command Tmomc :r ~/Documents/templates/chapter.mom
command Tmomg :r ~/Documents/templates/general.mom
command Tmomr :r ~/Documents/templates/recipe.mom
command Tmome :r ~/Documents/templates/english.mom
command Tmd   :r ~/Documents/templates/md.html

" run groff+refer on file
:command Groff !sh -c 'p="%"; refer -PS -e -p ~/Documents/bib ${p::-4}.mom | groff -mom -Tpdf > ${p::-4}.pdf'
:command Grofft !sh -c 'p="%"; refer -PS -e -p ~/Documents/bib ${p::-4}.mom | groff -mom -T ascii | sed -b "s/\x1b[^m]*m//g" > ${p::-4}.txt'
:command Man !sh -c 'p="%"; groff -man -T ascii ${p::-4}.man > ${p::-4}.txt'

:command Md !p="%"; cmark --unsafe ${p::-3}.md | h2p - ${p::-3}.pdf 

" nice line numbers
set number
set relativenumber

" syntax hilighting
syntax on
color pablo

" vimwiki
set nocompatible
filetype plugin on

" vimrc sane defaults

filetype plugin indent on
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)




