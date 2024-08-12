" https://github.com/nfnty/vim-nftables
" License: MIT Copyright (c) 2015 nfnty

if exists('b:current_syntax')
    finish
endif

syn match nftablesSet /{.*}/ contains=nftablesSetEntry
syn match nftablesSetEntry /[a-zA-Z0-9]\+/ contained
hi def link nftablesSet Keyword
hi def link nftablesSetEntry Operator

syn match nftablesNumber "\<[0-9A-Fa-f./:]\+\>" contains=nftablesMask,nftablesDelimiter
syn match nftablesHex "\<0x[0-9A-Fa-f]\+\>"
syn match nftablesDelimiter "[./:]" contained
syn match nftablesMask "/[0-9.]\+" contained contains=nftablesDelimiter
hi def link nftablesNumber Statement
hi def link nftablesHex Number
hi def link nftablesDelimiter Operator
hi def link nftablesMask Operator

syn region Comment start=/#/ end=/$/
syn region String start=/"/ end=/"/
syn keyword Function table tcp udp
syn keyword Statement drop reject log limit
syn keyword Type accept
syn keyword Constant prerouting input forward output postrouting
syn keyword Special snat dnat masquerade queue
syn keyword Keyword continue return goto
syn keyword Keyword define

let b:current_syntax = 'nftables'
