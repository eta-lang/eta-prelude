{-|
The 'Monoid' type class defines that a type
can have an 'append' operation which can be used
to append two things of the same type

The List, and String types are examples of
instances of 'Monoid'.

/Mnemonic: Appendable/
-}
module Eta.Prelude.Classes.Monoid
where

import qualified Data.Monoid

import Prelude as Exported
  ( Monoid
  , mappend
  , mconcat
  , mempty
  )

{-|
Appends two values.

>>> append "Hello " "world!"
"Hello world!"
-}
append :: (Monoid a) => a -> a -> a
append = mappend


-- *** Monoid neutral element
{-|
A 'Monoid' also requires that the type has a neutral
element that does not affect concatenation.

$
>>> import Prelude (String, Int)

>>> neutral :: String
""

>>> neutral :: [Int]
[]
-}
neutral :: (Monoid a) => a
neutral = mempty


-- *** Monoid reduction
{-|
You can reduce a list of elements that implement the
'Monoid' type class by using 'concat'

>>> concat ["Hello ", "world", "!"]
"Hello world!"

-}
concat :: (Monoid a) => [a] -> a
concat = mconcat


-- *** Append operator
{-|
Operator for the 'append' operation


>>> "Hello " <+> "world!"
"Hello world!"
-}
(<+>) :: (Monoid a) => a -> a -> a
(<+>) = (Data.Monoid.<>)
