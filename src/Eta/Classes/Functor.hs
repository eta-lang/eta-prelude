{-|
The 'Functor' type class defines that a type
can have a 'map' operation which can be used
to map a function over the elements of it.

The list and the 'Maybe' types are examples of
instances of 'Functor'.

/Mnemonic: Mappable/
-}
module Eta.Classes.Functor
  ( module Eta.Classes.Functor
  , Functor(fmap)
  )
where

import Data.Functor (Functor(fmap))

import qualified Data.Functor

-- $setup
-- >>> import Prelude ((+))

{-|
Maps a function over a value

>>> map (+1) [1,2,3]
[2,3,4]
-}
map :: (Functor f) => (a -> b) -> f a -> f b
map = Data.Functor.fmap


-- *** Map forward
{-|
Maps the function of the right to the Functor of the left:


>>> [1,2,3] |$> (+ 1)
[2,3,4]

-}
(|$>) :: (Functor f) => f a -> (a -> b) -> f b
(|$>) x f = f <$| x


-- *** Map backwards
{-|
Maps the function of the left to the Functor of the right:


>>> (+1) <$| [1,2,3]
[2,3,4]

-}
(<$|) :: (Functor f) => (a -> b) -> f a -> f b
(<$|) = fmap


-- *** Discard
{-|
Discards the value inside of the functor.


>>> discard [1,2,3]
[(),(),()]

-}
discard :: (Functor f) => f a -> f ()
discard = Data.Functor.void



