{-|
The 'Integral' type class defines Integral values
and how are they able to be divided
-}
module Eta.Classes.Integral
  ( module Eta.Classes.Integral
  , Integral
  , quot
  , rem
  , div
  , mod
  , quotRem
  , divMod
  , toInteger
  , (^)
  , (^^)
  )
where

-- import Prelude (toRational)
import Prelude

{-|
Integer division, rounded down

>>> 4 `dividedBy` 2
2
>>> 5 `dividedBy` 2
2
-}
dividedBy :: (Integral a) => a -> a -> a
dividedBy = div

{-|
Integer modulus

>>> 4 `modulus` 2
0
>>> 5 `modulus` 2
1
-}
modulus :: (Integral a) => a -> a -> a
modulus = mod

{-|
Returns result of the division and its remainder

>>> 7 `divideWithRemainder` 2
(3,1)
-}
divideWithRemainder :: (Integral a) => a -> a -> (a, a)
divideWithRemainder = divMod

{-|
>>> isEven 2
True
-}
isEven :: (Integral a) => a -> Bool
isEven x = (x `modulus` 2) == 0

{-|
>>> isOdd 2
False
-}
isOdd :: (Integral a) => a -> Bool
isOdd x = (x `modulus` 2) /= 0
