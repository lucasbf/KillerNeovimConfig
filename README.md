# Configuração Neovim do Lucas Baggio Figueira

Setup de Neovim baseado em `lazy.nvim`, focado em produtividade para Lua, Python e C/C++ com LSP, Treesitter, fuzzy finder, depuração e uma UI mais polida.

## Requisitos
- Neovim 0.9+ com suporte a Lua.
- Git disponível no PATH (para o bootstrap do `lazy.nvim`).
- Build tools para instaladores Mason/TS (`clangd`, `python`, `lldb-dap` via LLVM etc.).
- Opcional: `pyenv` ou um ambiente virtual para depuração Python.

## Instalação
1) Clone este repo em `~/.config/nvim` (ou copie os arquivos se já estiver nesse caminho).  
2) Abra o Neovim: na primeira execução o `lazy.nvim` será clonado e todos os plugins serão instalados.  
3) Rode `:Mason` para instalar/administrar LSPs e `:TSUpdate` para manter parsers do Treesitter.

## Plugins principais
- **Tema/UI**: `catppuccin`, `lualine` (tema dracula), `barbar` (abas), `colorizer`, `noice`, `alpha` (tela inicial com ASCII aleatório).
- **Navegação**: `telescope` + `ui-select`, `neo-tree` (explorer), `ascii.nvim` (arte/headers).
- **Linguagens**: `mason` + `mason-lspconfig` + `nvim-lspconfig` (clangd, lua_ls, pyright, jinja), `nvim-cmp` + `LuaSnip`, `nvim-treesitter`.
- **Formatação/diagnósticos**: `none-ls` (stylua, black, isort, mypy, clang-format, cppcheck) com `<leader>gf` para formatar.
- **Depuração**: `nvim-dap` + `dap-ui` (adapters para Python e lldb).
- **Qualidade de vida**: `Comment.nvim`, `autoclose` (pares), `alpha` dashboard, `noice` para cmdline/messages.

## Atalhos úteis
Leader é <kbd>Espaço</kbd>.
- Salvar/fechar: `<leader>w` (salva), `<leader>x` (salva+sai), `<leader>a` (salva tudo e sai), `;w`/`;x` no modo insert.
- Buffer/abas: `<leader>c` fecha buffer; `<C-n>` abre/toggle o `neo-tree`.
- LSP: `K` hover, `gd` goto definition, `<leader>ca` code action.
- Telescope: `<leader>ff` arquivos, `<leader>fg` live grep, `<leader>fb` buffers, `<leader>fh` help.
- Depuração: `<leader>dt` toggle breakpoint, `<F5>` continuar.
- Outros: `<leader>h` limpa highlights de busca; `U` refaz (redo).

## LSP, formatação e lint
- LSPs são gerenciados pelo Mason; ajuste `lua/plugins/lsp-config.lua` caso precise de mais servidores.
- Fontes de formatação/diagnóstico do `none-ls` são configuradas em `lua/plugins/none-ls.lua`. Mypy/clang-format/cppcheck precisam estar instalados localmente.

## Depuração
- Python: busca `venv/`, `.venv/` ou `VIRTUAL_ENV`; fallback em `/Users/lucasbf/.pyenv/shims/python`.
- C/C++/Rust: usa `lldb-dap` em `/usr/local/opt/llvm/bin/lldb-dap`; ajuste o caminho em `lua/plugins/debbuging.lua` se necessário.

## Estrutura
- `init.lua`: bootstrap do `lazy.nvim` e carga de opções.
- `lua/vim-options.lua`: opções e keymaps globais.
- `lua/plugins/`: declarações do `lazy.nvim` divididas por tema (LSP, UI, navegação, DAP, etc.).
- `lua/disabled/`: plugins desativados (ex.: CopilotChat).

## Dicas rápidas
- Troque de tema ou statusline em `lua/plugins/catppuccin.lua` e `lua/plugins/lualine.lua`.
- Adicione linguagens ao Treesitter em `lua/plugins/treesitter.lua`.
- Use `:Lazy` para checar o estado dos plugins, `:Mason` para servidores e `:NullLsLog` se precisar depurar formatação.
