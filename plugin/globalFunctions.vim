""" disabled, as it gave errormessage when vimproc was installed
"function SearchAll(regex)
"        let i = 0
"        let current_buffer = winbufnr(0)
"        execute "buffer" current_buffer
"
"        let line_no = search(a:regex)
"        let next_buffer = current_buffer
"        while line_no == 0
"                let last_buffer = bufnr("$")
"
"                let next_buffer = next_buffer + 1
"                while ! bufexists(next_buffer)
"                        let next_buffer = next_buffer + 1
"                        if (next_buffer > last_buffer)
"                                let next_buffer = 1
"                        endif
"                endwhile
"
"                execute "buffer " . next_buffer
"
"                if next_buffer == current_buffer
"                        echoerr "Expression " . a:regex . " not found in open buffers"
"                        return
"                endif
"
"                let line_no = search(a:regex)
"        endwhile
"endfunction
"
"command -nargs=1 SearchAll call SearchAll("<args>")
