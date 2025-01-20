
" NOTE: Must be set *before* ALE is loaded to take effect.
let g:ale_completion_enabled = 1

if &shell =~# 'fish$'
    set shell=sh
endif

"We do not wish to be compatible with vim.
"We'll set it right away as it may affect other settings.
"This is the most compelling reason I found to set this
"https://stackoverflow.com/a/22543937
set nocompatible

"plugin manager, Vim-plug
"https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

"Comment stuff out. Use gcc to comment out a line (takes a count), gc to
"comment out the target of a motion (for example, gcap to comment out a
"paragraph), gc in visual mode to comment out the selection, and gc in
"operator pending mode to target a comment. You can also use it as a command,
"either with a range like :7,17Commentary, or as part of a :global invocation
"like with :g/TODO/Commentary
"https://github.com/tpope/vim-commentary
Plug 'tpope/vim-commentary'

"https://github.com/dense-analysis/ale
"Asynchronous Lint Engine
Plug 'dense-analysis/ale'

"https://github.com/khaveesh/vim-fish-syntax
Plug 'khaveesh/vim-fish-syntax'

"https://github.com/dag/vim-fish
Plug 'dag/vim-fish'

Plug 'preservim/vim-pencil'

Plug 'tpope/vim-markdown'

Plug 'preservim/vim-colors-pencil'

Plug 'davidhalter/jedi-vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

call plug#end()

set ignorecase smartcase

set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵

syntax enable
filetype plugin indent on

augroup commentarySettings
    autocmd FileType c,cpp setlocal commentstring=//\ %s
augroup END

let g:python3_host_prog = '/home/ajp/.venv/3.12kitchensink/bin/python'

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\ 'python': ['black']
\}

let g:ale_linters_ignore = {
\ 'python': ['flake8']
\}

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

"Map <F5> to open a new tab with the .vimrc file
"Used for fast access.
map <F5> :tabnew $MYVIMRC<CR>

" Toggle spell checking with <F7>
nn <F7> :setlocal spell! spell?<CR>

" Cycle through different numbering schemes.
map <F8> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>

"Temporarily switch to “paste mode”. Paste while in insert mode.
set pastetoggle=<F2>

colorscheme darkblue
" Cycle forward through colorschemes with <F9> and cycle through them backwards with <S-F9>
noremap <silent> <F9> :call ChangeColor(1)<CR>
" set <S-F9>=[20;2~
noremap <silent> <leader><F9> :call ChangeColor(-1)<CR>

"---------------Changing Color Schemes------------------------------------------

"Idea for color changing from:
"http://vim.wikia.com/wiki/Switch_color_schemes

"Default colors are all the colors availible.
let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
let s:mycolors = map(paths, 'fnamemodify(v:val, ":t:r")')

"Default colors are the ones defined in the following list.
"let s:mycolors = ['slate', 'torte', 'darkblue', 'delek', 'murphy', 'elflord', 'pablo', 'koehler']

" Set list of color scheme names that we will use.
function! s:SetColors(args)
    if len(a:args) == 0
        echo 'Current color scheme names:'
        let i = 0
        while i < len(s:mycolors)
            echo '  '.join(map(s:mycolors[i : i+4], 'printf("%-14s", v:val)'))
            let i += 5
        endwhile
    elseif a:args == 'my'
        let s:mycolors = ['default', 'darkblue', 'murphy', 'elflord',]
    elseif a:args == 'all'
        let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
        let s:mycolors = map(paths, 'fnamemodify(v:val, ":t:r")')
        echo 'List of colors set from all installed color schemes'
    else
        let s:mycolors = split(a:args)
        echo 'List of colors set from argument (space-separated names)'
    endif
endfunction

command! -nargs=* SetColors call s:SetColors('<args>')


let s:i = 0
function! ChangeColor(direction)
    let direction = a:direction
    let s:i += direction
    if !(0 <= s:i && s:i < len(s:mycolors))
        let s:i = (direction>0 ? 0 : len(s:mycolors)-1)
    endif
    execute 'colorscheme '.s:mycolors[s:i]
    redraw
    echo g:colors_name
endfunction




"-------------------------------------------------------------------------------
" Tmux and Vim stuff
" https://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits
"-------------------------------------------------------------------------------
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif
