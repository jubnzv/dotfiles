set disassembly-flavor intel
set print asm-demangle on

set history save
set verbose off
set print pretty on
set print array off
set print array-indexes on
set python print-stack full

# {{{ std::string
define pstr
  ptype $arg0._M_dataplus._M_p
  printf "[%d] = %s\n", $arg0._M_string_length, $arg0._M_dataplus._M_p
end
define pcstr
  ptype $arg0
  printf "[%d] = %s\n", strlen($arg0), $arg0
end
# }}}

# {{{ QString
define printqs5static
  set $d=$arg0.d
  printf "(Qt5 QString)0x%x length=%i: \"",&$arg0,$d->size
  set $i=0
  set $ca=(const ushort*)(((const char*)$d)+$d->offset)
  while $i < $d->size
    set $c=$ca[$i++]
    if $c < 32 || $c > 127
      printf "\\u%04x", $c
    else
      printf "%c" , (char)$c
    end
  end
  printf "\"\n"
end
define printqs5dynamic
  set $d=(QStringData*)$arg0.d
  printf "(Qt5 QString)0x%x length=%i: \"",&$arg0,$d->size
  set $i=0
  while $i < $d->size
    set $c=$d->data()[$i++]
    if $c < 32 || $c > 127
      printf "\\u%04x", $c
    else
      printf "%c" , (char)$c
    end
  end
  printf "\"\n"
end
# }}}
