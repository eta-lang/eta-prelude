{-| The 'Ord' class defines ordering

A helper datatype exists to denote the 'Ordering'

>>> compare 1 2
LT
>>> compare 2 1
GT
>>> compare 2 2
EQ
>>> 1 < 2
True
>>> 1 > 2
False
>>> 1 >= 2
False
>>> 1 <= 2
True
-}
module Eta.Classes.Ord
  ( module Eta.Classes.Ord
  , module Exported
  )
where

import Prelude as Exported
  ( Ord
  , Ordering(..)

  , compare
  , (<=)
  , (<)
  , (>=)
  , (>)
  )

{-|
Returns the largest of the two arguments

>>> largestOf 1 2
2
-}
largestOf :: (Ord a) => a -> a -> a
largestOf x y = if x > y then x else y

{-|
Returns the least of the two arguments

>>> leastOf 1 2
1
-}
leastOf :: (Ord a) => a -> a -> a
leastOf x y = if x < y then x else y


