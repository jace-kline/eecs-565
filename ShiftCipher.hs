module Shift where

chars = ['a'..'z']
char_num = zip chars [0..25]
num_char = zip [0..25] chars

toChar n = snd (num_char !! n)
toNum c = (fst . head) (dropWhile (\(x, y) -> y /= c) num_char)
shift_right n c = toChar (((toNum c) + n) `mod` 26)
shift_left n c = toChar (((toNum c) - n) `mod` 26)
encryptChar = shift_right
decryptChar = shift_left
encryptStr n s = map (\c -> if c /= ' ' then (encryptChar n c) else ' ') s
decryptStr n s = map (\c -> if c /= ' ' then (decryptChar n c) else ' ') s
caesarEncrypt = encryptStr 3
caesarDecrypt = decryptStr 3
findShift enc plain = ((toNum enc) - (toNum plain)) `mod` 26
tryDecrypt enc plain = decryptStr (findShift enc plain)

c = "fqjcb rwjwj vnjax bnkhj whxcq nawjv nfxdu mbvnu ujbbf nnc"