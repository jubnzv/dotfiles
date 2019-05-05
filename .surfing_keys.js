// General options
settings.smoothScroll = false;
settings.hintAlign = "left";

// Nagivate in tabs
map(']t', 'R');
map('[t', 'E');
map('<Ctrl-j>', 'E');
map('<Ctrl-k>', 'R');

// Pin tab
map('gp', '<Alt-p>')

// Navigate in pop-down menus
cmap('<Alt-j>', '<Tab>');
cmap('<Alt-k>', '<Shift-Tab>');

// Unmap some default mappings
unmap('od');

// google.translate
//mapkey('ote', 'Translate clipboard text with google (auto => en)', function() {
//    searchSelectedWith('https://translate.google.com/?hl=en#auto/en/', false, false, '');
//});
mapkey('otg', 'Translate clipboard text with google (en => ru)', function() {
    searchSelectedWith('https://translate.google.com/#view=home&op=translate&sl=en&tl=ru&text=', false, false, '');
});

// yandex.translate
//mapkey('ote', 'Translate clipboard text with yandex (ru => en)', function() {
//    searchSelectedWith('https://translate.yandex.ru/?lang=ru-en&text=', false, false, '');
//});
mapkey('otr', 'Translate clipboard text with yandex (en => ru)', function() {
    searchSelectedWith('https://translate.yandex.ru/?lang=en-ru&text=', false, false, '');
});

// Oxford dictionary
//mapkey('oo', 'Search word in Oxford dictionary', function() {
//    searchSelectedWith('https://en.oxforddictionaries.com/definition/', false, false, '');
//});

// Search sources on Debian Code Search
addSearchAlias('oDc', 'DebianCodeSearch', 'https://codesearch.debian.net/search?q=');
mapkey('oDc', 'DebianCodeSearch', function() {
    searchSelectedWith("https://codesearch.debian.net/search?q=");
});

// Search by packages content for Debian
addSearchAlias('oDp', 'Debian packages content', 'https://packages.debian.org/search?searchon=contents&keywords=');
mapkey('oDp', 'Debian packages content', function() {
    searchSelectedWith("https://packages.debian.org/search?searchon=contents&keywords=");
});

// Search sources on GitHub
// Generic
addSearchAlias('ogg', 'GitHub', 'https://github.com/search?q=');
mapkey('ogg', 'GitHub', function() {
    searchSelectedWith("https://github.com/search?q=");
});
vmapkey('ogg', 'GitHub', function() {
    searchSelectedWith("https://github.com/search?q=");
});
// vimscript
mapkey('ogv', 'GitHub: elisp', function() {
    searchSelectedWith("https://github.com/search?q=language%3A%22vimscript%22+");
});
vmapkey('ogv', 'GitHub: elisp', function() {
    searchSelectedWith("https://github.com/search?q=language%3A%22vimscript%22+");
});
// Emacs Lisp
mapkey('oge', 'GitHub: elisp', function() {
    searchSelectedWith("https://github.com/search?q=language%3A%22Emacs+Lisp%22+");
});
vmapkey('oge', 'GitHub: elisp', function() {
    searchSelectedWith("https://github.com/search?q=language%3A%22Emacs+Lisp%22+");
});
// Racket
addSearchAlias('ogR', 'GitHub: racket', 'https://github.com/search?q=language%3A%22Racket%22+');
mapkey('ogR', 'GitHub: racket', function() {
    searchSelectedWith("https://github.com/search?q=language%3A%22Racket%22+");
});
vmapkey('ogR', 'GitHub: racket', function() {
    searchSelectedWith("https://github.com/search?q=language%3A%22Racket%22+");
});
// C
mapkey('ogc', 'GitHub: C', function() {
    searchSelectedWith("https://github.com/search?q=language%3AC+");
});
vmapkey('ogc', 'GitHub: C', function() {
    searchSelectedWith("https://github.com/search?q=language%3AC+");
});
// C++
mapkey('ogC', 'GitHub: C++', function() {
    searchSelectedWith("https://github.com/search?q=language%3AC%2B%2B+");
});
vmapkey('ogC', 'GitHub: C++', function() {
    searchSelectedWith("https://github.com/search?q=language%3AC%2B%2B+");
});
// Python
mapkey('ogp', 'GitHub: Python', function() {
    searchSelectedWith("https://github.com/search?q=language%3APython+");
});
vmapkey('ogp', 'GitHub: Python', function() {
    searchSelectedWith("https://github.com/search?q=language%3APython+");
});
// Rust
mapkey('ogr', 'GitHub: Rust', function() {
    searchSelectedWith("https://github.com/search?q=language%3ARust+");
});
vmapkey('ogr', 'GitHub: Rust', function() {
    searchSelectedWith("https://github.com/search?q=language%3ARust+");
});

// GNOME documentation
mapkey('odg', 'GNOME documentation', function() {
    searchSelectedWith("https://developer.gnome.org/search?q=");
});
vmapkey('odg', 'GNOME documentation', function() {
    searchSelectedWith("https://developer.gnome.org/search?q=");
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
