cd /tmp

# Markdown highlighting
curl -fL https://codeload.github.com/preservim/vim-markdown/tar.gz/refs/heads/master -o vim-markdown.tar.gz
mkdir -p ~/.vim/pack/plugins/start/vim-markdown
tar -xzf vim-markdown.tar.gz -C ~/.vim/pack/plugins/start/vim-markdown --strip-components=1

# Markdown table formatting dependency
curl -fL https://codeload.github.com/godlygeek/tabular/tar.gz/refs/heads/master -o tabular.tar.gz
mkdir -p ~/.vim/pack/plugins/start/tabular
tar -xzf tabular.tar.gz -C ~/.vim/pack/plugins/start/tabular --strip-components=1

# Git gutter indicators
curl -fL https://codeload.github.com/airblade/vim-gitgutter/tar.gz/refs/heads/main -o vim-gitgutter.tar.gz
mkdir -p ~/.vim/pack/plugins/start/vim-gitgutter
tar -xzf vim-gitgutter.tar.gz -C ~/.vim/pack/plugins/start/vim-gitgutter --strip-components=1
