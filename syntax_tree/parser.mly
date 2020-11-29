%{
    open DataType
    let parse_error s = raise (ParseError s)
%}

%token <int> INT
%token PLUS MINUS STAR SLASH MOD
%token LPAR RPAR
%token EOL

%start parse
%type <DataType.expression> parse
%%

parse:
    | exp EOL { $1 }
exp:
    | exp PLUS exp_f { EAdd($1, $3) }
    | exp MINUS exp_f { ESub($1, $3) }
    | exp_f { $1 }
exp_f:
    | exp_f STAR exp_g { EMul($1, $3) }
    | exp_f SLASH exp_g { EDiv($1, $3) }
    | exp_f MOD exp_g { EMod($1, $3) }
    | exp_g { $1 }
exp_g:
    | PLUS exp_h { $2 }
    | MINUS exp_h { EMinus $2 }
    | exp_h { $1 }
exp_h:
    | INT { EInt $1 }
    | LPAR exp RPAR { $2 }
;
