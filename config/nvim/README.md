# Neovim

Requires Neovim 0.12+, Git, tree-sitter CLI and a C compiler.
Run :Lazy sync on first launch, then:
```
:TSInstall lua vim vimdoc query bash python rust c cpp java javascript typescript tsx json yaml html css markdown markdown_inline
```
Restart after parsers finish. Check :checkhealth and :LspInfo in a project.
Install JDTLS from AUR and VTSLS with npm install -g --prefix "$HOME/.local" @vtsls/language-server.
Ensure ~/.local/bin is on PATH. Rust formatting requires rustfmt.
Use Space+ff to find files, Space+fg to search text, Space+fb for buffers,
Space+e for Oil, Space+f to format, Space+w to save, Space+q to quit.
Disable format on save for a buffer with :lua vim.b.disable_autoformat = true.
Plugin versions are recorded locally by lazy-lock.json; validate before promoting a lockfile.
ShellCheck is available as a standalone CLI; no separate lint plugin is configured.
