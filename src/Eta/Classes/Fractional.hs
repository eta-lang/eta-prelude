{-|
The 'Fractional' type class defines Fractional values
and how are they are divided:

* Fractional division @(/)@
* Conversion from 'Rational' @fromRational@
-}
module Eta.Classes.Fractional
  ( module Eta.Classes.Fractional
  , Fractional
  , (/)
  , (**)
  , recip
  , fromRational
  )
where

import Prelude

{-|
Inverts the fraction

>>> x  = 7/2
>>> x' = 2/7
>>> fractionReciprocal x == x'
True
-}
fractionReciprocal :: (Fractional a) => a -> a
fractionReciprocal = recip

