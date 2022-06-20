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
  api.unmap(u);
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

api.mapkey("yp", "Copy URL path of current page", copyURLPath());
api.mapkey("ym", "Copy page URL/Title as Markdown link", copyMarkdownLink);
api.mapkey("yo", "Copy page URL/Title as Org-mode link", copyOrgLink);

// Switch tabs
api.map('`[', 'E');
api.map('ёх', 'E');
api.map('`]', 'R');
api.map('ёъ', 'R');

// Open new tab
api.map('t', 'on');
api.map('`t', 'on');

// Open link in new tab
api.map('F', 'gf');

// Switch to recent tab
api.map('`r', '<Ctrl-6>');
api.map('ёк', '<Ctrl-6>');

// Pin tab
api.map('gp', '<Alt-p>')

// Navigate in pop-up menus
api.cmap('<Alt-j>', '<Tab>');
api.cmap('<Alt-k>', '<Shift-Tab>');

api.addSearchAlias('te', 'yandex.translate (ru → en)', 'https://translate.yandex.ru/?lang=en-ru&text=', 'o');
api.addSearchAlias('tr', 'yandex.translate (en → ru)', 'https://translate.yandex.ru/?lang=en-ru&text=', 'o');
api.addSearchAlias('to', 'Oxford dictionaries', 'https://en.oxforddictionaries.com/definition/', 'o');
api.addSearchAlias('bc', 'b-ok.cc', 'https://b-ok.cc/s/?q=', 'o');
api.addSearchAlias('pm', 'pubmed', 'https://www.ncbi.nlm.nih.gov/pmc/?term=', 'o');
api.addSearchAlias('pd', 'Debian packages content', 'https://packages.debian.org/search?searchon=contents&keywords=', 'o');
api.addSearchAlias('pc', 'Debian codesearch', 'https://codesearch.debian.net/search?q=', 'o');
api.addSearchAlias('ll', 'bootlin: linux', 'https://elixir.bootlin.com/linux/latest/ident/', 'o');
api.addSearchAlias('lg', 'bootlin: linux', 'https://elixir.bootlin.com/glibc/latest/ident/', 'o');
api.addSearchAlias('gg', 'github', 'https://github.com/search?q=', 'o');
api.addSearchAlias('gv', 'github: vimscript', 'https://github.com/search?q=language%3A%22vimscript%22+', 'o');
api.addSearchAlias('gc', 'github: C', 'https://github.com/search?q=language%3AC+', 'o');
api.addSearchAlias('gx', 'github: C++', 'https://github.com/search?q=language%3AC%2B%2B+', 'o');
api.addSearchAlias('gp', 'github: Python', 'https://github.com/search?q=language%3APython+', 'o');
api.addSearchAlias('go', 'github: OCaml', 'https://github.com/search?q=language%3AOCaml+', 'o');
api.addSearchAlias('dx', 'doc: cppreference', 'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search=', 'o');
api.addSearchAlias('dX', 'doc: isocpp', 'https://isocpp.org/search/google?q=', 'o');
api.addSearchAlias('dp', 'doc: docs.python', 'https://docs.python.org/3/search.html?q=', 'o');

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
