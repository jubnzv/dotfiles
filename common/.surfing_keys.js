// General options
settings.smoothScroll = false;
settings.hintAlign = "left";

// Unmap undesired defaults
var unmaps = [ "sb" ,  "sw", "ob"
         , "ow" ,  "cp", ";cp"
         , "od", "og"
         , "]]", "[["
         , ";ap", "spa", "spb"
         , "spd", "sps", "spc"
         , "spi", "sfr", "zQ"
         , "zz" ,  "zR", "ab"
         , "Q"  ,   "q", "ag"
         , "af"
         ];
unmaps.forEach(function(u) {
  unmap(u);
});

// Switch tabs
map('`[', 'E');
map('`]', 'R');
map('`1', '<Alt-1>');

// Open new tab
map('t', 'on');

// Open link in new tab
map('F', 'gf');

mapkey('p', "Open the clipboard's URL in the current tab", function() {
    Front.getContentFromClipboard(function(response) {
        window.location.href = response.data;
    });
});

mapkey(';w', "Lookup whois information for domain", whois, {
    repeatIgnore: true
});

// Pin tab
map('gp', '<Alt-p>')

// Navigate in pop-up menus
cmap('<Alt-j>', '<Tab>');
cmap('<Alt-k>', '<Shift-Tab>');

// Yandex.Translate
addSearchAliasX('te', 'yandex.translate (ru → en)', 'https://translate.yandex.ru/?lang=en-ru&text=', 'o');
addSearchAliasX('tr', 'yandex.translate (en → ru)', 'https://translate.yandex.ru/?lang=en-ru&text=', 'o');

// Oxford dictionaries
addSearchAliasX('to', 'Oxford dictionaries', 'https://en.oxforddictionaries.com/definition/', 'o');

// Search in Debian packages sources
addSearchAliasX('pd', 'Debian packages content', 'https://packages.debian.org/search?searchon=contents&keywords=', 'o');
addSearchAliasX('pc', 'Debian codesearch', 'https://codesearch.debian.net/search?q=', 'o');

// Search sources on GitHub
addSearchAliasX('gg', 'github', 'https://github.com/search?q=', 'o');
addSearchAliasX('gv', 'github: vimscript', 'https://github.com/search?q=language%3A%22vimscript%22+', 'o');
addSearchAliasX('ge', 'github: emacs lisp', 'https://github.com/search?q=language%3A%22Emacs+Lisp%22+', 'o');
addSearchAliasX('gR', 'github: racket', 'https://github.com/search?q=language%3A%22Racket%22+', 'o');
addSearchAliasX('gc', 'github: C', 'https://github.com/search?q=language%3AC+', 'o');
addSearchAliasX('gx', 'github: C++', 'https://github.com/search?q=language%3AC%2B%2B+', 'o');
addSearchAliasX('gp', 'github: Python', 'https://github.com/search?q=language%3APython+', 'o');

// Documentation and language references
addSearchAliasX('dx', 'doc: cppreference', 'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search=', 'o');
addSearchAliasX('dX', 'doc: isocpp', 'https://isocpp.org/search/google?q=', 'o');
addSearchAliasX('dg', 'doc: gnome', 'https://developer.gnome.org/search?q=', 'o');
addSearchAliasX('dp', 'doc: docs.python', 'https://docs.python.org/3/search.html?q=', 'o');
addSearchAliasX('dl', 'LWN', 'https://lwn.net/Search/DoSearch?words=', 'o');

function whois() {
    var url = "https://who.is/whois/" + window.location.hostname;
    window.open(url, '_blank').focus();
}

// Set theme
settings.theme = `
/* Disable RichHints CSS animation */
.expandRichHints {
    animation: 0s ease-in-out 1 forwards expandRichHints;
}
.collapseRichHints {
    animation: 0s ease-in-out 1 forwards collapseRichHints;
}

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
