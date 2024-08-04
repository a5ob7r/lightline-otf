function! lightline#otf#ChangeLightlineColorschemeOnTheFly(context) abort
  call s:ChangeLightlineColorscheme(a:context)
  call s:UpdateLightline()
endfunction

function! s:ChangeLightlineColorscheme(context) abort
  let l:colorscheme = s:ColorschemeMapping(a:context)

  if s:HasLightlineColorscheme(l:colorscheme)
    call s:SetLightlineColorscheme(l:colorscheme)
  endif
endfunction

function! s:ColorschemeMapping(context) abort
  let l:colorscheme = a:context['name']

  if type(g:LightlineOtfColorschemeMapping) == type({})
    return get(g:LightlineOtfColorschemeMapping, l:colorscheme, l:colorscheme)
  elseif type(g:LightlineOtfColorschemeMapping) == type('')
    return call(g:LightlineOtfColorschemeMapping, [a:context])
  elseif type(g:LightlineOtfColorschemeMapping) == type(function('tr'))
    return g:LightlineOtfColorschemeMapping(a:context)
  else
    throw 'lightline-otf: the type of "g:LightlineOtfColorschemeMapping" must be Dictionary, String or Funcref.'
  endif
endfunction

function! s:HasLightlineColorscheme(colorscheme) abort
  return !empty(globpath(&runtimepath, printf('autoload/lightline/colorscheme/%s.vim', a:colorscheme), 1))
endfunction

function! s:SetLightlineColorscheme(colorscheme)
  let g:lightline = get(g:, 'lightline', {})
  let g:lightline['colorscheme'] = a:colorscheme
endfunction

function! s:UpdateLightline() abort
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

" vim: set expandtab tabstop=2 shiftwidth=2 foldmethod=marker:
