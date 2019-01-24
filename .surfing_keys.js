// General options
settings.smoothScroll = false;
settings.hintAlign = "left";

// Nagivate in tabs
map(']t', 'R');
map('[t', 'E');
map('<Ctrl-j>', 'E');
map('<Ctrl-k>', 'R');

// Navigate in pop-down menus
cmap('<Alt-j>', '<Tab>');
cmap('<Alt-k>', '<Shift-Tab>');

// Search sources on GitHub
// Generic
addSearchAlias('ss', 'GitHub', 'https://github.com/search?q=');
mapkey('oss', 'GitHub', function() {
    searchSelectedWith("https://github.com/search?q=");
});
vmapkey('oss', 'GitHub', function() {
    searchSelectedWith("https://github.com/search?q=");
});
// Elisp
addSearchAlias('se', 'GitHub: elisp', 'https://github.com/search?q=language%3A%22Emacs+Lisp%22+');
mapkey('ose', 'GitHub: elisp', function() {
    searchSelectedWith("https://github.com/search?q=language%3A%22Emacs+Lisp%22+");
});
vmapkey('ose', 'GitHub: elisp', function() {
    searchSelectedWith("https://github.com/search?q=language%3A%22Emacs+Lisp%22+");
});
// C
addSearchAlias('sc', 'GitHub: C', 'https://github.com/search?q=language%3AC+');
mapkey('osc', 'GitHub: C', function() {
    searchSelectedWith("https://github.com/search?q=language%3AC+");
});
vmapkey('osc', 'GitHub: C', function() {
    searchSelectedWith("https://github.com/search?q=language%3AC+");
});
// C++
addSearchAlias('sC', 'GitHub: C++', 'https://github.com/search?q=language%3AC%2B%2B+');
mapkey('osC', 'GitHub: C++', function() {
    searchSelectedWith("https://github.com/search?q=language%3AC%2B%2B+");
});
vmapkey('osC', 'GitHub: C++', function() {
    searchSelectedWith("https://github.com/search?q=language%3AC%2B%2B+");
});
// Python
addSearchAlias('sp', 'GitHub: Python', 'https://github.com/search?q=language%3APython+');
mapkey('osp', 'GitHub: Python', function() {
    searchSelectedWith("https://github.com/search?q=language%3APython+");
});
vmapkey('osp', 'GitHub: Python', function() {
    searchSelectedWith("https://github.com/search?q=language%3APython+");
});
// Rust
addSearchAlias('sr', 'GitHub: Rust', 'https://github.com/search?q=language%3ARust+');
mapkey('osr', 'GitHub: Rust', function() {
    searchSelectedWith("https://github.com/search?q=language%3ARust+");
});
vmapkey('osr', 'GitHub: Rust', function() {
    searchSelectedWith("https://github.com/search?q=language%3ARust+");
});

// Set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult>ul>li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult>ul>li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 16pt;
}`;
