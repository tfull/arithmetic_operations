{
    open DataType
    open Parser
}

let digit = ['0' - '9']

rule tokenize = parse
    | [ ' ' '\t'] { tokenize lexbuf }
    | '\n' { EOL }
    | digit+ as v { INT (int_of_string v) }
    | '+' { PLUS }
    | '-' { MINUS }
    | '*' { STAR }
    | '/' { SLASH }
    | '%' { MOD }
    | '(' { LPAR }
    | ')' { RPAR }
    | _ { raise (TokenizeError "illegal character") }
