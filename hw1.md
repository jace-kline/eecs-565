# EECS 565 - HW 1
## Jace Kline 2881618

### Substitution Cipher Module

```haskell
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
```

### Shift Cipher Module

```haskell

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
```

### Solution Code Work

```haskell
import SubstitutionCipher as Sub
import ShiftCipher as Shift

str1 = "fqjcb rwjwj vnjax bnkhj whxcq nawjv nfxdu mbvnu ujbbf nnc"

{- PROBLEM 1:
    > Shift.frequency_order str1
    jnbwcfuvxahqdkmregilopstyz
    > Shift.tryDecrypt 'j' 'e' str1
    "alexw mrere qievs wifce rcsxl ivreq iasyp hwqip pewwa iix" 
    -- Not plausible plaintext, try next
    > Shift.tryDecrypt 'n' 'e' str1
    "whats inana mearo sebya nyoth ernam ewoul dsmel lassw eet"
    After re-chunking the decrypted string str1, we find that the plaintext message is...
    "whats in a name arose by any other name would smell just as sweet"
-}

str2 = "oczmz vmzor jocdi bnojv dhvod igdaz admno ojbzo rcvot jprvi oviyv aozmo cvooj ziejt dojig toczr dnzno jahvi fdiyv xcdzq zoczn zxjiy"

{- PROBLEM 2:
    > Shift.frequency_order str2
    "ozvdijcnamrtybghxefpqklsuw"
    > Shift.tryDecrypt 'o' 'e' str2
    "espcp lcpeh zesty rdezl txlet ywtqp qtcde ezrpe hslej zfhly elyol qepce sleez pyuzj tezyw jesph tdpde zqxly vtyol nstpg pespd pnzyo"
    -- Not plausible plaintext, try next
    > Shift.tryDecrypt 'z' 'e' str2
    "there aretw othin gstoa imati nlife first toget whaty ouwan tanda ftert hatto enjoy itonl ythew isest ofman kinda chiev ethes econd"
    After re-chunking the decrypted string str2, we find that the plaintext message is...
    "there are two things to aim at in life first to get what you want and after that to enjoy it only the wisest of mankind achieve the second"
-}

str3 = "pbegu uymiq icuuf guuyi qguuy qcuiv fiqgu uyqcu qbeme vp"

{- PROBLEM 3:
    > Shift.frequency_order str3
    "uqigycebfmpvadhjklnorstwxz"
    > Shift.tryDecrypt 'u' 'e' str3
    "zloqe eiwsa smeep qeeis aqeei amesf psaqe eiame alowo fz"
    > Shift.tryDecrypt 'q' 'e' str3
    "dpsui imawe wqiit uiimw euiim eqiwj tweui imeqi epsas jd"
    -- Try all shift possibilities to see if anything looks reasonable
    > Shift.bruteForce str3
    ["tfiky ycqmu mgyyj kyycm ukyyc ugymz jmuky ycugy ufiqi zt","sehjx xbplt lfxxi jxxbl tjxxb tfxly iltjx xbtfx tehph ys","rdgiw waoks kewwh iwwak siwwa sewkx hksiw wasew sdgog xr","qcfhv vznjr jdvvg hvvzj rhvvz rdvjw gjrhv vzrdv rcfnf wq","pbegu uymiq icuuf guuyi qguuy qcuiv fiqgu uyqcu qbeme vp","oadft txlhp hbtte fttxh pfttx pbthu ehpft txpbt padld uo","nzces swkgo gassd esswg oessw oasgt dgoes swoas ozckc tn","mybdr rvjfn fzrrc drrvf ndrrv nzrfs cfndr rvnzr nybjb sm","lxacq quiem eyqqb cqque mcqqu myqer bemcq qumyq mxaia rl","kwzbp pthdl dxppa bpptd lbppt lxpdq adlbp ptlxp lwzhz qk","jvyao osgck cwooz aoosc kaoos kwocp zckao oskwo kvygy pj","iuxzn nrfbj bvnny znnrb jznnr jvnbo ybjzn nrjvn juxfx oi","htwym mqeai aummx ymmqa iymmq iuman xaiym mqium itwew nh","gsvxl lpdzh ztllw xllpz hxllp htlzm wzhxl lphtl hsvdv mg","fruwk kocyg yskkv wkkoy gwkko gskyl vygwk kogsk grucu lf","eqtvj jnbxf xrjju vjjnx fvjjn frjxk uxfvj jnfrj fqtbt ke","dpsui imawe wqiit uiimw euiim eqiwj tweui imeqi epsas jd","corth hlzvd vphhs thhlv dthhl dphvi svdth hldph dorzr ic","bnqsg gkyuc uoggr sggku csggk coguh rucsg gkcog cnqyq hb","amprf fjxtb tnffq rffjt brffj bnftg qtbrf fjbnf bmpxp ga","zloqe eiwsa smeep qeeis aqeei amesf psaqe eiame alowo fz","yknpd dhvrz rlddo pddhr zpddh zldre orzpd dhzld zknvn ey","xjmoc cguqy qkccn occgq yoccg ykcqd nqyoc cgykc yjmum dx","wilnb bftpx pjbbm nbbfp xnbbf xjbpc mpxnb bfxjb xiltl cw","vhkma aesow oiaal maaeo wmaae wiaob lowma aewia whksk bv","ugjlz zdrnv nhzzk lzzdn vlzzd vhzna knvlz zdvhz vgjrj au"]
    -- No reasonable-looking outputs => Not a shift cipher
    -- Let's try alternative substitution ciphers... 1st: Monoalphabetic cipher
    -- Common 4 letter cipher sequence is "guuy" - shows up 4 times
    -- Since "oo" is a common double-letter combo, let u -> o
    "pbegOOymiqicOOfgOOyiqgOOyqcOivfiqgOOyqcuqbemevp"
    -- Try the first 3 letters to be "the". Hence p -> t, b -> h, e -> e
    "THEgOOymiqicOOfgOOyiqgOOyqcOivfiqgOOyqcuqHEmEvT"
    -- Try g -> l because l often comes directly before oo
    "THELOOymiqicOOfLOOyiqLOOyqcOivfiqLOOyqcuqHEmEvT"
    -- Try y -> k because "look" seems like a logical word to attempt
    "THELOOKmiqicOOfLOOKiqLOOKqcOivfiqLOOKqcuqHEmEvT"
    -- "good look" seems to be a logical fill for the second "look" that appears. Hence c -> g, f -> d.
    "THELOOKmiqiGOODLOOKiqLOOKqGOivDiqLOOKqGuqHEmEvT"
    -- We see that "miqi" falls between LOOK and GOOD, and "iq" falls between LOOK and LOOK. We can try iq -> as and miqi -> wasa.
    "THELOOKWASAGOODLOOKASLOOKqGOAvDAqLOOKqGuqHEmEvT"
    -- q -> s because this is the only thing that would make sense at the end of GOOD and before GO
    "THELOOKWASAGOODLOOKASLOOKSGOAvDASLOOKSGuSHEmEvT"
    -- v -> d to complete an AND, and u -> o to complete GO
    "THELOOKWASAGOODLOOKASLOOKSGOANDASLOOKSGOSHEmEvT"
    -- m -> w, v -> n to complete WENT
    "THELOOKWASAGOODLOOKASLOOKSGOANDASLOOKSGOSHEWENT"
    *Note: There was more trial and error than was shown here*
    By re-chunking the plaintext, we arrive at...
    "the look was a good look as looks go and as looks go she went"
-}
```

## Solution Summary
1. "whats in a name arose by any other name would smell just as sweet"
2. "there are two things to aim at in life first to get what you want and after that to enjoy it only the wisest of mankind achieve the second"
3. "the look was a good look as looks go and as looks go she went"
