

" some custom commands
"
" insert mom templates
command Tmomc :r ~/Documents/templates/chapter.mom
command Tmomg :r ~/Documents/templates/general.mom
command Tmomr :r ~/Documents/templates/recipe.mom

" run groff+refer on file
:command Groff !p="%"; refer -PS -e -p ~/Documents/bib ${p::-4}.mom | groff -mom -Tpdf >> ${p::-4}.pdf 
