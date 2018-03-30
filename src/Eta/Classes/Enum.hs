{-| The 'Enum' class defines operations on
sequentially ordered types
-}
module Eta.Classes.Enum
  ( module Eta.Classes.Enum
  , module Exported
  )
where

import qualified Prelude
import Prelude (Int)
import Prelude as Exported
  ( Enum
  , toEnum
  , fromEnum
  )


{-|
Successor of a value

>>> successor 1
2
-}
successor :: (Enum a) => a -> a
successor = Prelude.succ

{-|
Predecessor of a value

>>> predecessor 1
0
-}
predecessor :: (Enum a) => a -> a
predecessor = Prelude.pred

{-|
Converts an 'Int' into the equivalent value
of the enumeration

>>> toEnumeration 1 :: Bool
True
-}
toEnumeration :: (Enum a) => Int -> a
toEnumeration = Prelude.toEnum

{-|
Converts a value from an enumeration into the
equivalent 'Int' value

>>> fromEnumeration False
0
-}
fromEnumeration :: (Enum a) => a -> Int
fromEnumeration = Prelude.fromEnum

{-|
Generates a list from the beginning
of the type to the end

>>> take 4 (enumerateFrom 0)
[0,1,2,3]
>>> enumerateFrom False
[False,True]
-}
enumerateFrom :: (Enum a) => a -> [a]
enumerateFrom = Prelude.enumFrom

{-|
Generates a list from the beginning
of the type to the end, with steps

>>> take 4 (steppingEnumerateFrom 0 2)
[0,2,4,6]
-}
steppingEnumerateFrom :: (Enum a) => a -> a -> [a]
steppingEnumerateFrom = Prelude.enumFromThen

{-|
Generates a list from the beginning
of the type to the specified limit

>>> enumerateFromTo 0 3
[0,1,2,3]
-}
enumerateFromTo :: (Enum a) => a -> a -> [a]
enumerateFromTo = Prelude.enumFromTo

{-|
Generates a list from the beginning
of the type to the specified limit,
with steps

>>> steppingEnumerateFromTo 0 2 8
[0,2,4,6,8]
-}
steppingEnumerateFromTo :: (Enum a) => a -> a -> a -> [a]
steppingEnumerateFromTo = Prelude.enumFromThenTo

