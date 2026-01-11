# Neovim 快捷键速查表 (Cheat Sheet)

> **Leader 键**: `Space`  
> **LocalLeader 键**: `\`  
> **配置目录**: `~/.config/nvim/`

---

## 目录

- [Vim 原生快捷键](#vim-原生快捷键)
- [基础移动和编辑](#基础移动和编辑)
- [窗口和 Buffer 管理](#窗口和-buffer-管理)
- [搜索和查找 (Snacks Picker)](#搜索和查找-snacks-picker)
- [LSP 相关](#lsp-相关)
- [Git 相关](#git-相关)
- [调试 (DAP)](#调试-dap)
- [代码编辑](#代码编辑)
- [文件浏览](#文件浏览)
- [切换开关 (Toggle)](#切换开关-toggle)
- [AI 辅助 (CodeCompanion)](#ai-辅助-codecompanion)
- [语言特定](#语言特定)
- [折叠 (UFO)](#折叠-ufo)

---

## Vim 原生快捷键

> 这些是 Vim/Neovim 内置的快捷键，无需修改配置

### 模式切换

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `i` | 进入 Insert 模式 | 在光标前插入 |
| `a` | 进入 Insert 模式 | 在光标后插入 |
| `o` | 新行并进入 Insert | 在下方新建一行 |
| `O` | 新行并进入 Insert | 在上方新建一行 |
| `v` | 进入 Visual 模式 | 字符选择 |
| `V` | 进入 Visual Line 模式 | 行选择 |
| `Ctrl+v` | 进入 Visual Block 模式 | 块选择 |
| `Esc` / `jk` | 返回 Normal 模式 | `jk` 是自定义的 |
| `:` | 进入 Command 模式 | |

### 移动

| 快捷键 | 功能 |
|--------|------|
| `h/j/k/l` | 左/下/上/右 |
| `w/W` | 下一个词首 |
| `b/B` | 上一个词首 |
| `e/E` | 下一个词尾 |
| `0` | 行首 |
| `^` | 行首非空字符 |
| `$` | 行尾 |
| `gg` | 文件开头 |
| `G` | 文件结尾 |
| `{/}` | 上/下一个段落 |
| `Ctrl+u/d` | 向上/下翻半页 |
| `Ctrl+b/f` | 向上/下翻整页 |
| `%` | 跳转到匹配的括号 |
| `f{char}` | 跳转到下一个 {char} |
| `F{char}` | 跳转到上一个 {char} |
| `t{char}` | 跳转到下一个 {char} 前 |
| `T{char}` | 跳转到上一个 {char} 后 |
| `;` | 重复 f/F/t/T |
| `,` | 反向重复 f/F/t/T |

### 编辑

| 快捷键 | 功能 |
|--------|------|
| `y` | 复制 (yank) |
| `p/P` | 粘贴 (在后/前) |
| `u` | 撤销 |
| `Ctrl+r` | 重做 |
| `.` | 重复上一个操作 |
| `>>` / `<<` | 增加/减少缩进 |
| `J` | 合并行 |
| `~` | 切换大小写 |
| `r{char}` | 替换当前字符 |
| `R` | 进入 Replace 模式 |

### 搜索

| 快捷键 | 功能 |
|--------|------|
| `/{pattern}` | 向下搜索 |
| `?{pattern}` | 向上搜索 |
| `n/N` | 下一个/上一个匹配 |
| `*` | 搜索当前词 (向下) |
| `#` | 搜索当前词 (向上) |

---

## 基础移动和编辑

> **修改位置**: [lua/keymapping.lua](lua/keymapping.lua)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Ctrl+s` | n/i/v | 快速保存文件 |
| `jk` | Insert | 退出 Insert 模式 (等同 Esc) |
| `Ctrl+h/j/k/l` | Insert | 在 Insert 模式下移动光标 |
| `Ctrl+h/j/k/l` | Normal | 切换窗口 |
| `Shift+H` | n/x/o | 跳到行首 (非空字符) |
| `Shift+L` | n/x/o | 跳到行尾 |
| `Q` | n/x | 退出所有 (`:qa`) |
| `qq` | n/x | 退出当前窗口 (`:q`) |
| `Alt+z` | Normal | 切换自动换行 |
| `x` | n/x | 删除字符 (不复制到寄存器) |
| `d` | n/x | 删除 (不复制到寄存器) |
| `dd` | n/v | 删除行 (不复制到寄存器) |
| `c` | Normal | 修改 (不复制到寄存器) |

---

## 窗口和 Buffer 管理

### Buffer 切换 (barbar.nvim)

> **修改位置**: [lua/plugins/ui.lua](lua/plugins/ui.lua) - `romgrk/barbar.nvim`

#### Alt 快捷键

| 快捷键 | 功能 |
|--------|------|
| `Alt+h` | 上一个 buffer |
| `Alt+l` | 下一个 buffer |
| `Alt+<` | 将 buffer 向左移动 |
| `Alt+>` | 将 buffer 向右移动 |
| `Alt+w` | 关闭当前 buffer (Snacks) |

#### Leader+b 快捷键

| 快捷键 | 功能 |
|--------|------|
| `<Leader>b1~9` | 跳转到第 1~9 个 buffer |
| `<Leader>bn` | 下一个 buffer |
| `<Leader>bp` | 上一个 buffer |
| `<Leader>bf` | 第一个 buffer |
| `<Leader>bl` | 最后一个 buffer |
| `<Leader>b<` | 将 buffer 向左移动 |
| `<Leader>b>` | 将 buffer 向右移动 |
| `<Leader>br` | 重命名 buffer |
| `<Leader>bc` | 关闭当前 buffer |
| `<Leader>bC` | 关闭其他所有 buffer |
| `<Leader>bP` | 固定/取消固定 buffer |
| `<Leader>bo` | 按目录排序 buffer |

### 窗口操作 (Vim 原生)

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+w s` | 水平分割窗口 |
| `Ctrl+w v` | 垂直分割窗口 |
| `Ctrl+w c` | 关闭当前窗口 |
| `Ctrl+w o` | 关闭其他窗口 |
| `Ctrl+w =` | 平均分配窗口大小 |
| `Ctrl+w +/-` | 增加/减少窗口高度 |
| `Ctrl+w >/<` | 增加/减少窗口宽度 |

---

## 搜索和查找 (Snacks Picker)

> **修改位置**: [lua/plugins/snacks.lua](lua/plugins/snacks.lua)

### 文件查找

| 快捷键 | 功能 |
|--------|------|
| `<Leader><Space>` | 智能查找文件 |
| `<Leader>,` | 列出 buffers |
| `<Leader>sf` | 查找文件 |
| `<Leader>sr` | 最近打开的文件 |
| `<Leader>sp` | 项目列表 |
| `<Leader>sb` | 列出 buffers |

### 内容搜索

| 快捷键 | 功能 |
|--------|------|
| `<Leader>sg` | 全局搜索 (Grep) |
| `<Leader>s/` | 搜索历史 |
| `<Leader>s:` | 命令历史 |

### 其他

| 快捷键 | 功能 |
|--------|------|
| `<Leader>sc` | 命令列表 |
| `<Leader>sd` | 诊断信息 (全部) |
| `<Leader>sD` | 诊断信息 (当前 buffer) |
| `<Leader>sH` | 帮助文档 |
| `<Leader>sh` | 高亮组 |
| `<Leader>sI` | 图标选择 |
| `<Leader>sj` | 跳转列表 |
| `<Leader>sk` | 快捷键列表 |
| `<Leader>sl` | Location list |
| `<Leader>sm` | 标记列表 |
| `<Leader>sM` | Man pages |
| `<Leader>sn` | 通知历史 |
| `<Leader>sq` | Quickfix list |
| `<Leader>su` | Undo 历史 |
| `<Leader>s"` | 寄存器 |
| `<Leader>sa` | 拼写建议 |
| `<Leader>st` | TODO 列表 (不含 NOTE) |
| `<Leader>sT` | TODO 列表 (含 NOTE) |

### Picker 内快捷键

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Tab` | i/n | 选中并移到上一项 |
| `Shift+Tab` | i/n | 选中并移到下一项 |
| `Alt+j/k` | i/n | 列表上下移动 |
| `Ctrl+u/d` | i/n | 预览窗口滚动 |
| `Alt+u/d` | i/n | 列表滚动 |
| `Alt+Up/Down` | i/n | 历史记录 |

---

## LSP 相关

> **修改位置**: [lua/plugins/lsp.lua](lua/plugins/lsp.lua), [lua/plugins/snacks.lua](lua/plugins/snacks.lua)

### 跳转 (Snacks Picker)

| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gD` | 跳转到声明 |
| `gr` | 查看引用 |
| `gI` | 跳转到实现 |
| `gy` | 跳转到类型定义 |
| `<Leader>ss` | LSP 符号 (当前文件) |
| `<Leader>sS` | LSP 符号 (工作区) |

### 操作 (LSP)

| 快捷键 | 功能 |
|--------|------|
| `K` | 悬浮文档 / 折叠预览 |
| `<Leader>d` | 显示诊断详情 |
| `<Leader>gk` | 签名帮助 |
| `<Leader>rn` | 重命名符号 |
| `<Leader>wa` | 添加工作区文件夹 |
| `<Leader>wr` | 移除工作区文件夹 |
| `<Leader>wl` | 列出工作区文件夹 |

### Trouble

> **修改位置**: [lua/plugins/lsp.lua](lua/plugins/lsp.lua) - `folke/trouble.nvim`

| 快捷键 | 功能 |
|--------|------|
| `Alt+j` | 下一个诊断 |
| `Alt+k` | 上一个诊断 |
| `<Leader>gd` | 切换诊断面板 |
| `<Leader>gs` | 切换符号面板 |
| `<Leader>gl` | 切换 LSP 面板 |
| `<Leader>gL` | Location list |
| `<Leader>gq` | Quickfix list |

---

## Git 相关

> **修改位置**: [lua/plugins/snacks.lua](lua/plugins/snacks.lua), [lua/plugins/ui.lua](lua/plugins/ui.lua) - `gitsigns.nvim`

### 快速操作

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+g` | 打开 Lazygit |
| `<Leader>ggl` | Git log |
| `<Leader>ggd` | Git diff |
| `<Leader>ggb` | Git blame (当前行) |
| `<Leader>ggB` | 在浏览器中打开 |

### Hunk 操作 (gitsigns)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `]h` | Normal | 下一个 hunk |
| `[h` | Normal | 上一个 hunk |
| `]H` | Normal | 最后一个 hunk |
| `[H` | Normal | 第一个 hunk |
| `<Leader>ggs` | n/v | Stage hunk |
| `<Leader>ggr` | n/v | Reset hunk |
| `<Leader>ggS` | Normal | Stage 整个 buffer |
| `<Leader>ggR` | Normal | Reset 整个 buffer |
| `<Leader>ggp` | Normal | 预览 hunk |
| `<Leader>ggP` | Normal | 预览 hunk (内联) |
| `<Leader>ggq` | Normal | 将 diffs 放入 quickfix |
| `<Leader>ggQ` | Normal | 将所有 diffs 放入 quickfix |
| `ih` | o/x | 选择当前 hunk (text object) |

---

## 调试 (DAP)

> **修改位置**: [lua/plugins/dap.lua](lua/plugins/dap.lua)

### 基础操作

| 快捷键 | 功能 |
|--------|------|
| `<F5>` / `<Leader>Dc` | 开始/继续调试 |
| `<F6>` / `<Leader>Do` | 单步跳过 (Step Over) |
| `<F7>` / `<Leader>Di` | 单步进入 (Step Into) |
| `<F8>` / `<Leader>DO` | 单步跳出 (Step Out) |
| `<F9>` | 暂停 |
| `<F10>` / `<Leader>Dq` | 终止调试 |

### 断点和视图

| 快捷键 | 功能 |
|--------|------|
| `<Leader>Db` | 切换断点 |
| `<Leader>DB` | 设置断点 (条件) |
| `<Leader>Du` | 切换 dap-view 面板 |
| `<Leader>Dr` | 打开 REPL |
| `<Leader>Dl` | 运行上一次配置 |
| `<Leader>Dd` | 悬浮查看变量 |
| `<Leader>Dp` | 预览变量 |
| `<Leader>Df` | 浮动显示调用栈 |
| `<Leader>Ds` | 浮动显示作用域 |

### DAP REPL 命令 (C/C++/Rust)

```
p <expr>     打印表达式/变量
fr v         显示所有局部变量
bt           显示调用栈
```

---

## 代码编辑

### 注释 (Comment.nvim)

> **修改位置**: [lua/plugins/edit.lua](lua/plugins/edit.lua) - `numToStr/Comment.nvim`

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<Leader>/` | n/v | 切换注释 |
| `Ctrl+/` | n/v | 切换注释 |

### 跳转 (Flash.nvim)

> **修改位置**: [lua/plugins/edit.lua](lua/plugins/edit.lua) - `folke/flash.nvim`

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<Leader>f` | n/x/o | Flash 跳转 |
| `<Leader>F` | n/x/o | Treesitter 选择 |
| `<Leader>j` | n/x/o | 行跳转 (向下) |
| `<Leader>k` | n/x/o | 行跳转 (向上) |
| `Ctrl+f` | Command | 切换 Flash 搜索 |

### Surround (mini.surround)

> **修改位置**: [lua/plugins/edit.lua](lua/plugins/edit.lua) - `echasnovski/mini.surround`

| 快捷键 | 功能 |
|--------|------|
| `sa{motion}{char}` | 添加环绕符号 |
| `sd{char}` | 删除环绕符号 |
| `sr{old}{new}` | 替换环绕符号 |
| `sf{char}` | 查找下一个环绕符号 |
| `sF{char}` | 查找上一个环绕符号 |
| `sh{char}` | 高亮环绕符号 |

### 多光标 (multicursor.nvim)

> **修改位置**: [lua/plugins/edit.lua](lua/plugins/edit.lua) - `jake-stewart/multicursor.nvim`

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `mI` | Visual | 在选区每行插入光标 |
| `mA` | Visual | 在选区每行末尾添加光标 |
| `Esc` | (多光标时) | 清除所有光标 |

### Undo Tree

> **修改位置**: [lua/plugins/edit.lua](lua/plugins/edit.lua) - `mbbill/undotree`

| 快捷键 | 功能 |
|--------|------|
| `<Leader>ut` | 切换 Undo Tree |

---

## 文件浏览

> **修改位置**: [lua/plugins/ui.lua](lua/plugins/ui.lua)

| 快捷键 | 功能 | 插件 |
|--------|------|------|
| `<Leader>e` | 切换 NvimTree | nvim-tree |
| `<Leader>E` | 在当前文件打开 Yazi | yazi.nvim |
| `<Leader>cw` | 在工作目录打开 Yazi | yazi.nvim |
| `Ctrl+Up` | 恢复 Yazi 会话 | yazi.nvim |

---

## 切换开关 (Toggle)

> **修改位置**: [lua/plugins/snacks.lua](lua/plugins/snacks.lua), [lua/plugins/lsp.lua](lua/plugins/lsp.lua)

| 快捷键 | 功能 |
|--------|------|
| `<Leader>tf` | 切换自动格式化 |
| `<Leader>ta` | 切换动画 |
| `<Leader>tS` | 切换滚动动画 |
| `<Leader>tD` | 切换 Dim 模式 |
| `<Leader>ts` | 切换拼写检查 |
| `<Leader>tw` | 切换自动换行 |
| `<Leader>tL` | 切换相对行号 |
| `<Leader>tl` | 切换行号 |
| `<Leader>td` | 切换诊断 |
| `<Leader>tc` | 切换 conceallevel |
| `<Leader>tT` | 切换 Treesitter |
| `<Leader>tb` | 切换深色/浅色背景 |
| `<Leader>th` | 切换 inlay hints |
| `<Leader>tg` | 切换缩进线 |
| `<Leader>tgb` | 切换 Git blame |
| `<Leader>tgw` | 切换 Git word diff |
| `<Leader>to` | 切换 Mini.Diff overlay |
| `<Leader>tpp` | 切换 profiler |
| `<Leader>tph` | 切换 profiler 高亮 |

---

## AI 辅助 (CodeCompanion)

> **修改位置**: [lua/plugins/ai.lua](lua/plugins/ai.lua)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<Leader>cca` | n/v | CodeCompanion 操作菜单 |
| `<Leader>cci` | n/v | CodeCompanion 内联 |
| `<Leader>ccc` | n/v | 切换 CodeCompanion 聊天 |
| `<Leader>ccp` | Visual | 添加代码到聊天 |

---

## 语言特定

### Python

> **修改位置**: [lua/plugins/lang/python.lua](lua/plugins/lang/python.lua)

| 快捷键 | 功能 |
|--------|------|
| `<Leader>cv` | 选择虚拟环境 |

### Rust (rustaceanvim)

> **修改位置**: [lua/plugins/lang/rust.lua](lua/plugins/lang/rust.lua)

| 快捷键 | 功能 |
|--------|------|
| `<Leader>ca` | Rust 代码操作 |
| `<Leader>ce` | 解释错误 |
| `<Leader>cR` | 运行 (Runnables) |
| `<Leader>cD` | 调试 (Debuggables) |
| `<Leader>cT` | 测试 (Testables) |
| `<Leader>cm` | 展开宏 |
| `<Leader>cp` | 跳转到父模块 |
| `<Leader>cJ` | 合并行 |
| `K` | Hover (带操作) |

### Rust (Crates - Cargo.toml)

| 快捷键 | 功能 |
|--------|------|
| `<Leader>cu` | 升级所有 crates |
| `<Leader>cU` | 更新所有 crates |
| `<Leader>ci` | 显示 crate 信息 |
| `<Leader>cf` | 显示 features |
| `<Leader>cv` | 显示版本 |

### C/C++ (CMake)

> **修改位置**: [lua/plugins/lang/cpp.lua](lua/plugins/lang/cpp.lua)

| 快捷键 | 功能 |
|--------|------|
| `<Leader>cg` | CMake Generate |
| `<Leader>cb` | CMake Build |
| `<Leader>cr` | CMake Run |
| `<Leader>cd` | CMake Debug |
| `<Leader>ct` | 选择构建类型 |
| `<Leader>cs` | 选择配置预设 |

---

## 折叠 (UFO)

> **修改位置**: [lua/plugins/ui.lua](lua/plugins/ui.lua) - `kevinhwang91/nvim-ufo`

| 快捷键 | 功能 |
|--------|------|
| `zM` | 关闭所有折叠 |
| `zR` | 打开所有折叠 |
| `zm` | 折叠更多 |
| `zr` | 折叠更少 |
| `zS` | 设置折叠级别 (需要 count) |
| `za` | 切换当前折叠 |
| `zo` | 打开当前折叠 |
| `zc` | 关闭当前折叠 |
| `K` | 预览折叠内容 (如果在折叠行) |

---

## 搜索高亮 (hlslens)

> **修改位置**: [lua/plugins/ui.lua](lua/plugins/ui.lua) - `kevinhwang91/nvim-hlslens`

| 快捷键 | 功能 |
|--------|------|
| `n` | 下一个匹配 (居中) |
| `N` | 上一个匹配 (居中) |
| `*` | 搜索当前词 (向下) |
| `#` | 搜索当前词 (向上) |
| `//` | 清除搜索高亮 |

---

## 其他

### 终端

> **修改位置**: [lua/plugins/snacks.lua](lua/plugins/snacks.lua)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Alt+i` | n/t | 切换浮动终端 |

### 通知

| 快捷键 | 功能 |
|--------|------|
| `<Leader>n` | 显示通知历史 |
| `<Leader>un` | 关闭所有通知 |
| `<Leader>N` | Noice 历史消息 |
| `<Leader>sN` | Noice 选择历史消息 |

### Zen 模式

| 快捷键 | 功能 |
|--------|------|
| `<Leader>z` | 切换 Zen 模式 |
| `<Leader>Z` | 切换 Zoom 模式 |

### 参考跳转 (Snacks Words)

| 快捷键 | 功能 |
|--------|------|
| `]]` | 下一个引用 |
| `[[` | 上一个引用 |

### Which-key

| 快捷键 | 功能 |
|--------|------|
| `<Leader>?` | 显示当前 buffer 快捷键 |

---

## 配置文件索引

| 文件 | 内容 |
|------|------|
| [init.lua](init.lua) | 基础设置、Leader 键 |
| [lua/keymapping.lua](lua/keymapping.lua) | 基础快捷键映射 |
| [lua/plugins/snacks.lua](lua/plugins/snacks.lua) | Snacks 全家桶 (Picker, Terminal, Git, Toggle 等) |
| [lua/plugins/ui.lua](lua/plugins/ui.lua) | UI 相关 (Buffer, Tree, Git signs, UFO, Yazi 等) |
| [lua/plugins/edit.lua](lua/plugins/edit.lua) | 编辑相关 (Comment, Flash, Surround, Multicursor) |
| [lua/plugins/lsp.lua](lua/plugins/lsp.lua) | LSP 和 Trouble |
| [lua/plugins/dap.lua](lua/plugins/dap.lua) | 调试器 (DAP) |
| [lua/plugins/ai.lua](lua/plugins/ai.lua) | AI 辅助 (Copilot, CodeCompanion) |
| [lua/plugins/completion.lua](lua/plugins/completion.lua) | 代码补全 (blink.cmp) |
| [lua/plugins/lang/python.lua](lua/plugins/lang/python.lua) | Python 语言支持 |
| [lua/plugins/lang/rust.lua](lua/plugins/lang/rust.lua) | Rust 语言支持 |
| [lua/plugins/lang/cpp.lua](lua/plugins/lang/cpp.lua) | C/C++ 语言支持 |
| [lua/plugins/lang/lua.lua](lua/plugins/lang/lua.lua) | Lua 语言支持 |

---

## 提示

- 使用 `<Leader>sk` 在 Neovim 中查看所有快捷键
- 使用 `<Leader>?` 查看当前 buffer 的本地快捷键
- 使用 `:map` 命令查看所有映射
- 使用 `:verbose map <key>` 查看某个键的映射来源
