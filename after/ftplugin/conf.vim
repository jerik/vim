" ruby << EOF
" class Projectnotes
" 	# http://vimdoc.sourceforge.net/htmldoc/if_ruby.html
" 	def initialize
" 		@buffer = VIM::Buffer.current
" 		startlog
" 	end
" 	def startlog
" 		@buffer.append(@buffer.count, Time.now.strftime( "##### %Y-%m-%d - %H:%M" ))
" 		@buffer.append(@buffer.count, "")
" 	end
" end
" gem = Projectnotes.new
" EOF
