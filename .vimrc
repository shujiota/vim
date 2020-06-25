"2020/2/17 更新
set encoding=utf-8
scriptencoding utf-8
syntax on

"------------------------------------------------------------
"buffer削除
"------------------------------------------------------------
function! s:delete_hide_buffer()
	let list = filter(range(1, bufnr("$")), "bufexists(v:val) && !buflisted(v:val)")
    for num in list
        execute "bw ".num
    endfor
endfunction

command! DeleteHideBuffer :call s:delete_hide_buffer()
"------------------------------------------------------------
"検索関係
"------------------------------------------------------------
set hlsearch " 検索結果をハイライト
set ignorecase " 検索パターンに大文字小文字を区別しない
set incsearch " インクリメンタルサーチ. 1文字入力毎に検索を行う
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
"------------------------------------------------------------
"表示系
"------------------------------------------------------------
"set number " ---行番号を表示
set autoindent "改行時に前の行のインデントを継続する
set background=dark " 背景色
set expandtab  "入力モードでTabキー押下時やインデントの際、タブ文字ではなく、半角スペースが挿入されるようになります。"
set fileencodings=utf-8,sjis
set fileformats=unix,dos,mac
"
""set foldmethod=indent "インデント自動で折りたたみ生成
set history=5000 " 保存するコマンド履歴の数
set showcmd " 打ったコマンドをステータスラインの下に表示
set showmatch " 括弧の対応関係を一瞬表示する
set showmode " 現在のモードを表示
set syntax=markdown " ---Markdownのハイライト有効---
au BufRead,BufNewFile *.md set filetype=markdown
set t_Co=256
set tabstop=2 " タブページ幅
set ruler " ステータスラインの右側にカーソルの現在位置を表示する
"------------------------------------------------------------
"netrw設定
"------------------------------------------------------------
"ファイルツリーの表示形式、1にするとls -laのような表示になります
let g:netrw_liststyle=1
" ヘッダを非表示にする
"let g:netrw_banner=0
" サイズを(K,M,G)で表示する
let g:netrw_sizestyle="H"
" 日付フォーマットを yyyy/mm/dd(曜日) hh:mm:ss で表示する
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
" プレビューウィンドウを垂直分割で表示する
let g:netrw_preview=1
"------------------------------------------------------------
"#インデントに色をつける。vim-indent-guidesの設定'"
"------------------------------------------------------------
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1
"インデントカラーの設定
let g:indent_guides_guide_size = 2
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=darkmagenta
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkcyan
"------------------------------------------------------------
"エラー表示の設定
"-----------------------------------------------------------
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '=='
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" ファイルオープン時にチェックしたくない場合
let g:ale_lint_on_enter = 0

"------------------------------------------------------------
"色付け
"------------------------------------------------------------
"------------------------------------------------------------
"slim
"------------------------------------------------------------
autocmd BufRead,BufNewFile *.slim setfiletype slim

"------------------------------------------------------------
"補完ウインドウの色指定
"------------------------------------------------------------
highlight Pmenu ctermbg=8 guibg=#606060
highlight PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6

"------------------------------------------------------------
"補助系
"------------------------------------------------------------
"--- コマンドモードの補完
set wildmenu

"先頭が#だと改行時にまた#が入るのを禁止 auto comment off
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

"------------------------------------------------------------
"未分類
"------------------------------------------------------------
set belloff=all
set laststatus=2
set modifiable
set nobackup   "(チルダ)ファイル
set noswapfile "swp ファイル
set notimeout " ---タイムアウトさせない---
set noundofile "ファイル
set shiftround
set shiftwidth=2 "自動インデントでずれる幅
"set showbreak=+++≫  "折り返し行の先頭に表示させる。

"set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
"set smarttab  "改行時に前の行の行末を見て自動でインデントが挿入される"
set softtabstop=0
set spell "スペルチェック
set termguicolors
set whichwrap=b,s,h,l,<,>,[,],~
set wrapscan
set write
""source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する
""" ------------------------------------------------------------
""" 縦方向のf移動
""" ------------------------------------------------------------
""command -nargs=1 MyLineSearch let @m=<q-args> | call search('^\s*'. @m)
""command -nargs=1 MyLineBackSearch let @m=<q-args> | call search('^\s*'. @m, 'b')
""nnoremap <Space>f :MyLineSearch<Space>
""nnoremap <Space>F :MyLineBackSearch<Space>
""
""
"------------------------------------------------------------
"spell設定
"------------------------------------------------------------
set spelllang=en,cjk

fun! s:SpellConf()
  redir! => syntax
  silent syntax
  redir END

  set spell

  if syntax =~? '/<comment\>'
    syntax spell default
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent containedin=Comment contained
  else
    syntax spell toplevel
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent
  endif

  syntax cluster Spell add=SpellNotAscii,SpellMaybeCode
endfunc

augroup spell_check
  autocmd!
  autocmd BufReadPost,BufNewFile,Syntax * call s:SpellConf()
augroup END
"------------------------------------------------------------
"その他
"------------------------------------------------------------
autocmd InsertLeave * set nopaste "挿入貼り付けを終了させる。
"起動時にe.設定
autocmd VimEnter * nested if @% == '' && s:GetBufByte() == 0 | edit . | endif
function! s:GetBufByte()
  let byte = line2byte(line('$') + 1)
  if byte == -1
    return 0
  else
    return byte - 1
  endif
endfunction

autocmd FileType ruby setlocal dictionary=~/usr/share/dict/words.dict
"excitetranslate-vimをp閉じするためのコマンド
"autocmd BufEnter ==Translate==\ Excite nnoremap <buffer> <silent> q :<C-u>close<CR>
"autocmd BufWritePre * :normal gg=G "保存時にインデント調整
"ファイル読み込み
source /home/vagrant/keymap.rc.vim
""
"""------------------------------------------------------------
"""入力
"""------------------------------------------------------------
""set runtimepath+=~/.config/nvim/rplugin
"------------------------------------------------------------
"tags設定
"------------------------------------------------------------
let g:vim_tags_project_tags_command = "/usr/local/bin/ctags -f .tags -R . 2>/dev/null"
let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags -R -f .Gemfile.lock.tags `bundle show --paths` 2>/dev/null"
set tags+=.tags
set tags+=.Gemfile.lock.tags

function! s:execute_ctags() abort
  " 探すタグファイル名
  let tag_name = '.tags'
  " ディレクトリを遡り、タグファイルを探し、パス取得
  let tags_path = findfile(tag_name, '.;')
  " タグファイルパスが見つからなかった場合
  if tags_path ==# ''
    return
  endif

  " タグファイルのディレクトリパスを取得
  " `:p:h`の部分は、:h filename-modifiersで確認
  let tags_dirpath = fnamemodify(tags_path, ':p:h')
  " 見つかったタグファイルのディレクトリに移動して、ctagsをバックグラウンド実行（エラー出力破棄）
  execute 'silent !cd' tags_dirpath '&& ctags -R -f' tag_name '2> /dev/null &'
endfunction

augroup ctags
  autocmd!
  autocmd BufWritePost * call s:execute_ctags()
augroup END
"------------------------------------------------------------
"ctrlpの設定
"------------------------------------------------------------
let g:ctrlp_user_command = 'ag %s -l'
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100' " マッチウインドウの設定. 「下部に表示, 大きさ20行で固定, 検索結果100件」
let g:ctrlp_show_hidden = 1 " .(ドット)から始まるファイルも検索対象にする
let g:ctrlp_types = ['fil'] "ファイル検索のみ使用
let g:ctrlp_extensions = ['funky', 'commandline'] " CtrlPの拡張として「funky」と「commandline」を使用
" CtrlPCommandLineの有効化
command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())

if executable('ag') " agが使える環境の場合
  let g:ctrlp_use_caching=0 " CtrlPのキャッシュを使わない
  let g:ctrlp_user_command='ag %s -i --hidden -g ""' " 「ag」の検索設定
  let g:ag_working_path_mode="r"
endif
"ctrlp funkyの設定
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1
nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow


"""------------------------------------------------------------
"""coffeeスクリプト
"""------------------------------------------------------------
""" インデント設定
""autocmd FileType coffee    setlocal sw=2 sts=2 ts=2 et
""" オートコンパイル
""  "保存と同時にコンパイルする
""autocmd BufWritePost *.coffee silent make!
""  "エラーがあったら別ウィンドウで表示
""autocmd QuickFixCmdPost * nested cwindow | redraw!
""" vimにcoffeeファイルタイプを認識させる
""au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
"""------------------------------------------------------------
""" jsonファイルタ
"""------------------------------------------------------------
autocmd BufRead,BufNewFile *.jbuilder set ft=ruby

"------------------------------------------------------------
"綺麗にペースト
"------------------------------------------------------------
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"
  function! XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
"---------------------
""let g:python_host_prog = '/home/vagrant/.pyenv/versions/neovim2/bin/python'
""let g:python3_host_prog = '/home/vagrant/.pyenv/versions/neovim3/bin/python'
"--------------------
" ------------------------------------------------------------
" タブページ幅の設定
" ------------------------------------------------------------
""augroup AutoColor
""	autocmd!
""	autocmd Colorscheme * highlight! link TabLine Comment
""augroup END

"------------------------------------------------------------
"emnet
"------------------------------------------------------------
"emmetショートカットキー
let g:user_emmet_leader_key='<c-l>'
"------------------------------------------------------------
"neosnippetの設定
"------------------------------------------------------------
" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
"imap <expr><TAB>
"\ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"set snippet file dir
let g:neosnippet#snippets_directory='~/neosnippet'

"------------------------------------------------------------
"neocomplete
"------------------------------------------------------------
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><UP>   pumvisible() ? "\<C-p>" : "\<UP>"
inoremap <expr><DOWN> pumvisible() ? "\<C-n>" : "\<DOWN>"
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


"------------------------------------------------------------
""dein Scripts
"------------------------------------------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

  " Required:
  set runtimepath+=/home/vagrant/.cache/dein/repos/github.com/Shougo/dein.vim

  " Required:
  if dein#load_state('/home/vagrant/.cache/dein')
  call dein#begin('/home/vagrant/.cache/dein')
  " Let dein manage dein
  " Required:
  call dein#add('/home/vagrant/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('tomasr/molokai')
  call dein#add ('cespare/vim-toml')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplete.vim')
  "call dein#add('Shougo/deoplete.nvim')

  "" Set a single option
  "call deoplete#custom#option('auto_complete_delay', 200)
  "" Pass a dictionary to set multiple options
  "call deoplete#custom#option({
  "\ 'auto_complete_delay': 200,
  "\ 'smart_case': v:true,
  "\ })
  "call deoplete#custom#option('smart_case', v:true)
  "if !has('nvim')
  "  call dein#add('roxma/nvim-yarp')
  "  call dein#add('roxma/vim-hug-neovim-rpc')

  "endif

  let g:rc_dir = expand('~/') "<- dein.toml dein_lazy.toml を読み込むディレクトリ ##########
  let s:toml = g:rc_dir . 'dein.toml'
  "let s:lazy_toml = g:rc_dir . '/dein_lazy.toml' "<- dein_lazy.toml を使う場合はコメント解除 ##########

  "tomlファイルを読み込む
  call dein#load_toml(s:toml, {'lazy': 0})
  "call dein#load_toml(s:lazy_toml, {'lazy': 1}) "<- dein_lazy.toml を使う場合はコメント解除 ##########

  " Required:
  call dein#end()
  call dein#save_state()
  endif

  " Required:
  filetype plugin indent on
  syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
