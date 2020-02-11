module ShiftCipher where

import SubstitutionCipher

encryptChar = shift_right
decryptChar = shift_left
encryptStr n s = map (\c -> if c /= ' ' then (encryptChar n c) else ' ') s
decryptStr n s = map (\c -> if c /= ' ' then (decryptChar n c) else ' ') s
caesarEncrypt = encryptStr 3
caesarDecrypt = decryptStr 3
tryDecrypt enc plain = decryptStr (findShift enc plain)
bruteForce s = [tryDecrypt c 'e' s | c <- alphabet]