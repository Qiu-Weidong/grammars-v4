/*
BSD License

Copyright (c) 2022, Tom Everett
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. Neither the name of Tom Everett nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
grammar star;

star
   : datablock* EOF
   ;

datablock
   : DATA element+
   ;

element
   : (keyval | saveframe | global | loop)+
   ;

saveframe
   : save (dataname | dataitem | loop)+
   ;

loop
   : LOOP dataname+ (dataitem+ STOP?)+
   ;

keyval
   : dataname dataitem
   ;

dataitem
   : string
   | literal
   | loop
   ;

string
   : STRING1
   | STRING2
   ;

dataname
   : DATANAME
   ;

save
   : SAVE
   ;

global
   : GLOBAL
   ;

literal
   : LITERAL
   ;

STRING1
   : '\'' .*? '\''
   ;

STRING2
   : '"' .*? '"'
   ;

LITERAL
   : [a-zA-Z0-9()'.+-/*]+
   ;

LOOP
   : 'loop_'
   ;

STOP
   : 'stop_'
   ;

GLOBAL
   : 'global_'
   ;

SAVE
   : 'save_' [a-zA-Z0-9_]+
   ;

DATA
   : 'data_' [a-zA-Z0-9_]+
   ;

DATANAME
   : '_' [a-zA-Z0-9_]+
   ;

COMMENT
   : '#' ~ [\r\n]* -> skip
   ;

WS
   : [ \r\n\t]+ -> skip
   ;

