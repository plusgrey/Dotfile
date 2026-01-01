" Insert 模式 -> 闪烁竖线 (5)
let &t_SI = "\<Esc>[5 q"

" Normal 模式 -> 闪烁方块 (1)
let &t_EI = "\<Esc>[1 q"

" 启动 Vim 时 -> 闪烁方块 (1)
let &t_ti .= "\<Esc>[1 q"

" 退出 Vim 时 -> 闪烁竖线 (5)
let &t_te .= "\<Esc>[5 q"
