type expression =
    | EInt of int
    | EAdd of expression * expression
    | ESub of expression * expression
    | EMul of expression * expression
    | EDiv of expression * expression
    | EMod of expression * expression
    | EMinus of expression

exception ParseError of string
exception TokenizeError of string
