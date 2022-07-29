
" xfnw's vim artist mode
" loosely based on https://www.reddit.com/r/vim/comments/1mkdhn/

" This is free and unencumbered software released into the public domain.
" For more information, please refer to <http://unlicense.org/>

function! ArtistMode()
  syntax off

  setlocal virtualedit=all
  setlocal cc=80
  hi ColorColumn ctermbg=1 guibg=#ff0000

  autocmd BufWritePre * :%s/\s\+$//e

  nnore <F1> r░
  nnore <F2> r▒
  nnore <F3> r▓
  nnore <F4> r█
  nore! <F1>  ░
  nore! <F2>  ▒
  nore! <F3>  ▓
  nore! <F4>  █

  nnore <F5> r▖
  nnore <F6> r▗
  nnore <F7> r▘
  nnore <F8> r▝
  nore! <F5>  ▖
  nore! <F6>  ▗
  nore! <F7>  ▘
  nore! <F8>  ▝

  nnore <F9>  r▌
  nnore <F10> r▐
  nnore <F11> r▄
  nnore <F12> r▀
  nore! <F9>   ▌
  nore! <F10>  ▐
  nore! <F11>  ▄
  nore! <F12>  ▀

  nnore gc9 i<Esc>[0m<Esc>l
  nnore gc8 i<Esc>[38;5;m<Esc>i
  nnore gb9 i<Esc>[0m<Esc>l
  nnore gb8 i<Esc>[38;5;m<Esc>i

  nnore gc0 i<Esc>[30m<Esc>l
  nnore gc1 i<Esc>[31m<Esc>l
  nnore gc2 i<Esc>[32m<Esc>l
  nnore gc3 i<Esc>[33m<Esc>l
  nnore gc4 i<Esc>[34m<Esc>l
  nnore gc5 i<Esc>[35m<Esc>l
  nnore gc6 i<Esc>[36m<Esc>l
  nnore gc7 i<Esc>[37m<Esc>l

  nnore gb0 i<Esc>[90m<Esc>l
  nnore gb1 i<Esc>[91m<Esc>l
  nnore gb2 i<Esc>[92m<Esc>l
  nnore gb3 i<Esc>[93m<Esc>l
  nnore gb4 i<Esc>[94m<Esc>l
  nnore gb5 i<Esc>[95m<Esc>l
  nnore gb6 i<Esc>[96m<Esc>l
  nnore gb7 i<Esc>[97m<Esc>l
endfunction

command! Artist call ArtistMode()

