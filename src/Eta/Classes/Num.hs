{-|
The 'Num' type class defines basic numerical
operations:

* Addition @(+)@
* Subtraction @(-)@
* Multiplication @(*)@
* Negation @(negate)@
* Absolute value @(absoluteValue)@
* Sign of a number @(numberSign)@
* Conversion from 'Integer' @(fromInteger)@

-}
module Eta.Classes.Num
  ( Num(..)
  , absoluteValue
  , numberSign
  )
where

import Prelude(Num(..))

{-|
Returns the absolute value

>>> absoluteValue (-1)
1
>>> absoluteValue 1
1
-}
absoluteValue :: (Num a) => a -> a
absoluteValue = abs

{-|
Returns the number sign

>>> numberSign (-4)
-1
>>> numberSign 9
1
>>> numberSign 0
0
-}
numberSign :: (Num a) => a -> a
numberSign = signum
