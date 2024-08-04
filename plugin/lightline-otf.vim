if get(g:, 'loaded_lightline_otf')
  finish
endif

let g:loaded_lightline_otf = 1

let s:save_cpo = &cpo
set cpo&vim

let g:LightlineOtfColorschemeMapping = get(g:, 'LightlineOtfColorschemeMapping', {})

augroup lightline-otf
  autocmd!

  autocmd ColorScheme *
  \   if exists('g:loaded_lightline')
  \ |   call lightline#otf#ChangeLightlineColorschemeOnTheFly({ 'name': expand('<amatch>'), 'path': expand('<afile>') })
  \ | endif
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set expandtab tabstop=2 shiftwidth=2 foldmethod=marker:
