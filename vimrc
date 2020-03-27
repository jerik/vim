"	VIM Konfiguration Datei
"	jerik

"	Villeicht interessant:
"	http://cscope.sourceforge.net/cscope_vim_tutorial.html
"	http://kien.github.io/ctrlp.vim/ - tool for file searching
"	https://github.com/rking/ag.vim/blob/master/README.md - tool for file searching
"	https://github.com/osyo-manga/vim-over - see search and replaces before you execute
"	http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
"	Vim Scripting http://andrewscala.com/vimscript/, see as well pdf in .vim
"	http://web.stanford.edu/~ryanlee/posts/2015-07/vim

"	@todo Julian support
"	http://www.lindonslog.com/linux-unix/send-lines-code-vim-r-julia-python-repl-slime/
"	https://github.com/jpalardy/vim-slime
"	https://github.com/JuliaEditorSupport/julia-vim
"	https://github.com/tpope/vim-commentary

let mapleader = '-'
" 2017-04-08 test for vim-pipe
" http://learnvimscriptthehardway.stevelosh.com/chapters/06.html
let maplocalleader = ','

"	Kein piepen
set	noerrorbells
  
"	Globale einstellungen für Tabstop und shiftwidth
set	tabstop=4
set sw=4

"	Visuelles Klingeln anstat normales piepen
set visualbell

"	Automatisches einrücken 
set autoindent
 
"	autowrite: Automatically save modifications to files
"	when you use critical (rxternal) commands.
set autowrite

"	backspace:  '2' allows backspacing" over
"	indentation, end-of-line, and start-of-line.
"	see also "help bs".
set backspace=2

"	esckeys:    allow usage of cursor keys within insert mode
"	You will find this useful when working, eg, on SunOS.
set esckeys

"	hidden:  Allow "hidden" buffers.  A must-have!
set hidden

"	hlsearch :  highlight search - show the current search pattern
"	This is a nice feature sometimes - but it sure can get in the
"	way sometimes when you edit.
set nohlsearch

"	ignorecase:  ignore the case in search patterns?  NO!
set noignorecase

"	Color of the search
"	GUI
hi Search guibg=cyan guifg=black
"	Terminal
hi Search cterm=NONE ctermfg=black ctermbg=cyan

"	laststatus:  show status line?  Yes, always!
"	laststatus:  Even for only one buffer.
set laststatus=2

"	magic:  Use 'magic' patterns  (extended regular expressions)
"	in search patterns?  Certainly!  (I just *love* "\s\+"!)
set magic

"	modeline:    ...
"	Allow the last line to be a modeline - useful when
"	the last line in sig gives the preferred textwidth for replies.
set modeline
set modelines=1

"	ruler:       show cursor position?  Yep!
set ruler

"	number:      Zeilennummer: nein
set nonumber

"	showcmd:     Show current uncompleted command?  Absolutely!
set showcmd

"	showmatch:   Show the matching bracket for the last ')'?
set showmatch

"	showmode:    Show the current mode?  YEEEEEEEEESSSSSSSSSSS!
set showmode

" 2016-12-19 http://stackoverflow.com/questions/41186370/vim-displays-content-of-file-with-signs
:set encoding=utf-8

"	splitbelow:  Create new window below current one.
set splitbelow
"	
"	statusline:  customize contents of the windows' status line.
"	I prefer it this way:
"	Show the current buffer number and filename with info on
"	modification, read-only, and whether it is a help buffer
"	(show only when applied).
"	set   statusline=[%n]\ %f\ %(\ %M%R%H)%)
"	set   statusline=[%n]\ %f\ %(\ %M%R%H)%)\=Pos=<%l\,%c%V>\ %P\=ASCII=%b\ HEX=%B)%=(c)\ Michael\ Prokop
"	Meine favorisierte statusline:
"	is now overrule by air-line
set statusline=%<[%n]\%f\%y\%r\%1*%m%*%w%=%(Spalte:\%c%V%)%4(%)%-10(Zeile:\%l%)\%4(%)%p%%\%P\ \ \ \ ASCII=%b\ HEX=%B\ \ \ \ \ [jerik]

"	ttyscroll:      turn off scrolling -> faster!
set ttyscroll=0
  
"	whichwrap:
"	Allow jump commands for left/right motion to wrap to previous/next
"	line when cursor is on first/last character in the line:
set whichwrap=<,>,h,l,[,]

"	wrapmargin:
"	When do you want the line to break? A value of 1 means that 1
"	"cursor" before the end of the visible screen.
"	if wrapmargin=n, then the wrapping occurs if the distance to the
"	right screen-border is "n" spaces
set wrapmargin=1

"	Run the after ftplugin on startup"
filetype plugin on

"	Swapfiles nicht ins gleich verzeichnis schreiben, sondern in ein spezielles
if has( "win32" )
	set dir=C:\swps
elseif has("macunix")
	set dir=/usr/local/swps
else
	set dir=/usr/local/swps
endif

" 	copy paste with system clipboard on Windows
" set clipboard=unnamed
" 	jerik: 20141020
" 	see :Tweak # looks interesting let's try :)

" Fullscreen when opening vim # for winwos
" http://unix.stackexchange.com/questions/40047/vim-script-check-running-platform
if has( "win32" )
	au GUIEnter * simalt ~x
endif

"Rails configuraiton - 2006-07-13 "
"see: :h rails"
"autocmd User Rails* Lcd
"let g:rails_level=4

"	Switch syntax highlighting on, when the terminal has colors
"	Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" 20170222 set font for graphical vim, to support EUR sign"
" http://www.troubleshooters.com/linux/vifont.htm
" set gfn=DejaVu_Sans_Mono:h11:cANSI @todo jerik should be a font that works on OSX/Linux
" Font names must be without whitespace: s/ /_/g
set guifont=Meslo_LG_M_Regular_for_Powerline:h12

" 	Projects notes mit neuer Syntax versehen
au BufRead,BufNewFile *.log set filetype=plog 


" 	jerik 20141014
" 	Realod listed files if they are saved
" 	http://www.bestofvim.com/tip/auto-reload-your-vimrc/
" augroup reload_vimrc "{ 
"	autocmd!
"	autocmd BufWritePost $MYVIMRC so $MYVIMRC
" augroup "}

"	jerik 20141014
"	DOES NOT WORK
"	http://stackoverflow.com/questions/11068128/how-to-disable-vim-autocomplete-popup-for-plain-text-files
" autocmd WinEnter * :if &ft=='vim' | DisableAcp | else | EnableAcp | endif

"	jerik 20141014 
"	@todo Do I need the tweak.vim or merge into .vimrc?
"	Rehash: Reload my vim configuration files"
function! Rehash()
	":so $HOME/vimfiles/plugin/tweak.vim
	":so $HOME/vimfiles/plugin/sandbox.vim
	exec ":so " . MyVimFolder() . "/plugin/tweak.vim"
	exec ":so " . MyVimFolder() . "/plugin/sandbox.vim"
	echom "Reloaded tweak.vim, sandbox.vim"
endfunction
command! Rehash call Rehash()

filetype plugin indent on     " Required!

" https://github.com/junegunn/vim-plug/wiki/faq
" @todo vimfiles should be a variable which is .vim or vimfiles, based on the OS
" To install run :PlugInstall
" To remove, update vimrc, :so vimrc, :PlugClean
call plug#begin('~/.vim/plugged')
""Plug 'junegunn/seoul256.vim'
""Plug 'junegunn/goyo.vim'
""Plug 'junegunn/limelight.vim'
"Plug 'jelera/vim-javascript-syntax'
"Plug 'Raimondi/delimitMate'
"Plug 'https://github.com/garbas/vim-snipmate.git'
"Plug 'tomtom/tlib_vim' "# not sure for which use case it is
"Plug 'MarcWeber/vim-addon-mw-utils' "# not sure for which use case it is
"Plug 'garbas/vim-snipmate'
" for more vim-python stuff see: https://stackabuse.com/vim-for-python-development/
"Plug 'honza/vim-snippets'
" https://vimawesome.com/plugin/python-mode python-mode vs flake8
"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
" runs with F7, needs to have pip3 install flake8 for the venv! use :cnext, :cprevious
Plug 'nvie/vim-flake8'
" not sure if syntastic works, lets see if there is commign something :)
Plug 'vim-syntastic/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'davidhalter/jedi-vim'
" Plug 'ervandew/supertab' " 2019-12-01 disabled supertab, perhaps it interferes with ultisnips
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-commentary'
"Plug 'krisajenkins/vim-pipe' "# 2019-10-01 not usefull for python"
""Plug 'tpope/vim-fugitive'  "# 2019-10-01 not working, get errors, cannot execute :Git"
Plug 'NLKNguyen/papercolor-theme'
Plug 'gabrielelana/vim-markdown'
"   Multiple Plug commands can be written in a single line using | separators
"   https://yufanlu.net/2016/10/30/ultisnips/ cool usage tips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
call plug#end()

" disable spell checking 
let g:markdown_enable_spell_checking = 0

" flake8 configurations -- seems not ot work; Die Spalte mit der Anzeige in
" der Datei wird nicht mehr angezeigt, der fehler taucht noch im
" dialog-fenster auf
" see: https://github.com/vim-syntastic/syntastic/issues/204
" let g:syntastic_python_checker_args='--ignore=E501'
let g:syntastic_python_flake8_post_args='--ignore=E501,E401'
"let g:syntastic_python_flake8_post_args='--ignore=E501,E128,E225'

" 2019-12-01 ultisnip configuration 
" The below shortcuts are the default wonesss. See help: Trigger key mappings
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsListSnippets="<c-tab>
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"


" TODO @todo vim-airline # Needs the powerline fonts, installed. Does not work out of the box

" better colorschema"
"color jerik
colorscheme fruchtig
" colorscheme PaperColor
if has("gui_running")
	set background=light
endif
