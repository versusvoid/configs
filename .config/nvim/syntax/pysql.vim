if exists("b:current_syntax")
  finish
endif

" Load Python syntax at the top level
runtime! syntax/python.vim

" Needed to make syntax/sql.vim do something
unlet b:current_syntax

" Load SQL syntax
syntax include @SQL syntax/pgsql.vim

" Need to add the keepend here
syn region pythonString matchgroup=pythonQuotes
      \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=pythonEscape,@Spell keepend
syn region  pythonRawString matchgroup=pythonQuotes
      \ start=+[uU]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=@Spell keepend

syn region SQLEmbedded contains=@SQL containedin=pythonString,pythonRawString contained
    \ start=+\v(with|alter|begin|comment|commit|create|delete|drop|end|explain|grant|insert|revoke|rollback|select|set|truncate|unset|update)+
    \ end=+;+

let b:current_syntax = "pysql"
