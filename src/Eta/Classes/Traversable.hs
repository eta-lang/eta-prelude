{-|
The 'Traversable' type class defines that a structure
can be traversed from left to right, applying some
flatmappable function to it.

@
>> traverse readFile ["foo.txt", "bar.txt", "quux.txt"]
["foo contents" , "bar contents", "quux contents"]
@

It basically applies the actions inside of the type that
the passed returns, and collects them, unless it fails.

@
safeDivide a b =
    if b == 0
    then Nothing
    else Just (a / b)
@

>>> traverse (safeDivide 2) [1, 2]
Just [2,1]

>>> traverse (safeDivide 2) [0, 2]
Nothing
-}
module Eta.Classes.Traversable
  ( Traversable(traverse, sequenceA)
  )
where

import Eta.Classes.Applicative
import Eta.Classes.Integral
import Eta.Types

import Data.Traversable(Traversable(traverse, sequenceA))
import qualified Data.Traversable

-- $setup
-- >>> import Prelude (($), (+))
-- >>> :{
-- safeDivide a b =
--     if b == 0
--     then Nothing
--     else Just (a `div` b)
-- :}

{-|
'traverse' with the arguments flipped, allows to work in an imperative manner,
like with 'foreach':

>>> :{
 for [1..3] $ \i -> do
    let x = i + 1
    Just x
:}
Just [2,3,4]

-}
for :: (Traversable t, Applicative m) => t a -> (a -> m b) -> m (t b)
for = Data.Traversable.for


{-|
'sequence' moves the context of each of the elements of
a 'Traversable' structure to the structure itself

>>> sequence [Just 1, Just 2]
Just [1,2]

>>> sequence [Just 1, Nothing]
Nothing
-}
sequence :: (Traversable t, Applicative m) => t (m a) -> m (t a)
sequence = Data.Traversable.sequenceA

