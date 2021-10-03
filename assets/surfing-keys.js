settings.smoothScroll = false;
settings.hintAlign = "left";

var unmaps = [ "sb" ,  "sw", "ob"
         , "ow" ,  "cp", ";cp"
         , "od", "og"
         , "]]", "[["
         , "yp", "ym", "yo"
         , ";ap", "spa", "spb"
         , "spd", "sps", "spc"
         , "spi", "sfr", "zQ"
         , "zz" ,  "zR", "ab"
         , "Q"  ,   "q", "ag"
         , "af", "xx"
         ];
unmaps.forEach(function(u) {
  unmap(u);
});

// Helper functions used in mappings.
// Mostly stolen from: // https://github.com/b0o/surfingkeys-conf/
getCurrentLocation = (prop = "href") => {
  if (typeof window === "undefined") {
    return ""
  }
  return window.location[prop]
}
getURLPath = ({ count = 0, domain = false } = {}) => {
  let path = getCurrentLocation("pathname").slice(1)
  if (count) {
    path = path.split("/").slice(0, count).join("/")
  }
  if (domain) {
    path = `${getCurrentLocation("hostname")}/${path}`
  }
  return path
}
copyURLPath = ({ count, domain } = {}) => () =>
  Clipboard.write(getURLPath({ count, domain }))
copyOrgLink = () =>
  Clipboard.write(`[[${getCurrentLocation("href")}][${document.title}]]`)
copyMarkdownLink = () =>
  Clipboard.write(`[${document.title}](${getCurrentLocation("href")})`)

mapkey("yp", "Copy URL path of current page", copyURLPath());
mapkey("ym", "Copy page URL/Title as Markdown link", copyMarkdownLink);
mapkey("yo", "Copy page URL/Title as Org-mode link", copyOrgLink);

// Switch tabs
map('`[', 'E');
map('ёх', 'E');
map('`]', 'R');
map('ёъ', 'R');

// Open new tab
map('t', 'on');
map('`t', 'on');

// Open link in new tab
map('F', 'gf');

// Switch to recent tab
map('`r', '<Ctrl-6>');
map('ёк', '<Ctrl-6>');

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

// Search books
addSearchAliasX('bc', 'b-ok.cc', 'https://b-ok.cc/s/?q=', 'o');

// Search on pubmed
addSearchAliasX('pm', 'pubmed', 'https://www.ncbi.nlm.nih.gov/pmc/?term=', 'o');

// Search in Debian packages sources
addSearchAliasX('pd', 'Debian packages content', 'https://packages.debian.org/search?searchon=contents&keywords=', 'o');
addSearchAliasX('pc', 'Debian codesearch', 'https://codesearch.debian.net/search?q=', 'o');

// Search sources at bootlin
addSearchAliasX('ll', 'bootlin: linux', 'https://elixir.bootlin.com/linux/latest/ident/', 'o');
addSearchAliasX('lg', 'bootlin: linux', 'https://elixir.bootlin.com/glibc/latest/ident/', 'o');

// Search sources on GitHub
addSearchAliasX('gg', 'github', 'https://github.com/search?q=', 'o');
addSearchAliasX('gv', 'github: vimscript', 'https://github.com/search?q=language%3A%22vimscript%22+', 'o');
addSearchAliasX('gc', 'github: C', 'https://github.com/search?q=language%3AC+', 'o');
addSearchAliasX('gx', 'github: C++', 'https://github.com/search?q=language%3AC%2B%2B+', 'o');
addSearchAliasX('gp', 'github: Python', 'https://github.com/search?q=language%3APython+', 'o');
addSearchAliasX('go', 'github: OCaml', 'https://github.com/search?q=language%3AOCaml+', 'o');

// Documentation and language references
addSearchAliasX('dx', 'doc: cppreference', 'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search=', 'o');
addSearchAliasX('dX', 'doc: isocpp', 'https://isocpp.org/search/google?q=', 'o');
addSearchAliasX('dp', 'doc: docs.python', 'https://docs.python.org/3/search.html?q=', 'o');

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
