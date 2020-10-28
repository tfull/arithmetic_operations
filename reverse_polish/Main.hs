module Main where

import Data.Char

main :: IO ()
main = do
    line <- getLine
    let es = words line
    case evaluate [] es of
        Just v -> putStrLn . show $ v
        Nothing -> putStrLn "error"

evaluate :: [Integer] -> [String] -> Maybe Integer
evaluate [value] [] = Just value
evaluate _ [] = Nothing
evaluate (a : b : stack) ("+" : es) = evaluate (b + a : stack) es
evaluate (a : b : stack) ("-" : es) = evaluate (b - a : stack) es
evaluate (a : b : stack) ("*" : es) = evaluate (b * a : stack) es
evaluate (a : b : stack) ("/" : es) = if a == 0 then Nothing else evaluate (b `div` a : stack) es
evaluate (a : b : stack) ("%" : es) = if a == 0 then Nothing else evaluate (b `mod` a : stack) es
evaluate stack (e : es) = if all Data.Char.isDigit e then evaluate ((read e :: Integer) : stack) es else Nothing
