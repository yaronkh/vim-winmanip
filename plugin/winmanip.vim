
nnoremap <silent> 1<Right> :wincmd l<CR>
nnoremap <silent> 1<Left> :wincmd h<CR>
nnoremap <silent> 1<Down> :wincmd j<CR>
nnoremap <silent> 1<Up> :wincmd k<CR>

nnoremap <silent> 2<Right> :call winmanip#MoveBuf("l", 0)<CR>
nnoremap <silent> 2<Left> :call winmanip#MoveBuf("h", 0)<CR>
nnoremap <silent> 2<Down> :call winmanip#MoveBuf("j", 0)<CR>
nnoremap <silent> 2<Up> :call winmanip#MoveBuf("k", 0)<CR>

nnoremap <silent> 3<Right> :call winmanip#MoveBufAndStay("l", 0)<CR>
nnoremap <silent> 3<Left> :call winmanip#MoveBufAndStay("h", 0)<CR>
nnoremap <silent> 3<Down> :call winmanip#MoveBufAndStay("j", 0)<CR>
nnoremap <silent> 3<Up> :call winmanip#MoveBufAndStay("k", 0)<CR>

" in quickfix window pressing 4 and arrow will open the link in a new
" buffer according to the arrow direction
autocmd! Filetype qf nnoremap <silent> <buffer> 4<Right> <C-w><Enter><C-w>L | nnoremap <silent> <buffer> 4<Left> <C-w><Enter><C-w>H | nnoremap <silent> <buffer> 4<Up> <C-w><Enter><C-w>K | nnoremap <silent> <buffer> 4<Down> <C-w><Enter><C-w>J

nnoremap <silent> 4<Right> :call winmanip#MoveToNextTab()<CR><C-w>H
nnoremap <silent> 4<Left> :call winmanip#MoveToPrevTab()<CR><C-w>H

nnoremap <silent> 5<Right> :call winmanip#MoveBuf("l", 1)<CR>
nnoremap <silent> 5<Left> :call winmanip#MoveBuf("h", 1)<CR>
nnoremap <silent> 5<Down> :call winmanip#MoveBuf("j", 1)<CR>
nnoremap <silent> 5<Up> :call winmanip#MoveBuf("k", 1)<CR>

nnoremap <silent> 6<Right> :call winmanip#MoveBufAndStay("l", 1)<CR>
nnoremap <silent> 6<Left> :call winmanip#MoveBufAndStay("h", 1)<CR>
nnoremap <silent> 6<Down> :call winmanip#MoveBufAndStay("j", 1)<CR>
nnoremap <silent> 6<Up> :call winmanip#MoveBufAndStay("k", 1)<CR>
nnoremap <silent> <Leader>z :call winmanip#ToggleMaxWins()<CR>

noremap <silent> <Leader>B :tabdo windo call winmanip#Kwbd(1)<cr>
noremap <Leader>b :bufdo bd<cr>
