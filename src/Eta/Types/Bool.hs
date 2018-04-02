{-|
The 'Bool' type and its operations
-}
module Eta.Types.Bool
  ( Bool(..)
  , (&&)
  , (||)
  , (==)
  , (/=)
  , not
  , module Eta.Types.Bool
  )
where

import Data.Bool hiding (otherwise, bool)
import qualified Data.Bool
import Prelude ((==), (/=))

-- $setup
-- >>> import Prelude (Int, foldl, (*))
-- >>> :{
--  factorial :: Int -> Int
--  factorial n = foldl (*) 1 [1..n]
-- :}

{-|
'otherwise' is defined as 'True'.

Used for guards:

@
 factorial :: Int -> Int
 factorial n
  | n == 0      = 1
  | otherwise   = n * factorial (n - 1)
@

>>> factorial 3
6
-}
otherwise :: Bool
otherwise = Data.Bool.otherwise


