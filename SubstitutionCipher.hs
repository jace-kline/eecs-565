module SubstitutionCipher where

import Data.List (sortBy, nub)

alphabet = ['a'..'z']

char_num = zip alphabet [0..25]

num_char = zip [0..25] alphabet

toChar n = snd (num_char !! n)

toNum c = (fst . head) (dropWhile (\(x, y) -> y /= c) num_char)

shift_right n c = toChar (((toNum c) + n) `mod` 26)

shift_left n c = toChar (((toNum c) - n) `mod` 26)

findShift enc plain = ((toNum enc) - (toNum plain)) `mod` 26

single_count x s = foldr (\y rest -> (if y == x then 1 else 0) + rest) 0 s

single_counts s = [(c, single_count c s) | c <- ['a'..'z']]

frequency_singles s = (fst . unzip) (sortBy comp (single_counts s))

doubles [] = []
doubles (c:[]) = []
doubles (' ':cs) = doubles cs
doubles (_:' ':cs) = doubles cs
doubles (c1:c2:cs) = (c1, c2) : doubles (c2:cs)

double_count x s = foldr (\y rest -> (if y == x then 1 else 0) + rest) 0 (doubles s)

double_counts s = [(x, double_count x s) | x <- doubles s]
frequency_doubles s = (nub . fst . unzip) (sortBy comp (double_counts s))

comp (_,x1) (_,x2) = compare x2 x1

