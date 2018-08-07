" Boost programming in vim
" 05.04.2017 perhaps obsolete with https://github.com/Raimondi/delimitMate
"inoremap { {  }<LEFT><LEFT>
"inoremap [ []<LEFT>
"inoremap ( (  )<LEFT><LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"inoremap \| \|\|<LEFT>

" Toogle ignorecase on search
" http://stackoverflow.com/a/2317808/19335
nmap <F9> :set ignorecase! ignorecase?<CR>

" 	Use Leader c and Leader v to copy and paste using the OS clipboard: 
map <Leader>v "+gP 
map <Leader>c "+y
" 	http://vim.wikia.com/wiki/Quick_command_in_insert_mode 
"	insert OS clipboard in insert mode
" inoremap VV <Esc>"+gp "works but leaves me in the normal mode, not the insert mode
" 	http://stackoverflow.com/q/26486948/1933185
inoremap VV <C-r>+

"ruby support"
"inoremap <% <%=   %> <LEFT><LEFT><LEFT><LEFT><LEFT>
"inoremap ,end <% end  %> 
"inoremap ,if <% if   %> <LEFT><LEFT><LEFT><LEFT><LEFT>

"	Rechtschreibfehler automatisch verbessern
"	See also:  http://www.igd.fhg.de/~zach/programs/acl/
iab alos    also
iab aslo    also
iab sonder	sondern

" 	hilfreiche Ersetzungen
iab ydate <C-R>=strftime("%d.%m.%Y")<CR>
iab isodate <C-R>=strftime("%Y-%m-%d")<CR>

"	Verbessertes arbeiten im Vim
nmap ,h <ESC>:Myhelp<CR>
" Open vimrc with ,v shortcut
nmap ,v <ESC>:e $MYVIMRC<CR>

" 	Move between splitted windows
nmap ,< <C-W>w
""nmap ö f"a
" 20150213 Was bringt mir das?
nmap <M-v> f"a

" jerik 20150213 get easy access to tweak and sandbox
function! MyVimFiles( command )
	"
	"default is tweak.vim
	let s:file = "/plugin/tweak.vim"

	if a:command == "myhelp"
		let s:file = "/doc/jerik.txt"
	elseif a:command == "sandbox"
		let s:file = "/plugin/sandbox.vim"
	endif
	echo s:file
    ""exec ":e $HOME/" . s:vimfolder . s:file
    ""exec ":e $HOME/" . MyVimFolder() . s:file
    exec ":e " . MyVimFolder() . s:file
endfunction

" jerik 20150213 return the vim folder based on the current OS
function! MyVimFolder(  )
	let s:vimfolder = ".vim"
	if has( "win32" )
		let s:vimfolder = "vimfiles"
	endif 
	return "$HOME/" . s:vimfolder
endfunction


" Perhaps switch for OS needed, as vimfiles is in *nix .vim "
":command! Sandbox :e $HOME/vimfiles/plugin/sandbox.vim
":command! Tweak :e $HOME/vimfiles/plugin/tweak.vim
command! Sandbox call MyVimFiles( "sandbox" )
command! Tweak call MyVimFiles( "tweak" )
command! Myhelp call MyVimFiles( "myhelp" )

imap ;; <ESC>:normal A;<CR>:w<CR>
nmap ;; <ESC>:normal A;<CR>:w<CR>

"	001201:  Deleting text in normal mode
"	using the BackSpace and Delete keys:
nmap <BS>  X
nmap <DEL> x
nmap <F12> <ESC>:w<CR>

"	jerik: Löschen von Text im insert mode
"	WICHTIG, die Backspacetaste löscht wie sie soll nach <--
imap <DEL> <DEL>
imap <F12> <ESC>:w<CR>

"	jerik: zwischen den Buffern wechseln - vorwärts"
" Entfernen Taste (Funktionalität) auch über shift + Backspace
nmap <C-Tab> :bn<CR>
imap <C-Tab> :bn<CR>
" verfügbar machen.
""imap <S-BS> <DEL>

" jerik 2009-02-10: Text in den zwischenspeicher kopieren, damit man diesen woanders mit strg + v einfügen kann
" http://codecocktail.wordpress.com/2008/10/27/vim-copypaste/
" normalerweise um eine zeile zu kopieren: "+dd
nmap <M-d> "+dd

"" jerik: Sobald ich mich im Vim mit dem Cursor bewege verschwinden alle search highligts
"" Tip: 14 http://www.vim.org/tips/tip.php?tip_id=14 in den Comments
""map j <Down>:noh<CR>
""map k <Up>:noh<CR>
""map h <Left>:noh<CR>
""map l <Right>:noh<CR>

" ************************ old mygft.vim

" my project vim

" For a better workspace logfiles 
iab ato		@todo
iab atn 	@todo-next
iab atw		@todo-wait
iab atc 	@todo-changes
iab tb		@thinkbox
"iab atp		@todo :prototyp
iab <expr> heu strftime("=%Y%m%d")
"iab <expr> tom strftime("%%%Y%m%d", localtime(  ) + ( 24*3600 ))
iab <expr> nwe strftime("%%%Y%m%d", localtime(  ) + ( 7*24*3600 ))

" Add *unwanted* carriage return
""iab tom <C-o>:r !date -v+1d "+=\%Y\%m\%d"<CR>
""iab too <ESC>:r !ruby -e "puts (Time.now + 24*60*60).strftime('\%Y\%m\%d')"<CR>   

" Strip tags from buffer "
" http://aftnn.org/post/47880443079/strip-tags-in-a-vim-buffer
:command! STag :%s/<\_.\{-1,\}>//g  

" format @Todo to @todo
" As iOS replace of ato is @Todo insteal of @todo
:command! Ctodo :%s/^@Todo/@todo/g  

" 	jerik 20141015
" 	Show all tags in my journal. A tag is =tag =test =foobar
:command! Tags /=\w\+

" 	jerik 20141013
" 	add bullet points '-' in front of sentences"
" 	Example: 
"    this is a point
"       and this is another point
" 	After the command: 
"  	 - this is a point
"      - and this is another point
" 	mainly used to format lists that I take via copy/paste into vim
:command! List :'<,'>s/\w/- &

" um mit project_notes besser zu arbeiten
""nmap ,d <ESC>:s/@todo-next/@done/<CR>:w<CR>
" replaces no every variation of @todo*"
nmap ,d <ESC>:call ToDo( "done" )<CR>
nmap ,w <ESC>:call ToDo( "wait" )<CR>
nmap ,o <ESC>:call ToDo( "todo" )<CR>
nmap ,c <ESC>:call ToDo( "cancel" )<CR>
nmap ,p <ESC>:call ToDo( "postponed" )<CR>
nmap ,x <ESC>:call ToDo( "notmybusiness" )<CR>
" move = delegated
nmap ,m <ESC>:call ToDo( "delegated" )<CR>
" alte vergangene Sachen die nicht gemacht wurden
nmap ,a <ESC>:call ToDo( "past" )<CR> 
"
"nmap ,d <ESC>:Tododone<CR>:w<CR>
"nmap ,o <ESC>:Todotodo<CR>:w<CR>
"nmap ,c <ESC>:Todocancel<CR>:w<CR>

"nmap ,d <ESC>:s/@todo.\{-} /@done /<CR>:w<CR>
"nmap ,w <ESC>:s/@todo.\{-} /@todo-wait /<CR>:w<CR>
"nmap ,c <ESC>:s/@todo.\{-} /@canceled /<CR>:w<CR>
nmap ,n <ESC>:s/@todo/@todo-next/<CR>:w<CR>
nmap ,t <ESC>:call NewTodos()<CR>
nmap ,u <ESC>:call NextTodos()<CR>
nmap ,l <ESC>:Log<CR>
nmap ,f <ESC>:call FindCurrentLine()<CR>

" Filter the todo-next from the log files
:command! Tn :call NextTodos()


" Pfade sollte betriebssystem unahbÃ¤ngig sein. ruby funktion die dann den Pfad
" zusammenbaut...
:command! Mark Marketing
:command! Marketing :e mitschriften/marketing.mkd
:command! Zeug Zeugnis
:command! Zeugnis :e mitschriften/zeugnisse.mkd
:command! Kon Konzept
:command! Konzept :e mitschriften/vilit-konzept.mkd
:command! Log :e logs/project_notes.mkd

" Not used
:command! Issue :e ..\log\issue.log
:command! Lessons :e ..\log\lessons_learned.log
:command! Decisions :e ..\log\decisions.log
:command! Notes :e ..\log\project_notes.log
:command! Com :e ..\plan\communication.plan

" call with arguments next, wait, 
" bugfix: command should work
function! NewTodos() 
	" :let tempfile = tempname()
	:let tempfile = "~/AppData/Local/Temp/Journal-VIC537C.tmp"
	"":echo tempfile
	:exe 'e ' . tempfile
	" delete all existing lines, see
	" https://alvinalexander.com/linux-unix/vi-vim-delete-all-lines-how
	:1,$d
	:r ~\workspace\logs\Journal.log
	:silent v/^@todo/d
	" reverse list, does not work correctly
	:g/^/m0		
	:w
	:syn match String "^@todo"
endfunction 

function! NextTodos()
	:let tempfile = "~/AppData/Local/Temp/Journal-VIC777C.tmp"
	:exe 'e ' . tempfile
	" delete all existing lines, see
	" https://alvinalexander.com/linux-unix/vi-vim-delete-all-lines-how
	:1,$d
	:r ~\workspace\logs\Journal.log
	:silent v/-next\|-wait\|-periodic/d
	" reverse list, does not work correctly
	:g/^/m0		
	:sort
	:execute "normal gg"
	" https://stackoverflow.com/a/21277670/1933185
	:put =readfile(expand('~\workspace\logs\Journal.log'))[1:19]
	" http://learnvimscriptthehardway.stevelosh.com/chapters/29.html
	:execute "normal ggdd"
	:w
	:syn match String "-next"
	:syn match Comment "-periodic"
	:syn match Special "-wait"
endfunction

function! FindCurrentLine()
	:let line = getline('.')
	:e ~\workspace\logs\Journal.log
	:exe '/' . line
endfunction


" make some enhancements"
if has('ruby')

function! TodosOld()
	"":exe 'e ' . tempname()
	:exe 'e $HOME/todos.tmp'
	:normal ggVGd
	:set ft=markdown
	ruby << EOF
	class Jerik
		def initialize
			@workspace = File.join( 'D:', 'Data.GFTUser', 'workspace' )
			#@workspace = File.join( 'C:', 'Zurich' )
		end

		def todos
			@todos = Hash.new
			@todos[:past] = Array.new
			@todos[:today] = Array.new
			@todos[:next_action] = Array.new
			@todos[:waiting_for] = Array.new
			# @todos[:todos] = Array.new

			# for file in dir_files( 'project_notes.mkd' ) do 
			#	project_name = get_project_name( file )
			#	f = File.open( file )
  			#	f.grep(/@todo/).each do |line| 
			#		if line.size > 11
			#			@todos[:next_action].push( "''"+project_name+"'' " + line ) if /@todo-next/.match( line )
			#			@todos[:waiting_for].push( "''"+project_name+"'' " + line ) if /@todo-wait/.match( line )
			#		end
			#	end
			#	f.close
			#end

			project_name = :vilit
			today = Time.now.strftime( '%%%Y%m%d' )
			f = File.open( File.join( '', 'Users', 'jerik', 'repos', 'jerik', 'logs', 'project_notes.mkd' ) )
			f.grep(/@todo/).each do |line| 
				if line.size > 11
					#@todos[:next_action].push( "''"+project_name+"'' " + line ) if /@todo-next/.match( line )
					#@todos[:waiting_for].push( "''"+project_name+"'' " + line ) if /@todo-wait/.match( line )
					@todos[:past].push( line ) if past( line )
					@todos[:today].push( line ) if /#{ today }/.match( line )
					@todos[:next_action].push( line ) if /@todo-next/.match( line )
					@todos[:waiting_for].push( line ) if /@todo-wait/.match( line )
					# @todos[:todos].push( line ) if /@todo*/.match( line )
				end
			end
			f.close

			@buffer = VIM::Buffer.current
			vimputs( "# PAST ( Abgelaufen !! )" )
			@todos[:past].each do |item| vimputs( item.chomp ) end
			vimputs( "" )
			vimputs( "# TODAY " + today + "( Should be finished today)" )
			@todos[:today].each do |item| vimputs( item.chomp ) end
			vimputs( "" )
			vimputs( "# NEXT ACTIONS" )
			@todos[:next_action].each do |item| vimputs( item.chomp ) end
			vimputs( "" )
			vimputs( "# WAITING FOR" )
			@todos[:waiting_for].each do |item| vimputs( item.chomp ) end
			vimputs( "" )
			# vimputs( "# TODOS" )
			# @todos[:todos].each do |item| vimputs( item.chomp ) end
			vimputs( "" )
		end

		def past( line )
			result = line.scan( /%([0-9]+)/ )
			ret = false; 
			if ( ! result.empty? )
				result.each do |datum|
					ret = true if ( datum[0].to_i < Time.now.strftime( '%Y%m%d' ).to_i ) 
				end
			end
			return ret
		end

		def dir_files(type)
			pattern = File.join( @workspace, '**', type )
			Dir.glob(pattern)
		end

		def get_project_name(file) 
			container = file.split("#{File::SEPARATOR}"); 
			project_name = container[-3]
		end

		def vimputs(s)
			@buffer.append(@buffer.count,s)
		end
	end
	Jerik.new.todos
EOF
	:exe 'w!' 
endfunction 

"command! Todos :call Todos()
command! Todos :call NewTodos()

function! Finished(type)
" type = done | open | canceled | todo-wait | todo
	ruby << EOF
	class Finished
		def initialize
			type = Vim.evaluate( 'a:type' )
			@buffer = VIM::Buffer.current
			line = @buffer.line
			num = @buffer.line_number
			@buffer.delete( num )

			filename = @buffer.name 
			@logfile = File.join( '', 'Users', 'jerik', 'repos', 'jerik', 'logs', 'project_notes.mkd' )

			if @logfile == filename
				#@buffer.append( ( num - 1 ), line.gsub( /@todo.*? /, "@#{ type }:#{ Time.now.strftime( '%Y%m%d' ) } " ))
				#@buffer.append( ( num - 1 ), line.gsub( /@todo.*? /, "@#{ type }#{ Time.now.strftime( ':%Y%m%d' ) if type != "todo-wait" } " ))
				@buffer.append( ( num - 1 ), line.gsub( /@todo.*? /, "@#{ type }#{ Time.now.strftime( ':%Y%m%d' ) if ! type.match(/todo/) } " ))
			else
				editLogLine( line, type )
			end
		end

		def editLogLine( pattern, type )
			require 'tempfile'
			require 'fileutils'
			path = @logfile
			temp_file = Tempfile.new('foo')
			begin
			  File.open(path, 'r') do |file|
				file.each_line do |line|
					if /#{ pattern }/.match( line ) 
						#temp_file.puts line.gsub( /@todo.*? /, "@#{ type }:#{ Time.now.strftime( '%Y%m%d' ) } " )
						#temp_file.puts line.gsub( /@todo.*? /, "@#{ type }#{ Time.now.strftime( ':%Y%m%d' ) if type != "todo-wait"} " )
						temp_file.puts line.gsub( /@todo.*? /, "@#{ type }#{ Time.now.strftime( ':%Y%m%d' ) if ! type.match( /todo/ ) } " )
					else
				  		temp_file.puts line
					end
				end
			  end
			  temp_file.rewind
			  FileUtils.mv(temp_file.path, path)
			ensure
			  temp_file.close
			  temp_file.unlink
			end
		end

	end
	Finished.new
EOF
endfunction 


""command! -nargs=1 Todo :call Todo("<args>")  
command! Todotodo :call Finished("todo")
command! Tododone :call Finished("done")
command! Todocancel :call Finished("canceled")
command! Todocwait :call Finished("todo-wait")

function! Search(type, pattern)
	"":exe 'e ' . tempname()
	:exe 'e $HOME/search.tmp'
	:normal ggVGd
	:set ft=markdown
	ruby << EOF
	class Search
		def initialize
			@done_file = File.join( '', 'Users', 'jerik', 'repos', 'jerik', 'logs', 'project_notes.mkd' ) 
		end

		def search
			@search = Hash.new
			@search[:search] = Array.new

			type = Vim.evaluate( 'a:type' )
			pattern = Vim.evaluate( 'a:pattern' )

			f = File.open( @done_file ) 
			f.grep(/#{ type }/).each do |line| 
				if line.size > 11
					@search[:search].push( line ) if /#{ pattern }/.match( line )
				end
			end
			f.close

			@buffer = VIM::Buffer.current
			vimputs( "# #{ type.upcase }: SEARCH FOR " + pattern )
			@search[:search].each do |item| vimputs( item.chomp ) end
			vimputs( "" )
		end

		def vimputs(s)
			@buffer.append(@buffer.count,s)
		end
	end
	Search.new.search
EOF
	:exe 'w!'
endfunction 

""command! -nargs=1 Todo :call Todo("<args>")  
command! -nargs=1 Tbox :call Search("@thinkbox","<args>")
command! -nargs=1 Todo :call Search( "@todo", "<args>" )
command! -nargs=1 Done :call Search( "@done", "<args>" )
command! -nargs=1 Find :call Search( " ", "<args>" )

endif


"relpace @todo wit @done"
function! ToDo( type )
" http://stackoverflow.com/a/26214054/1933185
" function! foo( ... )
" ... means, the function accept variable amount of parameters 0-n
" a:0 is the amount of parameters
" a:1 is the first parameter, a:2 is the second...

	if a:type == "done"
		:s/@todo\%(-\w\+\)* /@done / 
	elseif a:type == "wait"
		:s/@todo\%(-\w\+\)* /@todo-wait / 
		":s/@todo.\{-} /@todo-wait /
	elseif a:type == "todo"
		:s/@todo\%(-\w\+\)* /@todo / 
	elseif a:type == "cancel"
		:s/@todo\%(-\w\+\)* /@canceled / 
	elseif a:type == "postponed"
		:s/@todo\%(-\w\+\)* /@postponed / 
	elseif a:type == "next"
		:s/@todo\%(-\w\+\)* /@todo-next / 
	elseif a:type == "notmybusiness"
		:s/@todo\%(-\w\+\)* /@notmybusiness / 
	elseif a:type == "delegated"
		:s/@todo\%(-\w\+\)* /@delegated / 
	elseif a:type == "past"
		:s/@todo\%(-\w\+\)* /@past / 
	endif
	:w
endfunction
"command! ToDo call ToDo("done")

" Funktion von Nils, toggle damit im nowrap modus beim einfügen von Zeichen,
" die Zeile nicht umbricht
" http://deliberate-software.com/vim-refactoring-patterns/
function! ToggleTextWrap()
    if &fo =~ 't'
        set fo-=t
    else
        set fo+=t
    endif
endfunction
" F10: Highlight too long lines
"map<F10> :call ToggleTextWrap()<CR>
