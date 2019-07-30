"""""""""""""""""""""""""""""""""""""""
" Plugins managed by vim-plug
"""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

"--------------------------------------
" ale
"--------------------------------------
" Asynchronous Lint Engine
" (Choose only one of ale and Neomake)
" Plug 'w0rp/ale'

"--------------------------------------
" ack
"--------------------------------------
" Vim plugin for the Perl module / CLI script 'ack'
Plug 'mileszs/ack.vim'
nnoremap <Leader>a :Ack!<Space>

"--------------------------------------
" vim-obsession
"--------------------------------------
" A more powerful :mksession
Plug 'tpope/vim-obsession'
set statusline+='%{ObsessionStatus()}'

"--------------------------------------
" vim-voom
"--------------------------------------
" Vim two-pane outliner
Plug 'vim-voom/VOoM'

"--------------------------------------
" vim-dealii-prm
"--------------------------------------
Plug 'xywei/vim-dealii-prm'

"--------------------------------------
" neovim-colors-solarized
"--------------------------------------
" using a fork that can use true color
"Plug 'frankier/neovim-colors-solarized-truecolor-only'
"syntax enable
" For older neovim versions (<0.1.5), we need to
" export NVIM_TUI_ENABLE_TRUE_COLOR=1
" if exists("&termguicolors")
  " set termguicolors
" else
  " let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" endif
"let g:solarized_menu=0
"set background=dark " or dark
" Custom settings
"let g:solarized_contrast = “high”
"" two commands to switch between dark/light themes
"command Dark :set background=dark
"command Light :set background=light

"--------------------------------------
" vim-solarized8
"--------------------------------------
" another truecolor theme more actively maintained
" Plug 'lifepillar/vim-solarized8'
" let g:solarized_visibility = "high"
" let g:solarized_diffmode = "high"
"
" NOTE: truecolor stuff does not work well with airline & tmuxline

"" two commands to switch between dark/light themes
" command Light :colorscheme solarized8_light_flat
" command Dark :colorscheme solarized8_dark_flat

"--------------------------------------
" Neomake
"--------------------------------------
Plug 'neomake/neomake'

" We are using manual tag generation, see
" below for details (command MakeTags)
"
" let g:neomake_ctags_maker = {
" \ 'exe': 'ctags',
" \ 'args': ['-R .'],
" \ }
" autocmd BufWritePre,BufRead *.cpp :Neomake! ctags

"--------------------------------------
" vim-indent-guides
"--------------------------------------
" visually display indent levels
Plug 'nathanaelkane/vim-indent-guides'

"--------------------------------------
" Display ansi escape sequences in a readable way
"--------------------------------------
Plug 'IngoHeimbach/vim-plugin-AnsiEsc'

"--------------------------------------
" Clang based syntax highlighting
"--------------------------------------
" chromatica.nvim
" To use it, you have to make a symlink of compile-commands.json
" under the project root.
" Since when chromatica initializes, it search the current directory
" and the ancestor directories for these two files.
" If both file are present, chromatica will combine the flags in them.
Plug 'arakashic/chromatica.nvim'
if has('unix')
  let s:uname = system("uname")
  " Assume that llvm is installed via homebrew on MacOS
  " brew install llvm --with-clang
  if s:uname == "Darwin\n"
    let g:chromatica#libclang_path='/usr/local/opt/llvm/lib/libclang.dylib'
  endif
  " Assme that this a an Arch linux, using clang from pacman
  if s:uname == "Linux\n"
    " libclang in miniconda takes priority
    if filereadable("~/miniconda3/lib/libclang.so")
      let g:chromatica#libclang_path='~/miniconda3/lib/libclang.so'
    elseif filereadable("/usr/lib/libclang.so")
      let g:chromatica#libclang_path='/usr/lib/libclang.so'
    endif
  endif
endif

let g:chromatica#enable_at_startup=0
let g:chromatica#highlight_feature_level=0

"--------------------------------------
" TagBar
"--------------------------------------
" Displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar'
let g:tagbar_width = 50
nmap tb :TagbarToggle<cr>

let g:tagbar_type_tex = {
      \ 'ctagstype' : 'latex',
      \ 'kinds'     : [
      \ 's:sections',
      \ 'g:graphics:1',
      \ 'l:labels:1',
      \ 'r:refs:1',
      \ 'p:pagerefs:1'
      \ ],
      \ 'sort'    : 0
      \ }

"--------------------------------------
" CtrlP
"--------------------------------------
" Fuzzy search file/buffer/tag...
Plug 'ctrlpvim/ctrlp.vim'
" Keybinding
let g:ctrlp_map = '<c-p>'
" Configs
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
" Ignore irrelevant files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" let g:ctrlp_custom_ignore = {
" \ 'dir':  '\v[\/]\.(git|hg|svn)$',
" \ 'file': '\v\.(exe|so|dll)$',
" \ 'link': 'some_bad_symbolic_links',
" \ }

"--------------------------------------
" vim-easy-align
"--------------------------------------
" Align stuff. Usage: gaip= (align paragraph w.r.t "=")
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"--------------------------------------
" vim-surround
"--------------------------------------
" Enable stuff like ds, cs and yss
Plug 'tpope/vim-surround'


"--------------------------------------
" vim-commentary
"--------------------------------------
" Use gcc to comment out a line, gc to comment out selected
Plug 'tpope/vim-commentary'
" Set commentstring for files not supported by default
autocmd FileType apache setlocal commentstring=#\ %s


"--------------------------------------
" delimitMate
"--------------------------------------
" Auto-completion for quotes, parens etc.
Plug 'Raimondi/delimitMate'

" Do not automatically close stuff
let delimitMate_autoclose = 0

"--------------------------------------
" emmet-vim
"--------------------------------------
" Fast html, css editing
" Includes some snippets and commands
Plug 'mattn/emmet-vim'
" Enable just for html/css
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" Remap the default <C-Y> leader
let g:user_emmet_leader_key='<C-Z>'


"--------------------------------------
" vim-javascript
"--------------------------------------
" For JavaScript development
Plug 'pangloss/vim-javascript'
" Enable syntax highlighting for JSDocs and NGDocs
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
" Enables syntax highlighting for Flow
let g:javascript_plugin_flow = 1
" Concealing Characters
let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_this           = "@"
let g:javascript_conceal_return         = "⇚"
let g:javascript_conceal_undefined      = "¿"
let g:javascript_conceal_NaN            = "ℕ"
let g:javascript_conceal_prototype      = "¶"
let g:javascript_conceal_static         = "•"
let g:javascript_conceal_super          = "Ω"
let g:javascript_conceal_arrow_function = "⇒"


"--------------------------------------
" vim-fugitive
"--------------------------------------
" Git wrapper.
Plug 'tpope/vim-fugitive'

"--------------------------------------
" nerd-tree, load on toggle
"--------------------------------------
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
map <C-n> :NERDTreeToggle<CR>

"--------------------------------------
" taglist
"--------------------------------------
Plug 'xywei/taglist'

"--------------------------------------
" vim-airline
"--------------------------------------
" status/tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" to show glyphs
let g:airline_powerline_fonts = 1

" dark
" let g:airline_theme='bubblegum'
" light
let g:airline_theme='sol'

" to display all buffers when there's only one tab open<Paste>
let g:airline#extensions#tabline#enabled = 1

" enable/disable tmuxline integration >
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#tmuxline#snapshot_file = "~/.tmux-statusline-colors.conf"

"--------------------------------------
" vim-operator-user
"--------------------------------------
" define operators easily
Plug 'kana/vim-operator-user'

"--------------------------------------
" vim-clang-format
"--------------------------------------
" c++ formatter using clang-format
" Plug 'rhysd/vim-clang-format'
" Customize format in .clang-format or _clang_format
" let g:clang_format#detect_style_file = 1
" define a flag to work with Neoformat
" autocmd FileType c,cpp,objc let b:noNeoformat=1
" map to <Leader>cf in C++ code
" autocmd FileType c,cpp,objc nnoremap <buffer><Leader>= :<C-u>ClangFormat<CR>
" autocmd FileType c,cpp,objc vnoremap <buffer><Leader>= :ClangFormat<CR>
" if you install vim-operator-user
" autocmd FileType c,cpp,objc map <buffer><Leader>c <Plug>(operator-clang-format)
" Toggle auto formatting:
" nmap <Leader>C :ClangFormatAutoToggle<CR>

"--------------------------------------
" vim-clang
"--------------------------------------
" Clang complete
" Plug 'justmao945/vim-clang'
" let g:clang_compilation_database = './build'
" let g:clang_cpp_options = '-std=c++14'

"--------------------------------------
" Using yapf to format python code
"--------------------------------------
" requires sudo pip3 install yapf
autocmd FileType py let b:noNeoformat=1
autocmd FileType py nnoremap <buffer><leader>= :0,$!yapf<Cr>

"--------------------------------------
" jedi-vim for Python auto completion
"--------------------------------------
" requires sudo pip3 install jedi
" Plug 'davidhalter/jedi-vim'

"--------------------------------------
" deoplete
"--------------------------------------
" Dark powered asynchronous completion framework
" Note: deoplete requires Neovim with Python3 enabled.
" If :echo has("python3") returns 1, then you're done.
" Otherwise, you may enable it by running: pip3 install neovim
" To invoke omni function: Ctrl+x Ctrl+o
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Enable at startup
let g:deoplete#enable_at_startup = 1
" Disable auto-complete
" let g:deoplete#disable_auto_complete = 1
" Initialize input_patterns
let g:deoplete#omni#input_patterns = {}
" Alternatively, use Ctrl+l to manually complete
inoremap <silent><expr><C-l> deoplete#mappings#manual_complete()

autocmd CompleteDone * pclose " To close preview window of deoplete automagically

"--------------------------------------
" deoplete-clang
"--------------------------------------
" Plug 'zchee/deoplete-clang'
" if has('unix')
  " let s:uname = system("uname")
  " " Assume that llvm is installed via homebrew on MacOS
  " " brew install llvm --with-clang
  " if s:uname == "Darwin\n"
    " let g:deoplete#sources#clang#libclang_path = '/usr/local/opt/llvm/lib/libclang.dylib'
    " let g:deoplete#sources#clang#clang_header = '/usr/local/opt/llvm/lib/clang'
  " endif
  " " Assme that this a an Arch linux, using clang from pacman
  " if s:uname == "Linux\n"
    " let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
    " let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
  " endif
" endif
" if filereadable("./compile_commands.json")
  " let g:deoplete#sources#clang#clang_complete_database='./'
" elseif filereadable("./build/compile_commands.json")
  " let g:deoplete#sources#clang#clang_complete_database='./build/'
" endif

"--------------------------------------
" neoinclude
"--------------------------------------
" Include completion framework for neocomplete/deoplete
" Plug 'Shougo/neoinclude.vim'

"--------------------------------------
" ulti-snipts
"--------------------------------------
" Use <tab> to expand snipts
Plug 'SirVer/ultisnips'
" Trigger configuration.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-u>"
" Set :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"--------------------------------------
" vim-tmux-navigator
"--------------------------------------
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1

"--------------------------------------
" vim-orgmode
"--------------------------------------
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'

"--------------------------------------
" undotree
"--------------------------------------
Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>

" enable persistent undo as recommended
if has("persistent_undo")
  set undodir=~/.undodir/
  set undofile
endif

"--------------------------------------
" vimwiki
"--------------------------------------
" does similar job as vim-orgmode
Plug 'vimwiki/vimwiki'

" Put wiki files in Dropbox
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/'}]

" Use <leader>o to toggle check lists
nmap <leader>tt <Plug>VimwikiToggleListItem
vmap <leader>tt <Plug>VimwikiToggleListItem

"--------------------------------------
" Neoformat
"--------------------------------------
Plug 'sbdchd/neoformat'

" If using other formatting plugin, define noNeoformat for
" that file type.
if !exists('b:noNeoformat')
  nnoremap <buffer><Leader>= :<C-u>Neoformat<CR>
  vnoremap <buffer><Leader>= :Neoformat<CR>
endif

" Enable basic formatting when a filetype is not found. Disabled by default.
" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

"--------------------------------------
" vimtex
"--------------------------------------
" modern vim plugin
Plug 'lervag/vimtex'
let g:vimtex_compiler_progname = 'nvr'
" this casuses issues in airline
" let g:vimtex_compiler_latexmk= 'callback'
let g:vimtex_view_method = 'zathura'

"--------------------------------------
" Generate a fast shell prompt
"--------------------------------------
"  with powerline symbols and airline colors
Plug 'edkolev/promptline.vim'
autocmd VimEnter * PromptlineSnapshot! ~/.shell_prompt.sh airline

"--------------------------------------
" Tmux statusline generator
"--------------------------------------
" Simple tmux statusline generator with support for powerline symbols and statusline / airline / lightline integration
Plug 'edkolev/tmuxline.vim'

"--------------------------------------
" vim-devicons
"--------------------------------------
" This plugin must be loaded lastly
" (vim-plug loads the plugins in the same order as they are registered)
" The terminal's font must be set as one of the nerd-fonts
Plug 'ryanoasis/vim-devicons'

" loading the plugin
let g:webdevicons_enable = 1

" necessary for showing glyphs
set encoding=utf8

" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1

" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1

" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1

" ctrlp glyphs
let g:webdevicons_enable_ctrlp = 1

" whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 1

" use double-width(1) or single-width(0) glyphs
" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1


" Add plugins to &runtimepath
call plug#end()

let g:promptline_preset = {
        \'a' : [ promptline#slices#python_virtualenv(), promptline#slices#conda_env() ],
        \'b' : [ promptline#slices#user() ],
        \'c' : [ promptline#slices#cwd() ],
        \'y' : [ promptline#slices#vcs_branch() ],
        \'warn' : [ promptline#slices#last_exit_code() ]}

" Colorscheme must be set after plug#end()
" colorscheme solarized8_dark_flat

" Time-based colorscheme
" if strftime("%H") < 7 || strftime("%H") > 17
"   colorscheme solarized8_dark_flat
" else
"   colorscheme solarized8_light_flat
" endif
" 
" if $COLORTHEME == 'light'
"   colorscheme solarized8_light_flat
" else
"   colorscheme solarized8_dark_flat
" endif

"""""""""""""""""""""""""""""""""""""""
" Other configurations
"""""""""""""""""""""""""""""""""""""""
" Enable mouse
set mouse=a

" Set python interpreter on MacOS (ignore virtualenv and conda)
if s:uname == "Darwin\n"
  let g:python_host_prog='/usr/local/bin/python2'
  let g:python3_host_prog='/usr/local/bin/python3'
endif

" Set python interpreter on Linux (ignore virtualenv and conda)
if s:uname == "Linux\n"
  let g:python_host_prog='/usr/bin/python2'
  let g:python3_host_prog='/usr/bin/python3'
endif

" Exploit vim's fuzzy search
" search down into all subfolders
" e.g., :find *.cpp + tab will give you all cpp files within
" the project
set path+=**

" Display all matchings when we do tab complete
set wildmenu

" Use markers to fold
" also enable space to trigger the fold in normal mode
set foldmethod=marker
nnoremap <space> za

" Using :find + * to do fuzzy file open,
" and :b + sub_string to do buffer switch,
" We can actually live without CtrlP plugin for the most
" of the time

" A command to make tags for the project
" After generating the tags, use
"   Ctrl+] to jump to tag
"   g Ctrl+] to list all matches
"   Ctrl+t to jump back
command! MakeTags !ctags -R .

" Use system clipboard
if (executable('pbcopy') || executable('xclip') || executable('xsel')) && has('clipboard')
  set clipboard=unnamed
endif

" Add my own tag file for packages
" set tags+=$HOME/Dropbox/Sources/tags;

" Add my own snipptes
set runtimepath+=$HOME/.config/nvim/MySnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/MySnips']

" Filetype system
filetype plugin indent on

set omnifunc=syntaxcomplete#Complete

" Allow colors, if colors are still not displayed correctly,
" try export TERM=xterm-256color
set t_Co=256

" Turn off blink in normal mode
set gcr=n:blinkon0

" Line numbers
set relativenumber
set number

" Store more cmd history
set history=10000

" Reload files changed outside vim
set autoread

" Turn off swap files (often troubsome,
" for example, when in shared folders)
set noswapfile

" Display all sorts of symbols that are easy to be messed up
set list listchars=tab:>-,trail:⎵,nbsp:⎵

" Wrap lines at convenient points
set wrap
set linebreak

" Indentation
set shiftwidth=2
set softtabstop=2
set expandtab

" Make the 81st column stand out
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" A mapping to fix the syntax highlighting
nnoremap <leader><esc> :syntax sync fromstart<CR>

"--------------------------------------
" TrimSpaces
" get rid of trailing spaces
"--------------------------------------
function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

"--------------------------------------
" Change the cursor shape in the terminal
"--------------------------------------
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

"--------------------------------------
" Highlight cursor
"--------------------------------------
" Ctr+K for searching cursor by highlighting
" current word
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white
function FindCursor()
  if !exists("s:highlightcursor")
    let s:highlightcursor=1
    set cursorline
    set cursorcolumn
  else
    unlet s:highlightcursor
    set nocursorline
    set nocursorcolumn
  endif
endfunction
nnoremap <C-K> :call FindCursor()<CR>

"--------------------------------------
" Smooth scrolling
"--------------------------------------
set scrolloff=8
set nolazyredraw

"--------------------------------------
" Tab management
"--------------------------------------
nnoremap tn :tabnew<Space>
nnoremap tj :tabnext<CR>
nnoremap tk :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>


"--------------------------------------
" Restore cursor position, window position, and last search after running a
" command.
"--------------------------------------
set ruler

function! Preserve(command)
  " Save the last search.
  let search = @/
  " Save the current cursor position.
  let cursor_position = getpos('.')
  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)
  " Execute the command.
  execute a:command
  " Restore the last search.
  let @/ = search
  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt
  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

"--------------------------------------
" Re-indent the whole buffer.
"--------------------------------------
function! Indent()
  call Preserve('normal gg=G')
endfunction
command -bar -nargs=0 -range=% Indent call Indent()

"--------------------------------------
" Auto-complete summary
"--------------------------------------
" Now you can use one of the following:
"
" 1. vim's defaualt keybindings, among which the
"    awesome ones are:
"    - Ctrl+x Ctrl+n  Just this file
"    - Ctrl+x Ctrl+f  For filenames (under var path)
"    - Ctrl+x Ctrl+]  For tags
"
"    - Ctrl+n         Everything specified by the 'complete' option
"
" 2. vim's omnifunc Ctrl+x Ctrl+o
"    (often too verbose)
"
" 3. Deoplete plugin Ctrl+l (clang based)
