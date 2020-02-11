module Shift where

import Data.List (sortBy)

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

letter_count c s = foldr (\x rest -> (if x == c then 1 else 0) + rest) 0 s
letter_counts s = [(c, letter_count c s) | c <- ['a'..'z']]

frequency_order s = (fst . unzip) (sortBy f (letter_counts s))
    where f (_,x1) (_,x2) = compare x2 x1

str1 = "fqjcb rwjwj vnjax bnkhj whxcq nawjv nfxdu mbvnu ujbbf nnc"

{- PROBLEM 1:
    > frequency_order str1
    jnbwcfuvxahqdkmregilopstyz
    > tryDecrypt 'j' 'e' str1
    "alexw mrere qievs wifce rcsxl ivreq iasyp hwqip pewwa iix" 
    -- Not plausible plaintext, try next
    > tryDecrypt 'n' 'e' str1
    "whats inana mearo sebya nyoth ernam ewoul dsmel lassw eet"

    After re-chunking the decrypted string str, we find that the plaintext message is...
    "whats in a name arose by any other name would smell just as sweet"
-}

str2 = "oczmz vmzor jocdi bnojv dhvod igdaz admno ojbzo rcvot jprvi oviyv aozmo cvooj ziejt dojig toczr dnzno jahvi fdiyv xcdzq zoczn zxjiy"

{- PROBLEM 2:
    > frequency_order str2
    "ozvdijcnamrtybghxefpqklsuw"
    > tryDecrypt 'o' 'e' str2
    "espcp lcpeh zesty rdezl txlet ywtqp qtcde ezrpe hslej zfhly elyol qepce sleez pyuzj tezyw jesph tdpde zqxly vtyol nstpg pespd pnzyo"
    -- Not plausible plaintext, try next
    > tryDecrypt 'z' 'e' str2
    "there aretw othin gstoa imati nlife first toget whaty ouwan tanda ftert hatto enjoy itonl ythew isest ofman kinda chiev ethes econd"


-}