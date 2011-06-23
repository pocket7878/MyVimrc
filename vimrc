"構文ハイライト
syntax enable
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
"入力補完の設定
setlocal omnifunc=syntaxcomplete#Complete
"新規lispファイルを作成したときの設定
let lisp_rainbow = 1
autocmd FileType lisp set nocindent | set lisp | let lisp_rainbow = 1 
autocmd FileType scheme set nocindent | set lisp | let lisp_rainbow = 1
set encoding=utf-8
"改行コードを自動認識
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

nnoremap <C-w>h <C-w>h:call <SID>good_width()<CR>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<CR>
nnoremap <C-w>H <C-w>H:call <SID>good_width()<CR>
nnoremap <C-w>L <C-w>L:call <SID>good_width()<CR>
function! s:good_width()
  if winwidth(0) < 120
    vertical resize 120
  endif
endfunction

"Ctrl-eで行末Ctrl-aで行頭
imap <C-e> <END> 
imap <C-a> <HOME>
"NeoComplCacheを使う

"vimrcをリロード"
command! ReloadVimrc  source $MYVIMRC 

" lhs comments
vmap ,# :s/^/#/<CR>:nohlsearch<CR>
vmap ,/ :s/^/¥/¥//<CR>:nohlsearch<CR>
vmap ,> :s/^/> /<CR>:nohlsearch<CR>
vmap ," :s/^/¥"/<CR>:nohlsearch<CR>
vmap ,% :s/^/%/<CR>:nohlsearch<CR>
vmap ,! :s/^/!/<CR>:nohlsearch<CR>
vmap ,; :s/^/;/<CR>:nohlsearch<CR>
vmap ,- :s/^/--/<CR>:nohlsearch<CR>
vmap ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>
" wrapping comments
vmap ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>:nohlsearch<CR>
vmap ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>:nohlsearch<CR>
vmap ,< :s/^\(.*\)$//<CR>:nohlsearch<CR>
vmap ,d :s/^\([/(]\*\\|\)$/\2/<CR>:nohlsearch <CR>
" block comments
vmap ,b v`k0i/*`>j0i*/<CR>
vmap ,h v`k0i<CR>

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

set clipboard=autoselect


let mapleader = ','
let maplocalleader = '.'

nnoremap \ .
"vimfiler
let g:vimfiler_as_default_explorer = 1
"AutoFill Function
function! Autofill()
	let l:befor = input('Befor Str? ')
	let l:after = input('After Str? ')
	let l:start = input('Start Num? ')
	let l:end   = input('End   Num? ')
	for i in reverse(range(l:start, l:end))
		call append(line('.'), printf("%s%d%s", l:befor, i, l:after))
	endfor
endfunction
command! -nargs=0 Autofill
\	echo Autofill()
"Quick fix Keymapping
nnoremap Q q

nnoremap qj  :cnext<CR>
nnoremap qk  :cprevious<CR>
nnoremap qr  :crewind<CR>
nnoremap qK  :cfirst<CR>
nnoremap qJ  :clast<CR>
nnoremap qf  :cnfile<CR>
nnoremap qF  :cpfile<CR>
nnoremap ql  :clist<CR>
nnoremap qq  :cc<CR>
nnoremap qo  :copen<CR>
nnoremap qc  :cclose<CR>
nnoremap qw  :cwindow<CR>
nnoremap qp  :colder<CR>
nnoremap qn  :cnewer<CR>
nnoremap qm  :make<CR>
nnoremap qM  :make<Space>
nnoremap qg  :grep<Space>
nnoremap q   <Nop>

"Pathogen & pathocket
call pathogen#runtime_append_all_bundles()
