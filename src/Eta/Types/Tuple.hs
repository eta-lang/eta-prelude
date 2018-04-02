module Eta.Types.Tuple
  ( first
  , second
  , curry
  , uncurry
  , swap
  )
where

import Data.Tuple

{-|
Extract the first component of a pair

>>> first (1, 2)
1
-}
first :: (a, b) -> a
first = fst


{-|
Extract the second component of a pair

>>> second (1, 2)
2
-}
second :: (a, b) -> b
second = snd

