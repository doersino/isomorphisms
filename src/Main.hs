module Main where

import Test.QuickCheck

--------------------------------------------------------------------------------

itom :: Integer -> Maybe Integer
itom 0 = Nothing
itom i = Just $ if i < 0 then i else i - 1

mtoi :: Maybe Integer -> Integer
mtoi Nothing  = 0
mtoi (Just i) = if i < 0 then i else i + 1

--------------------------------------------------------------------------------

itoe :: Integer -> Either Integer Integer
itoe i | odd  i = Left  $ (i - 1) `div` 2
       | even i = Right $  i      `div` 2

etoi :: Either Integer Integer -> Integer
etoi (Left  i) = i * 2 + 1
etoi (Right i) = i * 2

--------------------------------------------------------------------------------

type Nat = Integer  -- but not negative, which we won't enforce here

iton :: Integer -> Nat
iton i = if i >= 0 then i * 2 else -i * 2 - 1

ntoi :: Nat -> Integer
ntoi n = if even n then n `div` 2 else -(n + 1) `div` 2

--------------------------------------------------------------------------------

itol :: Integer -> [()]
itol i = replicate (fromIntegral $ iton i) ()

ltoi :: [()] -> Integer
ltoi l = ntoi $ (fromIntegral . length) l

--------------------------------------------------------------------------------

itot :: Integer -> (Integer,Integer)
itot z = (ntoi $ j - k, ntoi k)
  where
    z' = iton z
    j = floor $ sqrt (0.25 + 2 * fromIntegral z') - 0.5
    k = z' - j * (j + 1) `div` 2

ttoi :: (Integer,Integer) -> Integer
ttoi (x,y) = ntoi $ ((x' + y') * (x' + y' + 1)) `div` 2 + y'
  where
    (x',y') = (iton x, iton y)

--------------------------------------------------------------------------------

itolofi :: Integer -> [Integer]
itolofi i = map fst $ take (fromIntegral l) $ iterate (\(x,y) -> itot y) (itot i')
  where
    (l,i') = itot i

lofitoi :: [Integer] -> Integer
lofitoi is = ttoi (fromIntegral $ length is, foldr (\a b -> ttoi (a,b)) 0 is)

--------------------------------------------------------------------------------

mtest1 :: Integer -> Bool
mtest1 x = (mtoi . itom) x == id x
mtest2 :: Maybe Integer -> Bool
mtest2 x = (itom . mtoi) x == id x

etest1 :: Integer -> Bool
etest1 x = (etoi . itoe) x == id x
etest2 :: Either Integer Integer -> Bool
etest2 x = (itoe . etoi) x == id x

ntest1 :: Integer -> Bool
ntest1 x = (ntoi . iton) x == id x
ntest2 :: Nat -> Bool
ntest2 x | x >= 0    = (iton . ntoi) x == id x
         | otherwise = True  -- test makes no sense for negative numbers

ltest1 :: Integer -> Bool
ltest1 x = (ltoi . itol) x == id x
ltest2 :: [()] -> Bool
ltest2 x = (itol . ltoi) x == id x

ttest1 :: Integer -> Bool
ttest1 x = (ttoi . itot) x == id x
ttest2 :: (Integer,Integer) -> Bool
ttest2 x = (itot . ttoi) x == id x

lofitest1 :: Integer -> Bool
lofitest1 x = (lofitoi . itolofi) x == id x
lofitest2 :: [Integer] -> Bool
lofitest2 x = (itolofi . lofitoi) x == id x

--------------------------------------------------------------------------------

main :: IO ()
main = do
  quickCheck mtest1
  quickCheck mtest2
  quickCheck etest1
  quickCheck etest2
  quickCheck ntest1
  quickCheck ntest2
  quickCheck ltest1
  quickCheck ltest2
  quickCheck ttest1
  quickCheck ttest2
  quickCheck lofitest1
  quickCheck lofitest2
