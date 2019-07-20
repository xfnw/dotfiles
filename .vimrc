

" some custom commands
"
" insert mom templates
command Tmomc :r ~/Documents/templates/chapter.mom
command Tmomg :r ~/Documents/templates/general.mom

" run groff+refer on file
:command Groff !refer -PS -e -p ~/Documents/bib % | groff -mom -Tpdf >> ${"%"::-4}.pdf 
