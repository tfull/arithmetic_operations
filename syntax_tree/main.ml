open DataType

let rec evaluate = function
    | EInt n -> n
    | EMinus e -> - evaluate e
    | EAdd (e1, e2) -> evaluate e1 + evaluate e2
    | ESub (e1, e2) -> evaluate e1 - evaluate e2
    | EMul (e1, e2) -> evaluate e1 * evaluate e2
    | EDiv (e1, e2) -> evaluate e1 / evaluate e2
    | EMod (e1, e2) -> (evaluate e1) mod (evaluate e2)

let _ =
    let tree = Parser.parse Tokenizer.tokenize (Lexing.from_channel stdin) in
    print_string (string_of_int (evaluate tree) ^ "\n")
