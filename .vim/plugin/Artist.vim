
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
endfunction

command! Artist call ArtistMode()

