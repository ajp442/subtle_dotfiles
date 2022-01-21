"==============================================================================
"VIM Configuration File
"Author: Andrew Pierson
"==============================================================================


" NOTE: Must be set *before* ALE is loaded to take effect.
let g:ale_completion_enabled = 1


"We do not wish to be compatible with vim.
"We'll set it right away as it may affect other settings.
"This is the most compelling reason I found to set this
"https://stackoverflow.com/a/22543937
set nocompatible

" This snipit will install vim-plug
 if empty(glob('~/.vim/autoload/plug.vim'))
   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
 endif

call plug#begin('~/.vim/plugged')

"Comment stuff out. Use gcc to comment out a line (takes a count), gc to
"comment out the target of a motion (for example, gcap to comment out a
"paragraph), gc in visual mode to comment out the selection, and gc in
"operator pending mode to target a comment. You can also use it as a command,
"either with a range like :7,17Commentary, or as part of a :global invocation
"like with :g/TODO/Commentary
"https://github.com/tpope/vim-commentary
Plug 'tpope/vim-commentary'

"Easily toggle between *.c* and *.h* buffers.  script to toggle between C/C++
"headers and sources. Bound to <F4> because that's the Qt Creator keybind.
"https://github.com/ericcurtin/CurtineIncSw.vim
Plug 'ericcurtin/CurtineIncSw.vim'

"Preview markdown.
"https://github.com/iamcco/markdown-preview.nvim
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" A Vim Plugin for Lively Previewing LaTeX PDF Output
" https://github.com/xuhdev/vim-latex-live-preview
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }


"maybe keep
"https://github.com/davidhalter/jedi-vim
"Plug 'davidhalter/jedi-vim'   " jedi for python


" Need this for compatability with tmux integration.
"https://github.com/christoomey/vim-tmux-navigator
Plug 'christoomey/vim-tmux-navigator'


"https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


"https://github.com/dag/vim-fish
" Fish shell script highlighting.
Plug 'dag/vim-fish'

"https://github.com/dense-analysis/ale
"Asynchronous Lint Engine
Plug 'dense-analysis/ale'

"https://github.com/dhruvasagar/vim-table-mode
Plug 'dhruvasagar/vim-table-mode'

call plug#end()

"------------------------------------------------------------------------------
"Settings
"------------------------------------------------------------------------------

"Trun on that syntax highlighting
syntax on
" Only takes effect if added *after* 'syntax on'.
highlight Comment cterm=italic
" Need to distringuish Keyword from Normal enough so that gitcommitSummary is distinguishable.
highlight Keyword cterm=bold ctermfg=66

"turn on doxygen syntax hilighting. Works for C, C++, C#, and IDL files.
let g:load_doxygen_syntax=1

"http://vim.wikia.com/wiki/Continuing_doxygen_comments
"Or just use ^= instead of += to prepend the new option:
autocmd Filetype c,cpp set comments^=:///


"Let yourself know what mode you are in
set showmode

"Change those peskey tabs to spaces
"If you ever want a real tab character use Ctrl-V<tab> key sequence
"set expandtab

"Of course many applications us 4 spaces for a tab
"set tabstop=4

"Indent by 4 spaces when using >>, <<, ==, ect.
"set shiftwidth=4

"highlight all matching phrases
set hlsearch

"show partial matches for a search phrase
set incsearch

"use the indent of the previous line for a newly created line
set autoindent

"Always display the current cursor position in the lower right corner of the Vim
"window.
set ruler

" Set default encoding to UTF-8
set enc=utf-8

"remember more commands and search history
set history=1000

"use many levels of undo
set undolevels=1000


"Increase the max number of tabs that can be opened.
set tabpagemax=100

"Line endings
set fileformats-=dos,mac

"Explicitly set line endings to unix, this way we can see if we are editing
"non unix files.
set fileformat=unix

"Delete comment character when joining commented lines
set formatoptions+=j


"Visualizing whitespace
"Use set list to toggle viewing these characters.
"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸.,nbsp:+,space:·


"When included, as much as possible of the last line in a window will be
"displayed.  When not included, a last line that doesn't fit is replaced with
""@" lines.
set display+=lastline

"Matching brackets highlighted
set showmatch

"The value of this option influences when the last window will have a
"status line:
"    0: never
"    1: only if there are at least two windows
"The screen looks nicer with a status line if you have several windows, but it
"takes another screen line.: always
set laststatus=2

"A <BS> will delete a 'shiftwidth' worth of space at the start of the line.
set smarttab

" Allow fuzzy menu at the bottom of the vim/gvim window.
"The meaning of 'list:longest,full' is so that when you do completion in the
"command line via tab, these events will happen:
"1. (on the first tab) a list of completions will be shown and the command
"will be completed to the longest common command.
"2. (on second tab) the wildmenu will show up with all the completions that
"were listed before.
set wildmenu
set wildmode=list:longest,full

"The bottom line in your editor will show you information about the current
"command going on. The part I like is that if you’re selecting things in
"visual mode it will show you the number of lines selected.
set showcmd

"Minimal number of screen lines to keep above and below the cursor.
set scrolloff=1

"The minimal number of screen columns to keep to the left and to the right of
"the cursor if 'nowrap' is set.
set sidescrolloff=5

"The following is like a combination of these commands:
" filetype on
" filetype plugin on
" filetype indent on
"For more info see:
" :help :filetype-overview
filetype plugin indent on


"can't forget those line numbers!
set number

"change the mapleader from \ to ,
let mapleader=";"

"let g:table_mode_header_fillchar="="

"If you use upper and lowercase in your expression it will do a case
"sensative search.
"/copyright     case insensitive
"/Copyright     case sensitive
"/copyright\C   case sensitive
"/Copyright\c   case insensitive
"Both ignorecase and smartcase need to be set in order for smartcase to
"workThe 'smartcase' option only applies to search patterns that you type; it
"does not apply to * or # or gd. If you press * to search for a word, you can
"make 'smartcase' apply by pressing / then up arrow then Enter (to repeat the
"search from history).
set ignorecase
set smartcase

"Turn on doxygen syntax hilighting.
set syntax=cpp.doxygen

"Use linux line endings
set fileformat=unix

"Change the default colorscheme.
colorscheme murphy

augroup commentarySettings
    autocmd FileType c,cpp setlocal commentstring=//\ %s
augroup END


"------------------------------------------------------------------------------
"Spell checking, auto-completion, thesaurus lookup etc..
"------------------------------------------------------------------------------
"
"Word / Pattern Completion     Ctrl-x Ctrl-n or CTRL-x CTRL-p
"Line Completion               Ctrl-x Ctrl-l
"File Name Completion          Ctrl-x Ctrl-f
"*Dictionary Word Completion   Ctrl-x Ctrl-k
"*Thesaurus                    Ctrl x + Ctrl t

"This is to enable using a thesaurus.
" To use press    Ctrl x + Ctrl t
" The thesaurus file that I use can be downloaded from:
" http://www.gutenberg.org/dirs/etext02/mthes10.zip
set thesaurus+=~/mthesaur.txt

"seting up a dictionary to use.
"With this we can use Ctrl x + Ctrl K  to get into the dictionary
"then we can cycle through our options with Ctrl n and Ctrl p
set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words

"While in insert mode CTRL-N and CTRL-P will cycle through a predetermined
"set of completion sources. By default, dictionary completion is not a part
"of this set. This set is defined by the 'complete' option. Therefore, we
"must add dictionary to this as shown below:
"This is from: http://vim.wikia.com/wiki/VimTip91
set complete-=k complete+=k
"Now, while in insert mode we can type the following to complete a word:
"Ctrl n   Ctrl n

autocmd BufNewFile,BufRead,BufReadPost *.qml set filetype=javascript

let g:ale_fixers = {
\   'python':   ['isort', 'black'],
\   'sh':       ['shfmt'],
\   'xml':      ['xmllint'],
\}

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" let g:ale_fixers = {
" \   '*':        ['remove_trailing_lines', 'trim_whitespace'],
" \   'c':        ['clang-format'],
" \   'cpp':      ['clang-format'],
" \   'diff':     [],
" \   'python':   ['isort', 'black'],
" \   'sh':       ['shfmt'],
" \   'tex':      ['latexindent'],
" \}
"
let g:ale_linters = {
\   'python':   ['pyls'],
\}

" let g:ale_linters = {
" \   'python':   ['pydocstyle', 'pylint', 'pyls'],
" \   'tex':      ['chktex'],
" \   'cpp':      ['clangd'],
" \}

"//////////////////////////////////////////////////////////////////////////////
"------------------------------------------------------------------------------
"Key Mappings
"------------------------------------------------------------------------------
"//////////////////////////////////////////////////////////////////////////////


"Function keys
"------------------------------------------------------------------------------

"Temporarily switch to “paste mode”. Paste while in insert mode.
set pastetoggle=<F2>

" Going to use ale for this instead.
" Format xml
"map <F3> :silent %!xmllint --encode UTF-8 --format -<CR>

"I don't use this, especially with linters and fixers I shouldn't need it.
"View trailing spaces
"map <F4> /\s\+$<CR>
"noremap <S-F4> :%s/\s\+$//e<CR>
map <F4> :call CurtineIncSw()<CR>

"Map <F5> to open a new tab with the .vimrc file
"Used for fast access.
map <F5> :tabnew $MYVIMRC<CR>

"I used this once, I don't think I would even remember the key mapping.
" https://stackoverflow.com/a/2148221/13305464 
" If you haven't changed the mapleader variable, then activate the mapping with
" \q" \q' or \qd. They add double quote around the word under the cursor,
" single quote around the word under the cursor, delete any quotes around the
" word under the cursor respectively.
":nnoremap <Leader>w" ciw""<Esc>P
":nnoremap <Leader>w' ciw''<Esc>P
":nnoremap <Leader>wd daW"=substitute(@@,"'\\\|\"","","g")<CR>P


" like above, I don't really use this.
"nmap <silent> <F6> <Plug>MarkdownPreview        " for normal mode
"imap <silent> <F6> <Plug>MarkdownPreview        " for insert mode
"nmap <silent> <S-F6> <Plug>StopMarkdownPreview    " for normal mode
"imap <silent> <S-F6> <Plug>StopMarkdownPreview    " for insert mode

" Toggle spell checking with <F7>
nn <F7> :setlocal spell! spell?<CR>

" Cycle through different numbering schemes.
map <F8> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>

" Cycle forward through colorschemes with <F9> and cycle through them backwards with <S-F9>
noremap <silent> <F9> :call ChangeColor(1)<CR>
set <S-F9>=[20;2~
noremap <silent> <S-F9> :call ChangeColor(-1)<CR>

" Toggle showing whitespace.
noremap <F10> :set list!<CR>
inoremap <F10> <C-o>:set list!<CR>
cnoremap <F10> <C-c>:set list!<CR>


"Other key mappings
"------------------------------------------------------------------------------

"command maps // in visual mode to run the commands y/<C-R>"<CR> which copies
"the visually selected text, then starts a search command and pastes the
"copied text into the search. <C-R> represents Ctrl-R and <CR> represents
"carriage return (Enter).
"http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap // y/<C-R>"<CR>


nnoremap <Leader>s :%s/\<<C-r><C-w>\>/


" Copy visual selection to clipboard.
vnoremap <C-y> :'<,'>:w !xclip -selection clipboard<CR><CR>

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv


"-------------------------------------------------------------------------------
"Functions
"-------------------------------------------------------------------------------


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
