module Eta.Classes.Foldable
  ( Data.Foldable.Foldable(foldMap, foldr)
  , foldRight
  , foldLeft
  , strictFoldRight
  , strictFoldLeft
  , monadicFoldRight
  , monadicFoldLeft
  , Eta.Classes.Foldable.toList
  , isEmpty
  , Eta.Classes.Foldable.length
  , isElementOf
  , Eta.Classes.Foldable.maximum
  , maximumBy
  , unsafeMaximum
  , Eta.Classes.Foldable.minimum
  , minimumBy
  , unsafeMinimum
  , Eta.Classes.Foldable.sum
  , Eta.Classes.Foldable.product
  , findBy
  , Eta.Classes.Foldable.any
  , Eta.Classes.Foldable.all
  , discardTraverse
  , foreach
  )
where

import Eta.Classes.Applicative
import Eta.Classes.Eq
import Eta.Classes.Monad
import Eta.Classes.Num
import Eta.Classes.Ord
import Eta.Types

import Data.Foldable(Foldable(foldr, foldMap))
import qualified Data.Foldable

-- $ setup
-- >>> import Eta.Classes.Show
-- >>> import Eta.Types

-- ** Foldable
{-|
The 'Foldable' type class defines that a type
can have a 'foldRight' operation which can be used
to reduce it by passing a binary operation and a
neutral element. This reduces starting from the right.

The List type is an example of 'Foldable'

>>> foldRight (+) 0 [1, 2, 3]
6

/Mnemonic: Reduceable/
-}
foldRight :: (Foldable f) => (a -> b -> b) -> b -> f a -> b
foldRight = Data.Foldable.foldr


{-|
'foldLeft' starts from the left, using the lazy evaluation
capabilities of Eta. Note that this will get stuck in an
infite loop if you pass an infite list to it.
-}
foldLeft :: (Foldable f) => (b -> a -> b) -> b -> f a -> b
foldLeft = Data.Foldable.foldl


{-|
A version of 'foldRight' that evaluates the operations inline,
hence /strict/, the opposite of lazy.
-}
strictFoldRight :: (Foldable f) => (a -> b -> b) -> b -> f a -> b
strictFoldRight = Data.Foldable.foldr'


{-|
A version of 'foldLeft' that evaluates the operations inline,
hence /strict/, the opposite of lazy.
-}
strictFoldLeft :: (Foldable f) => (b -> a -> b) -> b -> f a -> b
strictFoldLeft = Data.Foldable.foldl'


{-|
A version of 'foldRight' that applies functions that are flatmappable,
in the context of a type that implements a monad, and returns the
result produced by the reduction of the structure, wrapped in that type:

>>> :{
 addIntoMaybe :: Int -> Int -> Maybe Int
 addIntoMaybe a b = Just (a + b)
:}

>>> monadicFoldRight addIntoMaybe 0 [1,2,3]
Just 6

-}
monadicFoldRight :: (Foldable f, Monad m) => (a -> b -> m b) -> b -> f a -> m b
monadicFoldRight = Data.Foldable.foldrM


{-|
Left-biased version of 'monadicFoldRight'
-}
monadicFoldLeft :: (Foldable f, Monad m) => (b -> a -> m b) -> b -> f a -> m b
monadicFoldLeft = Data.Foldable.foldlM


{-|
Converts a type that implements 'Foldable' into a list
-}
toList :: (Foldable f) => f a -> [a]
toList = Data.Foldable.toList


{-|
Checks if a 'Foldable' structure is empty.
-}
isEmpty :: (Foldable f) => f a -> Bool
isEmpty = Data.Foldable.null


{-|
Returns the size of a structure.
-}
length :: (Foldable f) => f a -> Int
length = Data.Foldable.length


{-|
Checks if the element is contained in the structure.
-}
isElementOf :: (Eq a, Foldable f) => a -> f a -> Bool
isElementOf = Data.Foldable.elem


{-|
Largest element in a structure.
Returns 'Nothing' if the structure is empty.
-}
maximum :: (Ord a, Foldable f) => f a -> Maybe a
maximum x =
  if isEmpty x
  then Nothing
  else Just (unsafeMaximum x)


{-|
Given some comparison function, return the maximum of a
structure. Returns 'Nothing' if the structure is empty.
-}
maximumBy :: (Foldable f) => (a -> a -> Ordering) -> f a -> Maybe a
maximumBy pred x =
  if isEmpty x
  then Nothing
  else Just (Data.Foldable.maximumBy pred x)


{-|
Largest element in a structure.
Errors if the structure is empty
-}
unsafeMaximum :: (Ord a, Foldable f) => f a -> a
unsafeMaximum = Data.Foldable.maximum
{-# WARNING unsafeMaximum "Partial functions should be avoided"#-}

{-|
Smallest element in a structure
Returns 'Nothing' if the structure is empty.
-}
minimum :: (Ord a, Foldable f) => f a -> Maybe a
minimum x =
  if isEmpty x
  then Nothing
  else Just (unsafeMinimum x)


{-|
Given some comparison function, return the minimum of a
structure. Returns 'Nothing' if the structure is empty.
-}
minimumBy :: (Foldable f) => (a -> a -> Ordering) -> f a -> Maybe a
minimumBy pred x =
  if isEmpty x
  then Nothing
  else Just (Data.Foldable.minimumBy pred x)


{-|
Largest element in a structure.
Errors if the structure is empty
-}
unsafeMinimum :: (Ord a, Foldable f) => f a -> a
unsafeMinimum = Data.Foldable.minimum
{-# WARNING unsafeMinimum "Partial functions should be avoided"#-}


{-|
Sum of the numbers of a structure
-}
sum :: (Num a, Foldable f) => f a -> a
sum = Data.Foldable.sum


{-|
Product of the numbers of a structure
-}
product :: (Num a, Foldable f) => f a -> a
product = Data.Foldable.product


{-|
Given some predicate, 'findBy' will return
the first element that matches the predicate
or 'Nothing' if there is no such element
-}
findBy :: (Foldable f) => (a -> Bool) -> f a -> Maybe a
findBy = Data.Foldable.find


{-|
Determines if any element satisfies the predicate

>>> any (== 1) [1, 2, 3]
True
>>> any (== 5) [1, 2, 3]
False
-}
any :: (Foldable f) => (a -> Bool) -> f a -> Bool
any = Data.Foldable.any


{-|
Determines if all elements satisfy the predicate

>>> all (== 1) [1, 2, 3]
False
>>> all (< 5) [1, 2, 3]
True
-}
all :: (Foldable f) => (a -> Bool) -> f a -> Bool
all = Data.Foldable.all


-- ** Acting on Foldables
{-|
Sometimes we need to apply an action to each one of
the elements. The function 'discardTraverse' maps an
action over each of the elements of the structure

>>> discardTraverse printLine ["Hello", "world", "!"]
Hello
world
!
-}
discardTraverse :: (Foldable f, Applicative m) => (a -> m b) -> f a -> m ()
discardTraverse = Data.Foldable.traverse_


-- *** foreach
{-|
Another alternative to 'discardTraverse' is to use the
'foreach' function, which is very familiar to a lot
of developers.

>>> foreach [1..3] printShow
1
2
3
-}
foreach :: (Foldable f, Applicative m) => f a -> (a -> m b) -> m ()
foreach = Data.Foldable.for_

