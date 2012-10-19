" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim
"let $VIMRUNTIME="/usr/share/vim/vim72"
"set runtimepath=/usr/share/vim/vim72

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
"if has("syntax")"
  syntax on
"endif"

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
set mouse=a		    " Enable mouse usage (all modes)
set backspace=2
filetype on
filetype plugin on
filetype indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 只在下列文件类型被侦测到的时候显示行号，普通文本文件不显示

if has("autocmd")
 autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby set number
 autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
 autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o/*<ESC>'>o*/
 autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=100
 autocmd Filetype html,xml,xsl source $VIMRUNTIME/plugin/closetag.vim
 autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif
endif " has("autocmd")

" F5 make for C++ and quickfix window
set makeprg=g++\ %\ -g\ -o\ a.out 

" F6运行C++程序(F5 should before F6, or no executable a.out)
" C++的运行
map <F6> :call CompileRunGpp()<CR>
func! CompileRunGpp()
"exec "w"
"exec "!g++ -Wall % -o %<"
exec "! ./a.out"
endfunc 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimgdb setting
" F7 gdb mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set previewheight=24 
"set splitbelow 
"set splitright 
run macros/gdb_mappings.vim 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"tagbar plugin show variables and functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F8> :TagbarToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TagList plugin show variables and functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" show current file tag
let Tlist_Show_One_File=1
" quit if last file closed
let Tlist_Exit_OnlyWindow=1
" show taglist when start
"let Tlist_Auto_Open=1
" on the right
let Tlist_Use_Right_Window=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"neocomplcache
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OmniCppComplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q %<CR>
" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"automatically open and close the popup menu / preview window
"autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,menuone,longest ",preview
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoComplPop
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto start or not
"let g:acp_enableAtStartup = 1
" 0 CursorMovedI or 1 Key triggered
"let g:acp_mappingDriven = 0
"for tab and space 
"let g:pumselect = 0
"inoremap <expr> <TAB>   MaySelect()
"function MaySelect()
"	if(pumvisible())
"		let g:pumselect = 1 
"		return "\<DOWN>"
"	endif
"	return "\<TAB>"
"endfunc
"
"inoremap <expr> <Space> MayComplete()
"func MayComplete()
"	if (pumvisible() && g:pumselect)
"		let g:pumselect = 0 
"		return "\<CR>"
"	endif
"	return "\<Space>"
"endfunc
"
"inoremap <expr> <CR> StateChangeEnter()
"func StateChangeEnter()
"	let g:pumselect = 0 
"	return "\<CR>"
"endfunc

" C的编译和运行
"map <F7> :call CompileRunGcc()<CR>
"func! CompileRunGcc()
"exec "w"
"exec "!gcc -Wall % -o %<"
"exec "! ./%<"
"endfunc

" C++的编译和运行debug版本
"map <F9> :call CompileRunGpp2()<CR>
"func! CompileRunGpp2()
"exec "w"
"exec "!g++ -g -Wall % -o %<"
"exec "! ./%<"
"endfunc 

" 粘帖和复制
map <C-A> ggvG<END>
"map <C-C> "+y
"map <C-V> "+p

set nu
set autoindent
set cindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set t_Co=8
colorscheme inkpot

" python indent
autocmd FileType python setlocal et sta sw=4 sts=4



" Source a global configuration file if available
"if filereadable("/etc/vim/vimrc.local")
" source /etc/vim/vimrc.local
"endif
if &term=="xterm"
    set t_Co=256
	    set t_Sb=^[[4%dm
		    set t_Sf=^[[3%dm
endif


"加入程序头
autocmd BufNewFile *.[ch],*.hpp,*.cpp exec ":call SetTitle()" 
"加入注释
func SetComment()
	call setline(1,"/*===============================================================") 
	call append(line("."),   "*   Copyright (C) ".strftime("%Y")." All rights reserved.")
	call append(line(".")+1, "*   ") 
	call append(line(".")+2, "*   file: ".expand("%:t")) 
	call append(line(".")+3, "*   author: ivapple")
	call append(line(".")+4, "*   date: ".strftime("%Y-%m-%d")) 
	call append(line(".")+5, "*   description: ") 
	call append(line(".")+6, "*")
	call append(line(".")+7, "*   update log: ") 
	call append(line(".")+8, "*") 
	call append(line(".")+9, "================================================================*/") 
endfunc

"定义函数SetTitle，自动插入文件头 
func SetTitle()
	call SetComment()
	call append(line(".")+10, "#include <cstdlib>") 
	call append(line(".")+11, "#include <cstdio>")
	call append(line(".")+12, "")
	call append(line(".")+13, "#include <iostream>")
	call append(line(".")+14, "")
	call append(line(".")+15, "#define out(x) (cout<<#x<<\": \"<<x<<endl)")
	call append(line(".")+16, "")
	call append(line(".")+17, "#define FOR(i,s,t) for(i=s; i<t; i++)")
	call append(line(".")+18, "")
	call append(line(".")+19, "using namespace std;")
	call append(line(".")+20, "")
	call append(line(".")+21, "template<class T>void show(T a, int n){int i; for(i=0;i<n;i++)cout<<a[i]<<\" \";cout<<endl;}")
	call append(line(".")+22, "")
	call append(line(".")+23, "template<class T>void show(T a, int r, int l){int i; for(i=0;i<r;i++)show(a[i],l);cout<<endl;}")
	call append(line(".")+24, "")
endfunc
