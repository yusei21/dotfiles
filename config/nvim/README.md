# Neovim

Requires Neovim 0.12+, Git, tree-sitter CLI and a C compiler.
Run :Lazy sync on first launch, then:
```
:TSInstall lua vim vimdoc query bash python rust c cpp java javascript typescript tsx json yaml html css markdown markdown_inline
```
Restart after parsers finish. Check :checkhealth and :checkhealth vim.lsp in a project.
Install JDTLS from AUR and VTSLS with npm install -g --prefix "$HOME/.local" @vtsls/language-server.
Ensure ~/.local/bin is on PATH. Rust formatting requires rustfmt.
Use Space+ff to find files, Space+fg to search text, Space+fb for buffers,
Space+e for Oil, Space+f to format, Space+w to save, Space+q to quit.
Disable format on save for a buffer with :lua vim.b.disable_autoformat = true.
Plugin versions are recorded locally by lazy-lock.json; validate before promoting a lockfile.
ShellCheck is available as a standalone CLI; no separate lint plugin is configured.

Project tree: Ctrl+B or Space+b (Neo-tree); press Enter to open a file or expand a folder.
Run: F5 or Space+r; build: F6; save: Ctrl+S; terminal: Space+t.
Run supports Python, JavaScript, Node-compatible TypeScript, Bash, single-file Java/C/C++/Rust and Cargo projects.
Build supports Cargo, Java and standalone C/C++/Rust (writes .out beside source for native files).
For Maven, Gradle, CMake or custom project tasks, use the terminal with the project's own commands.
Press Esc twice to leave terminal input, then :q to close its window.
