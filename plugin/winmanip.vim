" map buffer movement
nnoremap <silent> <Plug>(JumpRight) :wincmd l<CR>
nnoremap <silent> <Plug>(JumpLeft) :wincmd h<CR>
nnoremap <silent> <Plug>(JumpDown) :wincmd j<CR>
nnoremap <silent> <Plug>(JumpUp) :wincmd k<CR>

" move buffer in the direction of the arrow
nnoremap <silent> <Plug>(MoveBufRight) :call winmanip#MoveBuf("l", 0)<CR>
nnoremap <silent> <Plug>(MoveBufLeft) :call winmanip#MoveBuf("h", 0)<CR>
nnoremap <silent> <Plug>(MoveBufDown) :call winmanip#MoveBuf("j", 0)<CR>
nnoremap <silent> <Plug>(MoveBufUp) :call winmanip#MoveBuf("k", 0)<CR>

" move the buffer in the direction of the arrow. Focus to the other window
nnoremap <silent> <Plug>(MoveJumpBufRight) :call winmanip#MoveBufAndStay("l", 0)<CR>
nnoremap <silent> <Plug>(MoveJumpBufLeft) :call winmanip#MoveBufAndStay("h", 0)<CR>
nnoremap <silent> <Plug>(MoveJumpBufDown) :call winmanip#MoveBufAndStay("j", 0)<CR>
nnoremap <silent> <Plug>(MoveJumpBufUp) :call winmanip#MoveBufAndStay("k", 0)<CR>

" Move buffer to the next/previous tab
nnoremap <silent> <Plug>(MoveWinToNextTab) :call winmanip#MoveToNextTab()<CR><C-w>H
nnoremap <silent> <Plug>(MoveWinToPrevTab) :call winmanip#MoveToPrevTab()<CR><C-w>H

" copy the current buffer to the window that lies in the direction of the pressed arrow
nnoremap <silent> <Plug>(CopyBufRight) :call winmanip#MoveBuf("l", 1)<CR>
nnoremap <silent> <Plug>(CopyBufLeft) :call winmanip#MoveBuf("h", 1)<CR>
nnoremap <silent> <Plug>(CopyBufDown) :call winmanip#MoveBuf("j", 1)<CR>
nnoremap <silent> <Plug>(CopyBufUp) :call winmanip#MoveBuf("k", 1)<CR>

" copy the current buffer to the window that lies in the direction of the pressed arrow.
" the cursor is moved to that same window
nnoremap <silent> <Plug>(CopyJumpBufRight) :call winmanip#MoveBufAndStay("l", 1)<CR>
nnoremap <silent> <Plug>(CopyJumpBufLeft) :call winmanip#MoveBufAndStay("h", 1)<CR>
nnoremap <silent> <Plug>(CopyJumpBufDown) :call winmanip#MoveBufAndStay("j", 1)<CR>
nnoremap <silent> <Plug>(CopyJumpBufUp) :call winmanip#MoveBufAndStay("k", 1)<CR>

" Toggle maximize/minimize window.
nnoremap <silent> <Plug>(MaximizeWin) :call winmanip#ToggleMaxWins()<CR>

" detach all buffers, but leave all windows untached
noremap <Plug>(ClearAllWindows) :call winmanip#DeleteAllBuffers()<cr>

" detach all windows and buffers
noremap <silent> <Plug>(ClearBufferList) :bufdo bd<cr>

" set g:winmanip_disable_key_mapping to disable default key mapping
if ! exists("g:winmanip_disable_key_mapping")
    nmap <silent> 1<Right> <Plug>(JumpRight)
    nmap 1<Left> <Plug>(JumpLeft)
    nmap 1<Down> <Plug>(JumpDown)
    nmap 1<Up> <Plug>(JumpUp)

    nmap 2<Right> <Plug>(MoveBufRight)
    nmap 2<Left> <Plug>(MoveBufLeft)
    nmap 2<Down> <Plug>(MoveBufDown)
    nmap 2<Up> <Plug>(MoveBufUp)

    nmap 3<Right> <Plug>(MoveJumpBufRight)
    nmap 3<Left> <Plug>(MoveJumpBufLeft)
    nmap 3<Down> <Plug>(MoveJumpBufDown)
    nmap 3<Up> <Plug>(MoveJumpBufUp)

    nmap 4<Right> <Plug>(MoveWinToNextTab)
    nmap 4<Left> <Plug>(MoveWinToPrevTab)

    nmap 5<Right> <Plug>(CopyBufRight)
    nmap 5<Left> <Plug>(CopyBufLeft)
    nmap 5<Down> <Plug>(CopyBufDown)
    nmap 5<Up> <Plug>(CopyBufUp)

    nmap 6<Right> <Plug>(CopyJumpBufRight)
    nmap 6<Left> <Plug>(CopyJumpBufLeft)
    nmap 6<Down> <Plug>(CopyJumpBufDown)
    nmap 6<Up> <Plug>(CopyJumpBufUp)

    nmap <Leader>z <Plug>(MaximizeWin)

    nmap <silent> <Leader>B <Plug>(ClearAllWindows)
    nmap <silent> <Leader>b <Plug>(ClearBufferList)
endif
