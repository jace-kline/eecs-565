module Playfair where

type Row = Int
type Col = Int
type Key = String
type Ciphertext = String
type Plaintext = String

newtype PlayfairChar = PC { toChar :: Char } deriving Show

instance Eq PlayfairChar where
    (PC x) == (PC y) = x == y || x == 'i' && y == 'j' || x == 'j' && y == 'i'


delete :: (Eq a) => a -> [a] -> [a]
delete y []     = []
delete y (x:xs) = if x == y then delete y xs else x : delete y xs

alphabet :: [Char]
alphabet = ['a'..'z']

playfair_alphabet :: [PlayfairChar]
playfair_alphabet = map PC $ delete 'j' alphabet

-- Restrictions on keys: 
-- (1) Should not contain duplicate characters
-- (2) Should not contain 'i' and 'j' simultaneously

keyTable :: Key -> [(Row, Col, PlayfairChar)]
keyTable k = 
    let is         = [(r, c) | r <- [0..4], c <- [0..4]]
        (is1, is2) = (take (length k) is, drop (length k) is)
        t1         = package is1 $ map PC k
        t2         = package is2 $ filter (\c -> not (c `elem` (map PC k))) playfair_alphabet
    in t1 ++ t2
        where
            package :: [(Row, Col)] -> [PlayfairChar] -> [(Row, Col, PlayfairChar)]
            package coords pcs = zip3 (map fst coords) (map snd coords) pcs

chunkPlaintext :: Plaintext -> [(Char, Char)]
chunkPlaintext []         = []
chunkPlaintext [c]        = [(c, 'x')]
chunkPlaintext (c1:c2:cs) = if c1 == c2
                            then (c1, 'x') : chunkPlaintext (c2:cs)
                            else (c1, c2)  : chunkPlaintext cs

encryptChunk :: [(Row, Col, PlayfairChar)] -> (Char, Char) -> (Char, Char)
encryptChunk t (c1, c2) | row (PC c1) t == row (PC c2) t = (toChar (shiftRight (PC c1) t), toChar (shiftRight (PC c2) t))
                        | col (PC c1) t == col (PC c2) t = (toChar (shiftDown (PC c1) t), toChar (shiftDown (PC c2) t))
                        | otherwise                      = (toChar (intersection (PC c1) (PC c2) t), toChar (intersection (PC c2) (PC c1) t))

getIndex :: PlayfairChar -> [(Row, Col, PlayfairChar)] -> (Row, Col)
getIndex pc ((r, c, pc'):rest) = if pc == pc' then (r, c) else getIndex pc rest

atIndex :: Row -> Col -> [(Row, Col, PlayfairChar)] -> PlayfairChar
atIndex r c ((r', c', pc):rest) = if r == r' && c == c' then pc else atIndex r c rest

shiftRight :: PlayfairChar -> [(Row, Col, PlayfairChar)] -> PlayfairChar
shiftRight pc t = let (r, c) = getIndex pc t
                  in atIndex r ((c + 1) `mod` 5) t

shiftDown :: PlayfairChar -> [(Row, Col, PlayfairChar)] -> PlayfairChar
shiftDown pc t = let (r, c) = getIndex pc t
                  in atIndex ((r + 1) `mod` 5) c t

intersection :: PlayfairChar -> PlayfairChar -> [(Row, Col, PlayfairChar)] -> PlayfairChar
intersection pc1 pc2 t = atIndex (row pc1) (col pc2) t
    where row = fst . ((flip getIndex) t)
          col = snd . ((flip getIndex) t)

row :: PlayfairChar -> [(Row, Col, PlayfairChar)] -> Row
row pc t = fst $ getIndex pc t

col :: PlayfairChar -> [(Row, Col, PlayfairChar)] -> Col
col pc t = snd $ getIndex pc t

encrypt :: Key -> Plaintext -> Ciphertext
encrypt k p = 
    let t        = keyTable k
        p_chunks = chunkPlaintext $ (concat . words) p
    in flat $ map (encryptChunk t) p_chunks
        where flat = foldr (\(x, y) r -> x:y:r) []


