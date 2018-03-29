-- | The Eta Prelude
module Eta
  ( module Eta
  , module Export
  )
where

import qualified Prelude
import qualified Data.Monoid
import qualified Data.Functor
import qualified Data.Foldable
import qualified Data.Traversable
import qualified Text.Read
import Data.Monoid as Export (Monoid, (<>))
import Data.Functor as Export (Functor, fmap)
import Prelude as Export
  ( Functor
  , Applicative
  , Monad
  , Foldable
  , Traversable
  , Eq
  , Ord
  , Show
  , Read

  , Num
  , Bool
  , Int
  , String
  , IO

  , Maybe(..)
  , Ordering(..)
  , flip
  )

import Eta.Prelude.PipeOperators as Export


-- * Concepts

-- ** Functor


-- ** Applicative
{-|
The 'Applicative' type class defines that a type
can have an 'apply' operation which can be used
to apply a function contained in the 'Applicative'
to the elements of Another.

All types that implement 'Applicative' must implement
'Functor'.

The 'Maybe' type is an example of
an instance of 'Applicative'.

@
  >>> apply (Just (+1)) (Just 2)
  Just 3
@

/Mnemonic: Applyable/
-}
apply :: (Applicative f) => f (a -> b) -> f a -> f b
apply = (Prelude.<*>)

-- *** Apply forward
{-|
Applies the function contained in the Applicative of the right
to the Applicative which contains a value of the left:

@
  >>> Just 1 |*> Just (+2)
  Just 3
@
-}
(|*>) :: (Applicative f) => f a -> f (a -> b) -> f b
(|*>) = flip (Prelude.<*>)


-- *** Apply backwards
{-|
Applies the function contained in the Applicative of the left
to the Applicative which contains a value of the right:

@
  >>> Just (+ 1) \<*| Just 2
  Just 3
@
-}
(<*|) :: (Applicative f) => f (a -> b) -> f a -> f b
(<*|) = (Prelude.<*>)





-- ** Monad
{-|
The 'Monad' type class defines that a type
can have an 'flatMap' operation which can be used
to sequence actions over the same type.

All types that implement 'Monad' must implement
'Applicative'.

The List, 'Maybe', and 'IO' types are examples of
instances of 'Monad'.

@
  >>> flatMap (\x -> [1 .. x]) [1, 2, 3]
  [1,1,2,1,2,3]
@

/Mnemonic: Sequenceable/
-}
flatMap :: (Monad m) => (a -> m b) -> m a -> m b
flatMap = (Prelude.=<<)

-- *** Flatmap forward
{-|
Flatmaps the function of the right over the Monad of the left

@
  >>> readFile "data.txt" |>> printLine
  "This is some data stored in data.txt"
@
-}
(|>>) :: (Monad m) => m a -> (a -> m b) -> m b
(|>>) = (Prelude.>>=)


-- *** Flatmap backwards
{-|
Flatmaps the function of the left over the Monad of the left

@
  >>> printLine <<| readFile "data.txt"
  "This is some data stored in data.txt"
@
-}
(<<|) :: (Monad m) => (a -> m b) -> m a -> m b
(<<|) = (Prelude.=<<)







-- ** Foldable
{-|
The 'Foldable' type class defines that a type
can have a 'foldRight' operation which can be used
to reduce it by passing a binary operation and a
neutral element. This reduces starting from the right.

The List type is an example of 'Foldable'

@
  >>> foldRight (+) 0 [1, 2, 3]
  6
@

/Mnemonic: Reduceable/
-}
foldRight :: (Foldable f) => (a -> b -> b) -> b -> f a -> b
foldRight = Prelude.foldr


{-|
'foldLeft' starts from the left, using the lazy evaluation
capabilities of Eta. Note that this will get stuck in an
infite loop if you pass an infite list to it.
-}
foldLeft :: (Foldable f) => (b -> a -> b) -> b -> f a -> b
foldLeft = Prelude.foldl


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

@
  >>> addIntoMaybe :: Int -> Int -> Maybe Int
  >>> addIntoMaybe a b = Just (a + b)

  >>> monadicFoldRight addIntoMaybe 0 [1,2,3]
  Just 6
@

-}
monadicFoldRight :: (Foldable f, Monad m) => (a -> b -> m b) -> b -> f a -> m b
monadicFoldRight = Data.Foldable.foldrM


{-|
Left-biased version of 'monadicFoldRight'
-}
monadicFoldLeft :: (Foldable f, Monad m) => (b -> a -> m b) -> b -> f a -> m b
monadicFoldLeft = Data.Foldable.foldlM


-- *** foldMap
{-|
'foldMap' is an operation that first converts all the elements
into a 'Monoid' and then 'foldRight's them using the `append` and
`neutral` functions.

@
  -- Converts all the elements to Strings and then folds them
  >>> foldMap show [1, 2, 3]
  "123"
@

This is the same as doing

@
  >>> [1, 2, 3]
  >>>   |> map show
  >>>   |> foldRight append neutral
  "123"
@
-}
foldMap :: (Foldable f, Monoid m) => (a -> m) -> f a -> m
foldMap = Prelude.foldMap


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
{-# WARNING unsafeMaximum "unsafeMaximum detected: Partial functions should be avoided"#-}

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
{-# WARNING unsafeMinimum "unsafeMinimum detected: Partial functions should be avoided"#-}


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

@
  >>> any (== 1) [1, 2, 3]
  True
  >>> any (== 5) [1, 2, 3]
  False
@
-}
any :: (Foldable f) => (a -> Bool) -> f a -> Bool
any = Data.Foldable.any


{-|
Determines if all elements satisfy the predicate

@
  >>> all (== 1) [1, 2, 3]
  False
  >>> all (< 5) [1, 2, 3]
  False
@
-}
all :: (Foldable f) => (a -> Bool) -> f a -> Bool
all = Data.Foldable.all


-- ** Acting on Foldables
{-|
Sometimes we need to apply an action to each one of
the elements. The function 'discardTraverse' maps an
action over each of the elements of the structure

@
  >>> discardTraverse printLine [\"Hello", "world", "!"]
  Hello
  world
  !
@
-}
discardTraverse :: (Foldable f, Applicative m) => (a -> m b) -> f a -> m ()
discardTraverse = Data.Foldable.traverse_


-- *** foreach
{-|
Another alternative to 'discardTraverse' is to use the
'foreach' function, which is very familiar to a lot
of developers.

@
  >>> foreach [1..3] $ \i -> do
  >>>   let message = "Got number: " \<+> show i
  >>>   printLine message
  Got number: 1
  Got number: 2
  Got number: 3
@
-}
foreach :: (Foldable f, Applicative m) => f a -> (a -> m b) -> m ()
foreach = Data.Foldable.for_


-- ** Traversable
{-|
The 'Traversable' type class defines that a structure
can be traversed from left to right, applying some
flatmappable function to it.

@
  >>> traverse readFile ["foo.txt", "bar.txt", "quux.txt"]
  ["foo contents" , "bar contents", "quux contents"]
@

It basically applies the actions inside of the type that
the passed returns, and collects them, unless it fails.

@
  >>> safeDivide a b =
  >>>     if b == 0
  >>>     then Nothing
  >>>     else Just (a / b)

  >>> traverse (safeDivide 2) [1, 2]
  Just [2, 1]

  >>> traverse (safeDivide 2) [0, 2]
  Nothing
@
-}
traverse :: (Traversable t, Applicative m) => (a -> m b) -> t a -> m (t b)
traverse = Data.Traversable.traverse


{-|
'traverse' with the arguments flipped, allows to work in an imperative manner,
like with 'foreach':

@
  >>> for [1..3] $ \i -> do
  >>>     let x = i + 1
  >>>     Just x
  Just [2, 3, 4]
@

-}
for :: (Traversable t, Applicative m) => t a -> (a -> m b) -> m (t b)
for = Data.Traversable.for


{-|
'sequence' moves the context of each of the elements of
a 'Traversable' structure to the structure itself

@
  >>> sequence [Just 1, Just 2]
  Just [1, 2]

  >>> sequence [Just 1, Nothing]
  Nothing
@
-}
sequence :: (Traversable t, Applicative m) => t (m a) -> m (t a)
sequence = Data.Traversable.sequenceA

-- * String manipulation
-- ** Basic (de)serializing
--- *** Show
{-|
The 'Show' type class denotes that a type
can be converted to a 'String', like the
'toString' method from Java.
-}
show :: (Show a) => a -> String
show = Prelude.show

--- *** Read
{-|
The 'Read' type class denotes that a type
can be converted from a 'String'.

This is useful when in need of some basic
deserialization:

@
  >>> read "1" :: Int
  Just 1

  >>> read "hotdog" :: Int
  Nothing
@
-}
read :: (Read a) => String -> Maybe a
read = Text.Read.readMaybe


{-|
'read's a 'String', but instead of returning
'Nothing' on parse error, it fails.
-}
unsafeRead :: (Read a) => String -> a
read = Prelude.read
{-# WARNING unsafeRead "unsafeRead detected: Partial functions should be avoided"#-}

-- ** String operations
{-|
Breaks a 'String' into a '[String]' at newline 'Char's

@
  >>> lines \"Hello\\nI'm Joe"
  ["Hello", "I'm Joe"]
@
-}
lines :: String -> [String]
lines = Prelude.lines

{-|
Joins a '[String]' appending a newline to each element

@
  >>> unlines [\"Hello", "I'm Joe"]
  "Hello\\nI'm Joe"
@
-}
unlines :: [String] -> String
unlines = Prelude.unlines


{-|
Splits a 'String' into a '[String]' at 'Char's representing
white spaces.

@
  >>> words "How are you"
  ["How", "are", "you"]
@
-}
words :: String -> [String]
words = Prelude.words


{-|
Joins a '[String]' appending a space to each element

@
  >>> unwords ["How", "are", "you"]
  "How are you"
@
-}
unwords :: [String] -> String
unwords = Prelude.unwords



