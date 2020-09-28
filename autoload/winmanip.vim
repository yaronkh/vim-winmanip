function winmanip#MoveBuf(dr, is_dup)
    let l:mybuf = bufnr("%")
    let l:myline = line(".")
    let l:mycol = col(".")
    let l:mywin = win_getid()
    exec "wincmd " . a:dr
    let l:otherwin = win_getid()
    let l:otherbuf = bufnr("%")
    let l:otherline = line(".")
    let l:othercol = col(".")
    if l:mywin == l:otherwin
        if a:dr == "l"
            vsplit
        elseif a:dr == "h"
            vsplit
            wincmd l
        elseif a:dr == "j"
            split
        else
            split
            wincmd j
        endif
        return winmanip#MoveBuf(a:dr, a:is_dup)
    endif
    exec ":b " . l:mybuf
    call cursor(l:myline, l:mycol)
    call win_gotoid(l:mywin)
    if !a:is_dup
        exec ":b " . l:otherbuf
        call cursor(l:otherline, l:othercol)
    endif
    return l:otherwin
endfunction

function! winmanip#MoveBufAndStay(dr, is_dup)
    call win_gotoid(winmanip#MoveBuf(a:dr, a:is_dup))
endfunction

"move window to the previous tab
function winmanip#MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunction

" Move window to the next tab
function winmanip#MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunction

"delete the buffer; keep windows; create a scratch buffer if no buffers left
function winmanip#Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(&modified)
      let answer = confirm("This buffer has been modified.  Are you sure you want to delete it?", "&Yes\n&No", 2)
      if(answer != 1)
        return
      endif
    endif
    if(!buflisted(winbufnr(0)))
      bd!
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call winmanip#Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction
"
"toggles whether or not the current window is automatically zoomed
function! ToggleMaxWins()
  if exists('g:windowMax')
    au! maxCurrWin
    wincmd =
    unlet g:windowMax
  else
    augroup maxCurrWin
        au! BufEnter * wincmd _ | wincmd |
        "
        " only max it vertically
        " au! WinEnter * wincmd _
    augroup END
    do maxCurrWin WinEnter
    exe ": wincmd _ | wincmd |"
    let g:windowMax=1
  endif
endfunction

