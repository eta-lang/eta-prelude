module Eta.Classes.Applicative
  ( Applicative(pure, (<*>))
  , apply
  , (<*|)
  , (|*>)
  )
where

import Control.Applicative(Applicative(pure, (<*>)))

-- $setup
-- >>> import Eta.Types
-- >>> import Eta.Classes.Num

{-|
The 'Applicative' type class defines that a type
can have an 'apply' operation which can be used
to apply a function contained in the 'Applicative'
to the elements of Another.

All types that implement 'Applicative' must implement
'Functor'.

The 'Maybe' type is an example of
an instance of 'Applicative'.

>>> apply (Just (+1)) (Just 2)
Just 3

/Mnemonic: Applyable/
-}
apply :: (Applicative f) => f (a -> b) -> f a -> f b
apply = (Control.Applicative.<*>)

-- *** Apply forward
{-|
Applies the function contained in the Applicative of the right
to the Applicative which contains a value of the left:

>>> Just 1 |*> Just (+2)
Just 3
-}
(|*>) :: (Applicative f) => f a -> f (a -> b) -> f b
(|*>) a b = b <*| a


-- *** Apply backwards
{-|
Applies the function contained in the Applicative of the left
to the Applicative which contains a value of the right:

>>> Just (+ 1) <*| Just 2
Just 3
-}
(<*|) :: (Applicative f) => f (a -> b) -> f a -> f b
(<*|) = (Control.Applicative.<*>)

