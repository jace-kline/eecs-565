module Vigenere (encrypt, decrypt) where

type Key = String
type Ciphertext = String
type Plaintext = String

alphabet :: [Char]
alphabet = ['a'..'z']

num_char :: [(Int, Char)]
num_char = zip [0..25] alphabet

toChar :: Int -> Char
toChar n = snd (num_char !! n)

toInt :: Char -> Int
toInt c = (fst . head) (dropWhile (\(x, y) -> y /= c) num_char)

encrypt :: Key -> Plaintext -> Ciphertext
encrypt k p = let p_ints = map toInt $ concat $ words p
                  k_ints = map toInt k
                  k_repeat = k_ints ++ k_repeat
              in map (\(x,y) -> toChar ((x + y) `mod` 26)) (zip p_ints k_repeat)

decrypt :: Key -> Ciphertext -> Plaintext
decrypt k c = let c_ints = map toInt c
                  k_ints = map toInt k
                  k_repeat = k_ints ++ k_repeat
              in map (\(x,y) -> toChar ((x - y) `mod` 26)) (zip c_ints k_repeat)

