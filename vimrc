" vim: set ts=4 sw=4 et:

" automatically download vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Plugin list
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'preservim/tagbar'
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdcommenter'
Plug 'altercation/vim-colors-solarized'

call plug#end()
" End of plugin list

let mapleader = ","
" colorscheme ron " setting colorscheme may mess up some colors set below
set hls
set background=dark
set cindent
set exrc
set secure
set tabstop=8
set shiftwidth=8
set cmdheight=2
set updatetime=300
set shortmess+=c
colorscheme solarized

" always on signal column, otherwise text will jump
" everytime a diagnostic appear
if has("patch-8.1.1564")
    " merge signcolumn and number column
    set signcolumn=number
else
    " this will take some space
    set signcolumn=yes
endif

" -- Generic
"  format C buffers on save
"  TODO: Try getting CoC doing this
" autocmd BufWritePre *.h,*.c,*.hh,*.cc,*.cpp call ClangFomatOnSave()

" preferred tab measurements
autocmd FileType json,python,ruby,css,html setlocal ts=2 sw=2 et

"  Fix some misunderstadings
autocmd BufRead,BufNewFile *.h,*.c set filetype=c
autocmd BufRead,BufNewFile *.hh,*.cc,*.cpp set filetype=cpp
autocmd BufRead,BufNewFile */make/** set filetype=make

"  fix some ugly colors
highlight SignColumn NONE
highlight SignColumn term=standout ctermfg=14 guifg=Cyan guibg=Grey
" highlight YcmErrorSign ctermfg=224
" highlight YcmWarningSign ctermfg=yellow

"  handle trailing whitespaces
highlight ExtraWhitespaces ctermbg=yellow guibg=yellow
nmap <silent> <leader>wn :match ExtraWhitespaces /\s\+$/<CR>
nmap <silent> <leader>wf :match<CR>
nmap <silent> <leader>wc :%s/\s\+$//e<CR>

"  clean trailing whitespaces before writing (!beware this is experimental!)
" autocmd BufWritePre * :%s/\s\+$//e

" -- Airline
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'
let g:airline#extensions#tabline#enabled  = 1    " enable the list of buffers
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#c_like_langs = [
    \ 'arduino', 'c', 'cpp', 'cuda', 'go', 'javascript', 'ld', 'php',
    \ 'c.doxygen', 'cpp.doxygen'
  \ ]

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr     = ''
" let g:airline_left_sep         = ''
" let g:airline_left_alt_sep     = ''
" let g:airline_right_sep        = ''
" let g:airline_right_alt_sep    = ''
let g:airline_symbols.whitespace = ''
let g:airline_symbols.notexists  = 'φ'

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" -- Buffer Management
set hidden
" next buffer
nmap <silent> <leader>n :bnext<CR>
" previous buffer
nmap <silent> <leader>p :bprevious<CR>
" close the buffer and move to previous one
nmap <silent> <leader>q :bp <BAR> bd #<CR>
" use fzf buffer list
nmap <silent> <leader>b :Buffers<CR>

" -- CoC.nvim
" coc is better than YCM.
source $HOME/.vim/coc.vim

" -- CtrlP
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](\.(git|hg|svn)|\_site)$',
    \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
nmap <silent> <leader>P :CtrlP<CR>

" -- CursorLine: highlighcppcurrent line, to not to be lost in a sea of text
set cursorline
highlight CursorLine term=bold cterm=NONE ctermbg=0 guibg=Grey

" -- Git gutter navigation
nnoremap <silent> <leader>dn :GitGutterNextHunk<CR>
nnoremap <silent> <leader>dp :GitGutterPrevHunk<CR>

" -- Text width margin. mark a column as maximum text width
set textwidth=80
set colorcolumn=+1 " mark textwidth + 1 column
highlight ColorColumn ctermbg=0 guibg=Grey

" -- Fugitive
nmap <silent> <leader>g :Git<CR>

" -- FZF
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>L :Lines<CR>

" -- NerdTree
"  open NERDTree when vim is invoked without any arguments
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeQuitOnOpen                    = 0
let g:NERDTreeDirArrowExpandable          = '▶'
let g:NERDTreeDirArrowCollapsible         = '▼'
let g:NERDTreeGitStatusIndicatorMapCustom = {
            \ 'Modified'  :'',
            \ 'Staged'    :'S',
            \ 'Untracked' :'U',
            \ 'Renamed'   :'r',
            \ 'Unmerged'  :'═',
            \ 'Deleted'   :'d',
            \ 'Dirty'     :'',
            \ 'Ignored'   :'i',
            \ 'Clean'     :'',
            \ 'Unknown'   :'?',}
nmap <silent> <leader>t :NERDTreeToggle<CR>

" -- NERD Commenter
let g:NERDCreateDefaultMappings  = 0
let g:NERDSpaceDelims            = 1
let g:NERDCommentEmptyLines      = 1
let g:NERDTrimTrailingWhitespace = 1

nmap <silent> <leader>c/ <Plug>NERDCommenterInvert
nmap <silent> <leader>c? <Plug>NERDCommenterAltDelims

" -- Other functionalities
nmap <leader>mr :call ToggleLineNumbers()<CR>
nmap <leader>ms :so %<CR>

" -- Tagbar
nmap <silent> <leader>T :TagbarToggle<CR>

" -- Undotree
nmap <silent> <leader>u :UndotreeToggle<CR>

" -- YCM
"  decommissioned in favor of coc.nvim
" let g:ycm_clangd_uses_ycmd_caching                  = 0                   " Let clangd fully control code completion
" let g:ycm_clangd_binary_path                        = exepath("clangd")   " Use installed clangd
" let g:ycm_complete_in_comments_and_strings          = 1
" let g:ycm_key_list_select_completion                = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion              = ['<C-p>', '<Up>']
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_error_symbol                              = '!!'
" let g:ycm_warning_symbol                            = '**'
"
" nmap <silent> <leader>ci :YcmCompleter GoToInclude<CR>
" nmap <silent> <leader>cd :YcmCompleter GoToDeclaration<CR>
" nmap <silent> <leader>cD :YcmCompleter GoToDefinition<CR>
" nmap <silent> <leader>cr :YcmCompleter GoToReferences<CR>
" nmap <silent> <leader>ct :YcmCompleter GetType<CR>
" nmap <silent> <leader>cR :call YcmCompleterRenameCommand(input('New name: '))<CR>

" --- Functions


function! ClangFomatOnSave()
    let l:formatdiff = 1
    py3f /usr/share/clang/clang-format.py
endfunction

function! YcmCompleterRenameCommand(new_name)
    execute ':YcmCompleter RefactorRename '.a:new_name
endfunction

function! ToggleLineNumbers()
    if v:version > 703
        set norelativenumber!
    endif
    set nonumber!
endfunction
