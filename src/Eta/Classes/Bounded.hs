{-| The 'Bounded' class defines the upper and lower limit of a type

-}
module Eta.Classes.Bounded
  ( module Eta.Classes.Bounded
  , module Exported
  )
where

import Prelude as Exported
  ( Bounded
  , minBound
  , maxBound
  )

{-|
Returns the lower limit of a type

>>> minimumBound :: Int
-9223372036854775808
>>> minimumBound :: Bool
False
-}
minimumBound :: (Bounded a) => a
minimumBound = minBound

{-|
Returns the upper limit of a type

>>> maximumBound :: Int
9223372036854775807
>>> maximumBound :: Bool
True
-}
maximumBound :: (Bounded a) => a
maximumBound = maxBound

