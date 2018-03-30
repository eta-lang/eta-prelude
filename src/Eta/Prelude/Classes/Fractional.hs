{-|
The 'Fractional' type class defines Fractional values
and how are they are divided:

* Fractional division @(/)@
* Conversion from 'Rational' @fromRational@
-}
module Eta.Prelude.Classes.Fractional
  ( module Eta.Prelude.Classes.Fractional
  , module Exported
  )
where

import Prelude as Exported
  ( Fractional
  , (/)
  , recip
  , fromRational
  )

{-|
Inverts the fraction

>>> x  = 7/2
>>> x' = 2/7
>>> fractionReciprocal x == x'
True
-}
fractionReciprocal :: (Fractional a) => a -> a
fractionReciprocal = recip

