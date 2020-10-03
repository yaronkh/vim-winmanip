function! s:BackupBuf()
    let l:or = win_getid()
    let l:bn = bufnr("%")
    tabnew
    exe "b " . l:bn
    let l:ret = win_getid()
    call win_gotoid(l:or)
    return l:ret
endfunction

function! s:RemoveBackupBuf(backup_win)
    let l:or = win_getid()
    call win_gotoid(a:backup_win)
    quit
    call win_gotoid(l:or)
endfunction

"move buffer between widnows
"rd - direction (h,j,k,l)
"is_dup - duplicate buffer across windows.
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
    if !a:is_dup
        let l:bu = s:BackupBuf()
    endif
    exec ":b " . l:mybuf
    call cursor(l:myline, l:mycol)
    call win_gotoid(l:mywin)
    if !a:is_dup
        exec ":b " . l:otherbuf
        call s:RemoveBackupBuf(l:bu)
        call cursor(l:otherline, l:othercol)
    endif
    return l:otherwin
endfunction

" move buffer to window and focus on the new window
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

" delete all buffers and keep windows
function! winmanip#DeleteAllBuffers()
    let l:ei_ = &ei
    let l:swin = winnr()
    set eventignore=all
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
        if (buflisted(l:i) && bufexists(l:i) && strlen(bufname(l:i)))
            exe "b " . l:i
            call winmanip#Kwbd(1)
        endif
        let l:i = l:i + 1
    endwhile
    exe l:swin . "wincmd w"
    exe 'set ei=' . l:ei_
endfunction

" delete the buffer; keep windows; create a scratch buffer if no buffers left
" this function is modification of the same function in
" https://vim.fandom.com/wiki/Deleting_a_buffer_without_closing_the_window
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
    tabdo windo call winmanip#Kwbd(2)
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
        tabdo windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        tabdo windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
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
function! winmanip#ToggleMaxWins()
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

