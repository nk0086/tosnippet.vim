command! ToSnippet call ToSnippet()
function! ToSnippet() abort
    if exists('g:tosnippet#save_directory')
		let l:save_directory = g:tosnippet#save_directory
	else
		let l:save_directory = expand('~/.vim/snippets')
	endif

    let file_path = expand("%")
    let file_extention = expand("%:e")
    " read ../extentions.json
    let l:extentions = json_decode(readfile(expand("~/.vim/bundle/vim-tosnippet/extentions.json")))
    let l:extention = l:extentions[file_extention]

    let flag = 0
    let lines = readfile(file_path)
    let snippet = []
    let snippet_name = ""
    for i in range(len(lines))
	if lines[i] =~ "@snippet"
	    let list = split(lines[i], ":")
	    let snippet_name = list[1]
	    let snippet += ["snippet ".list[1]]
	    let flag = 1
	    continue
	endif

	if flag == 1
	    if lines[i] =~ "@endsnippet"
		let flag = 0
		break
		endif
	    let snippet += ["    ".lines[i]]
	endif
    endfor

    let file_name = save_directory.extention./".snippet_name.".snip"   
    " write to file from snippet
    call writefile(snippet, file_name)
endfunction
