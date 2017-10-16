" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:

filetype plugin on

" Load plugins {
    call plug#begin('~/.vim/plugged')
        " Colors    
        Plug 'frankier/neovim-colors-solarized-truecolor-only'
        Plug 'paranoida/vim-airlineish'
        " Useful tools
        Plug 'bling/vim-airline'
        Plug 'scrooloose/nerdcommenter'
        Plug 'scrooloose/nerdtree'
        Plug 'Shougo/deoplete.nvim'
        Plug 'Shougo/echodoc.vim'
        Plug 'kien/ctrlp.vim'
        Plug 'kassio/neoterm'
        Plug 'terryma/vim-expand-region'
        Plug 'Konfekt/FastFold'
        Plug 'jeffkreeftmeijer/vim-numbertoggle'
        Plug 'achilleasa/neomake'
        Plug 'godlygeek/tabular'
        Plug 'numkil/ag.nvim'
        Plug 'vim-scripts/visual-increment'
        " Golang
        Plug 'fatih/vim-go'
        Plug 'zchee/deoplete-go', { 'do': 'make'}
        " openCL
        Plug 'petRUShka/vim-opencl'
        " erlang
        Plug 'vim-erlang/vim-erlang-compiler'
        " Git helpers
        Plug 'tpope/vim-fugitive'
        Plug 'airblade/vim-gitgutter'
        " MD preview (use with brew install grip)
        Plug 'JamshedVesuna/vim-markdown-preview'
    call plug#end()
"}

" Nvim specific {
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" }

" Look and feel {
    set termguicolors
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
	 
	syntax enable
	colorscheme solarized 
	set background=dark

	" Enable mouse support
	set mouse=a
"}

" General {
	scriptencoding utf-8
	
	" Show line numbers
	set number	

	" Highlight current line and set ruler at col 80
	set cursorline
	set colorcolumn=80	
"}

" Edit {
    " Allow cursor after last line character
    set virtualedit=onemore

    " Automatically reload modified files
    set autoread

    " Undo and swap location
    set undolevels=1000 " Lots of undo
    set directory=$HOME/.vim/swapfiles//

    " Prevent cursor from moving one position to the left when exiting insert mode
    au InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])

    " Always position quickfix window to the bottom
    au FileType qf wincmd J

    " Fold settings {
            set foldmethod=syntax	" automatically fold by syntax
            set nofoldenable	" have folds open by default
            set foldlevel=99	" prevent automatic folding unless we need to   
    "}

    " Clipboard {
        if has('clipboard')
            if has('unnamedplus')  " When possible use + register for copy-paste
                set clipboard=unnamed,unnamedplus
            else         " On mac and Windows, use * register for copy-paste
                set clipboard=unnamed
            endif
        endif
    " }

    " GIT support {
        " Instead of reverting the cursor to the last position in the buffer, we
        " set it to the first line when editing a git commit message
        au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    " }
" }

 " Formatting {
    " Indent same level as previous line
    set smartindent
    set autoindent

    " Text wrap options (disable text-wrap) {
        set textwidth=0 
        set wrapmargin=0
        set formatoptions-=t
        set nowrap
    "}

    " Format overrides based on file type
    au FileType javascript setl sw=2 sts=2 et
    au FileType python set tabstop=4|set shiftwidth=4|set expandtab
    au FileType ruby set tabstop=2|set shiftwidth=2|set expandtab

    " Automatically trim EOL whitespace when editing ruby/erlang code 
    au FileType ruby autocmd BufWritePre * :%s/\s\+$//e
    au FileType erlang autocmd BufWritePre * :%s/\s\+$//e
" }

" Plugins {
    " vim-go {
        let g:go_highlight_functions = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_structs = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_build_constraints = 1
        let g:go_fmt_fail_silently = 0
        let g:go_fmt_command = "goimports"
        let g:go_list_type = "quickfix" 

        " Run automake on go file save
       au FileType go au! BufWritePost * Neomake
    " }

    " tagbar {
        let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
    " }
    
    " neomake {
        let g:neomake_open_list = 1
        let g:neomake_list_height = 5
        let g:neomake_always_use_quickfix = 1

        " vim-go {
            let g:neomake_go_enabled_makers = ['go']
        " }
    " }
    
    " deocomplete {
        let g:deoplete#enable_at_startup = 1
        
        " deoplete-go settings {
            let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
            let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
        " }
    " }

    " NERDTree {
        " Automatically show NERDTree if no files are specified when
        " launching vim 
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
        set splitright

        " Case-sensitive sorting
        let g:NERDTreeCaseSensitiveSort = 1
    " }

    " airline {
        let g:airline_theme = 'airlineish'
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_powerline_fonts = 1
        set laststatus=2
    " }
    
    " echodoc {
        set noshowmode
        let g:echodoc_enable_at_startup = 1
        set completeopt=menu,menuone,noinsert
    " }
    
    " ctrlp {
        let g:ctrlp_use_caching = 0
        if executable('ag')
            set grepprg=ag\ --nogroup\ --nocolor

            let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
        else
          let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
          let g:ctrlp_prompt_mappings = {
            \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
            \ }
        endif
    " }
    
    " vim-numbertoggle {
        let g:NumberToggleTrigger="§"
    " }
    
    " AG {
        " Always ignore Godeps and node_modules
        let g:ag_prg='ag -S --nocolor --nogroup --column --ignore node_modules --ignore Godeps --vimgrep -F'
    " }

    " syntastic {
"        let g:syntastic_enable_signs = 0
"        let g:syntastic_enable_highlighting = 0
"        let g:syntastic_auto_loc_list = 0
"        let g:syntastic_always_populate_loc_list = 0
"        let g:syntastic_auto_loc_list = 0
"        let g:syntastic_loc_list_height = 5
"        let g:syntastic_check_on_open = 0
"        let g:syntastic_check_on_wq = 0
"
"        let g:syntastic_aggregate_errors = 1
"
"        " vim-go {
"            let g:syntastic_go_checkers = ['go', 'govet', 'golint', 'errcheck']
"            let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
"        " }
"        
"        " opencl {
"            let g:syntastic_opencl_clcc_args = "-W"
"        " }
    " }
    
    " vim-markdown-preview {
    let vim_markdown_preview_github=1
    let vim_markdown_preview_hotkey='<C-m>'
    " }
"}

" Keybindings {
    " Map leader to space
    let mapleader = "\\"

    " Enter visual mode with space,space 
    nnoremap <Leader><Leader> V
    
    " Expand/Shrink selection while in visual mode
    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)

    " vp doesn't replace paste buffer
    function! RestoreRegister()
      let @" = s:restore_reg
      return ''
    endfunction
    
    function! s:Repl()
      let s:restore_reg = @"
      return "p@=RestoreRegister()\<cr>"
    endfunction
    vmap <silent> <expr> p <sid>Repl()

    " Leader + w to save buffer
    nnoremap <Leader>w :w<CR>

    " Remap enter/backspace in normal mode so we can type 12<Enter> to jump to
    " line
    nnoremap <CR> G
    nnoremap <BS> gg

    " Useful keybindings when working with go files
    au FileType go nmap <leader>t :GoTest!<CR>
    au FileType go nmap <leader><leader>t :GoTestFunc!<CR>
    au FileType go nmap <leader>r :GoRun!<CR>
    au FileType go nmap <leader>d <Plug>(go-def-vertical)
    au FileType go nmap <leader>c <Plug>(go-callers)
    au FileType go nmap <leader>i <Plug>(go-implements)

    " Indentation shortcuts
    nnoremap <F5> mzgg=G`z
    au FileType json nnoremap <F5> :%!python -m json.tool<CR>

    " Toggle NERDTree
    imap <F2> <Esc>:NERDTreeToggle<CR>i
    map <F2> :NERDTreeToggle<CR>
    nnoremap <leader><F2> :NERDTreeFind<CR>

    " Toggle code comment
    nnoremap <silent><C-_> :call NERDComment("n", "Toggle")<CR>
    vnoremap <silent><C-_> :call NERDComment("x", "Toggle")<CR>

    " Code folding
    inoremap <F9> <C-O>za
    nnoremap <F9> za
    onoremap <F9> <C-C>za
    vnoremap <F9> zf

    " Make Page up/down work properly
    map <PageUp> <C-U>
    map <PageDown> <C-D>
    imap <PageUp> <C-O><C-U>
    imap <PageDown> <C-O><C-D>

    " Map jj to ESC when in insert mode
    inoremap jj <ESC>

    " Launch a zsh terminal
    nnoremap <F3> :T zsh<CR>
    
    " When deocomplete is active, enter inserts the word and mutes the <CR>
    inoremap <silent><expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
    
    " Tagbar
    nmap <F8> :TagbarToggle<CR>

    " Easier window switching
    " Note: iterm sends <BS> chen <C-h> is pressed. To fix go to preferences,
    " keys and add a mapping for C+h to Esc+ -> [104;5u
    nmap <silent> <C-h> :wincmd h<CR>
    nmap <silent> <C-j> :wincmd j<CR>
    nmap <silent> <C-k> :wincmd k<CR>
    nmap <silent> <C-l> :wincmd l<CR>
 "}
