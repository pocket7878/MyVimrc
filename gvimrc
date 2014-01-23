""GUIで動作しているときのための設定"{{{
if has('gui_running')
	set guioptions+=m
	set mousemodel=popup
	set mouse=a
	set nomousefocus
	set mousehide
	"set imdisable
        set background=dark
        "colorscheme molokai
        colorscheme iceberg
        let g:molokai_original = 1
        set guifont=Ricty\ Regular:h16
        set transparency=10
        set lines=24
        set columns=80
endif
"}}}
