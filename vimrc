"構文ハイライト
syntax on
"Vi互換をオフ
set nocompatible
"行番号の表示
set number
"入力した括弧に対応する括弧のハイライト
set showmatch
"入力時に自動的に前の行と同じインデントに
set autoindent
"高度なインデントの設定
set smartindent
"C言語の高度なインデントをする
set cindent
"行頭の余白内でTabを打ち込むと,'shiftwidth'との数だけインデントする
set smarttab
"ファイル保存時にバックアップファイルを作成
set nobackup
"カーソルのある行番号の表示
set ruler
"入力したコマンドを最下行に出力
set showcmd
"インクリメンタルサーチを行う
set incsearch
"検索時に大文字を含んでいたら大文字小文字を区別しない
set nosmartcase
"特定拡張子の新規ファイルを作成したときのテンプレート
"autocmd BufNewFile *.html 0r $HOME/.vim/template/html.txt
"autocmd BufNewFile *.ps 0r $HOME/.vim/template/postscript.txt
"入力補完の設定
setlocal omnifunc=syntaxcomplete#Complete
"新規lispファイルを作成したときの設定
let lisp_rainbow = 1
autocmd FileType lisp set nocindent | set lisp | let lisp_rainbow = 1 
autocmd FileType scheme set nocindent | set lisp | let lisp_rainbow = 1

set encoding=utf-8
set fileencodings=iso-2022-jp,sjis,utf-8
" 改行コードの自動認識
set fileformats=unix,dos,mac
"□とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"改行コードの自動認識"
set fileformats=unix,dos,mac
"Gauche対応のSchemeインデントを行う"
filetype indent on
aug Scheme
 au!
 autocmd FileType scheme set nosmartindent nocindent lispwords=define lisp
aug END
let is_gauche=1
"Lispファイルを開いたときの動作
aug Lisp
	au!
	autocmd FileType lisp set nocindent nosmartindent lisp
aug END

let g:use_xhtml = 1
let g:html_use_css = 1
let g:html_no_pre = 1

"バッファを自動的に保存"
autocmd InsertLeave *  silent! wall
set autowrite
autocmd CursorHold *  silent! wall
autocmd CursorHoldI *  silent! wall

nnoremap <C-w>h <C-w>h:call <SID>good_width()<Cr>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<Cr>
nnoremap <C-w>H <C-w>H:call <SID>good_width()<Cr>
nnoremap <C-w>L <C-w>L:call <SID>good_width()<Cr>
function! s:good_width()
  if winwidth(0) < 84
    vertical resize 84
  endif
endfunction

"Ctrl-eで行末Ctrl-aで行頭
imap <C-e> <END> 
imap <C-a> <HOME>

"vimrcをリロード"
command! ReloadVimrc  source $MYVIMRC 

"クリップボードの同期
set clipboard+=autoselect
set clipboard+=unnamed

"Esc二回でハイライトを消す
nnoremap  <Esc><Esc> :nohlsearch<CR><Esc>

"マウスを使う
set mouse=a
set ttymouse=xterm2

if has('gui_running')
	set mousemodel=popup
	set nomousefocus
	set mousehide
endif
"タイプ認識を有効か"
filetype plugin indent on
"neocomplcacheを使う
let g:neocomplcache_enable_at_startup = 1

"Vimの戦闘力を計算する
function! Scouter(file, ...)
	let pat = '^\s*$\|^\s*"'
	let lines = readfile(a:file)
	if !a:0 || !a:1
		let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', '\g'), "\n")
	endif
	return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\ 	echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
"ファイル名を変更して開き直す
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
"別名のファイルを保存してそちらを開く
command! -nargs=1 -complet=file Copy f <args>|call copy(expand('#'))
"全角文字の幅を2マス分にする
set ambiwidth=double
"フォーマットオプションを設定する
set formatoptions=tcroqlM1
"削除方法の設定
set backspace=indent,eol,start
"ステータスラインを表示
set laststatus=2 " ステータスラインを表示  
set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']['.&ft.']'}\ %F%=%l,%c%V%8P  
" perl folding
" maker
set foldmethod=marker
"clojure
let g:clj_paren_rainbow = 1
let g:clj_highlight_builtins = 1
"Color Theme
colorscheme wombat
"title
set title
set titlestring=Vim:\ %f\ %h%r%m
"QuickFix keybind
nnoremap <C-J> :cn<CR>
nnoremap <C-K> :cN<CR>
"日時の入力を簡単にする
inoremap <expr> ,df strftime('%Y-%m-%d %H:%M:%S')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')
"Vimfilerを標準のファイルエクスプローラーにする
let g:vimfiler_as_default_explorer = 1
"New feature 7.3
if v:version >= 703
	set undofile
endif
"Excel like auto fill command
function! Autofill()
	let l:befor = input('Befor str? ')
	let l:after = input('After str? ')
	let l:start = input('Start num? ')
	let l:end   = input('End   num? ')
	for i in reverse(range(l:start, l:end))
		call append(line('.'), printf("%s%d%s",l:befor,i,l:after))
	endfor
endfunction
command! -nargs=0 Autofill
\	echo Autofill()
