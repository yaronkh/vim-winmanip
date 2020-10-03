# vim-winmanip

Vim plugin for moving/duplicating/maximizing vim windows

## Demo

*  Move buffers between windows

   Type 2 or 3 followed by arrow key in the direction of the target window.
![Move buffers between windows](https://github.com/yaronkh/vim-winmanip/blob/master/img/MoveBuffers.gif)

* Duplicate buffers

   Type 5 or 6 followed by arrow key in the direction of the target window.
![Duplicate buffers between windows](https://github.com/yaronkh/vim-winmanip/blob/master/img/DuplicateBuffers.gif)

* Move window to the next tab

   Type 4, followed by arrow key in the direction of the target tab.
![Move window to next/prev tab](https://github.com/yaronkh/vim-winmanip/blob/master/img/JoinToNextTab.gif)

* Maximizing current window

   Type \<Leader\>z to toggle between maximized/normal window size.
![Toggle window maximize mode](https://github.com/yaronkh/vim-winmanip/blob/master/img/ZoomWindow.gif)

* Detach all buffers without closing windows

![Detach all buffers](https://github.com/yaronkh/vim-winmanip/blob/master/img/DetachAllBuffers.gif)


## Installation

Plugin installation:
* [Pathogen](https://github.com/tpope/vim-pathogen)
    ```
    git clone https://github.com/yaronkh/vim-winmanip.git ~/.vim/bundle/vim-winmanip
    ```
*  [vim-plug](https://github.com/junegunn/vim-plug)
    ```
    Plug 'yaronkh/vim-winmanip'
    ```
*  [NeoBundle](https://github.com/Shougo/neobundle.vim)
    ```
    NeoBundle 'yaronkh/vim-winmanip'
    ```
*  [Vundle](https://github.com/gmarik/vundle)
    ```
    Plugin 'yaronkh/vim-winmanip'
    ```
*  [Vim packages](http://vimhelp.appspot.com/repeat.txt.html#packages) (since Vim 7.4.1528)
    ```
    git clone https://github.com/hexdigest/gounit-vim.git ~/.vim/pack/plugins/start/vim-winmanip
    ```

## Usage
To me the best way to use winmanip is by using the default key maps:

* To exchange buffers between two windows press 2 and arrow key in the direction of the target window. For example
  pressing 2<Right> will cause the window to exchange buffers with the window to the right.
  If the current window is the right most window, a new window will be created.
  The "2" command leaves the cursor in the original window, where "3" move the window to the target window.
  Those commands support unsaved buffers.
* To duplicate buffer to an adjusted window press 5 or 6 and arrow key in the direction of the target window.
  Those commands are similar to the "move" command, with the exception that these commands duplicate buffers.
* To move the current window to an adjusted tab press 4 and arraw key in the direction of the target tab page.
* winmanip support window maximization mode. To toggle that mode press <Leader>z.
* To crear all windows from data, but keep the window geometry unchanged press <Leader>B.
* To erase all windows press <Leader>b
* to detach the current buffer and leave the window unchanged press <Leader>b

## customization
winmanip allows to change the default key mapping.
* To disable winmanip default key mapping set g:winmanip_disable_key_mapping in your .vimrc file:
```
let g:winmanip_disable_key_mapping = 1
```
* winmanip uses <Plug> mapping to allow key mapping customization. For example, follow the definition of the default key mapping:
```
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
```
