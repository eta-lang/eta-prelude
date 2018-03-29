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
import Data.Monoid as Export (Monoid, (<>))
import Data.Functor as Export (Functor, fmap)
import Prelude as Export
  ( Functor
  , Applicative
  , Monad
  , Foldable
  , Eq
  , Ord
  , Num
  , Bool
  , Int
  , Maybe(..)
  , Ordering(..)
  , flip
  )


-- * Concepts

-- ** Pipe operators
{-|
Functions can be applied using the pipe operators,
reducing parentheses and increasing the code readability.

Instead of writing

@
  (putStrLn (join ", " (sort names)))
@

Use the pipe operators:

@
  names
    |> sort
    |> join ", "
    |> putStrLn
@
-}
(|>) :: a -> (a -> b) -> b
(|>) = flip (Prelude.$)


-- *** Pipe backwards
{-|
Applies the function of the left to the value of the right.

@
  >>> + 2 \<| 1
  3
@
-}
(<|) :: (a -> b) -> a -> b
(<|) = (Prelude.$)





-- ** Functor
{-|
The 'Functor' type class defines that a type
can have a 'map' operation which can be used
to map a function over the elements of it.

The list and the 'Maybe' types are examples of
instances of 'Functor'.

@
  >>> map (+1) [1, 2, 3]
  [2, 3, 4]
@

/Mnemonic: Mappable/
-}
map :: (Functor f) => (a -> b) -> f a -> f b
map = Prelude.fmap


-- *** Map forward
{-|
Maps the function of the right to the Functor of the left:

@
  >>> [1, 2, 3] |$> (+ 1)
  [2, 3, 4]
@
-}
(|$>) :: (Functor f) => f a -> (a -> b) -> f b
(|$>) = flip map


-- *** Map backwards
{-|
Maps the function of the left to the Functor of the right:

@
  >>> (+1) \<$| [1, 2, 3]
  [2, 3, 4]
@
-}
(<$|) :: (Functor f) => (a -> b) -> f a -> f b
(<$|) = map


-- *** Discard
{-|
Discards the value inside of the functor.

@
  >>> discard [1, 2, 3]
  [(), (), ()]
@
-}
discard :: (Functor f) => f a -> f ()
discard = Data.Functor.void



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
  >>> readFile "data.txt" |>> putStrLn
  "This is some data stored in data.txt"
@
-}
(|>>) :: (Monad m) => m a -> (a -> m b) -> m b
(|>>) = (Prelude.>>=)


-- *** Flatmap backwards
{-|
Flatmaps the function of the left over the Monad of the left

@
  >>> putStrLn <<| readFile "data.txt"
  "This is some data stored in data.txt"
@
-}
(<<|) :: (Monad m) => (a -> m b) -> m a -> m b
(<<|) = (Prelude.=<<)


-- ** Monoid
{-|
The 'Monoid' type class defines that a type
can have an 'append' operation which can be used
to append two things of the same type

The List, and String types are examples of
instances of 'Monoid'.

@
  >>> append "Hello " "world!"
  "Hello world!"
@

/Mnemonic: Appendable/
-}
append :: (Monoid a) => a -> a -> a
append = Data.Monoid.mappend


-- *** Monoid neutral element
{-|
A 'Monoid' also requires that the type has a neutral
element that does not affect concatenation.

@
  foo :: String
  foo = neutral

  bar :: [Int]
  bar = neutral

  >>> foo
  ""

  >>> bar
  []
@
-}
neutral :: (Monoid a) => a
neutral = Data.Monoid.mempty


-- *** Monoid reduction
{-|
You can reduce a list of elements that implement the
'Monoid' type class by using 'concat'

@
  >>> concat ["Hello ", "world ", "!"]
  "Hello world!"
@

-}
concat :: (Monoid a) => [a] -> a
concat = Data.Monoid.mconcat


-- *** Append operator
{-|
Operator for the 'append' operation

@
  >>> "Hello " \<+> "world!"
  "Hello world!"
@
-}
(<+>) :: (Monoid a) => a -> a -> a
(<+>) = (Data.Monoid.<>)






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


-- *** foldLeft
{-|
'foldLeft' starts from the left, using the lazy evaluation
capabilities of Eta. Note that this will get stuck in an
infite loop if you pass an infite list to it.
-}
foldLeft :: (Foldable f) => (b -> a -> b) -> b -> f a -> b
foldLeft = Prelude.foldl


-- *** strictFoldRight
{-|
A version of 'foldRight' that evaluates the operations inline,
hence /strict/, the opposite of lazy.
-}
strictFoldRight :: (Foldable f) => (a -> b -> b) -> b -> f a -> b
strictFoldRight = Data.Foldable.foldr'


-- *** strictFoldLeft
{-|
A version of 'foldLeft' that evaluates the operations inline,
hence /strict/, the opposite of lazy.
-}
strictFoldLeft :: (Foldable f) => (b -> a -> b) -> b -> f a -> b
strictFoldLeft = Data.Foldable.foldl'


-- *** monadicFoldRight
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


-- *** monadicFoldLeft
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


-- *** toList
{-|
Converts a type that implements 'Foldable' into a list
-}
toList :: (Foldable f) => f a -> [a]
toList = Data.Foldable.toList


-- *** isEmpty
{-|
Checks if a 'Foldable' structure is empty.
-}
isEmpty :: (Foldable f) => f a -> Bool
isEmpty = Data.Foldable.null


-- *** length
{-|
Returns the size of a structure.
-}
length :: (Foldable f) => f a -> Int
length = Data.Foldable.length


-- *** isElementOf
{-|
Checks if the element is contained in the structure.
-}
isElementOf :: (Eq a, Foldable f) => a -> f a -> Bool
isElementOf = Data.Foldable.elem


-- *** maximum
{-|
Largest element in a structure.
Returns 'Nothing' if the structure is empty.
-}
maximum :: (Ord a, Foldable f) => f a -> Maybe a
maximum x =
  if isEmpty x
  then Nothing
  else Just (unsafeMaximum x)


-- *** maximumBy
{-|
Given some comparison function, return the maximum of a
structure. Returns 'Nothing' if the structure is empty.
-}
maximumBy :: (Foldable f) => (a -> a -> Ordering) -> f a -> Maybe a
maximumBy pred x =
  if isEmpty x
  then Nothing
  else Just (Data.Foldable.maximumBy pred x)


-- *** unsafeMaximum
{-|
Largest element in a structure.
Errors if the structure is empty
-}
unsafeMaximum :: (Ord a, Foldable f) => f a -> a
unsafeMaximum = Data.Foldable.maximum


-- *** minimum
{-|
Smallest element in a structure
Returns 'Nothing' if the structure is empty.
-}
minimum :: (Ord a, Foldable f) => f a -> Maybe a
minimum x =
  if isEmpty x
  then Nothing
  else Just (unsafeMinimum x)


-- *** minimumBy
{-|
Given some comparison function, return the minimum of a
structure. Returns 'Nothing' if the structure is empty.
-}
minimumBy :: (Foldable f) => (a -> a -> Ordering) -> f a -> Maybe a
minimumBy pred x =
  if isEmpty x
  then Nothing
  else Just (Data.Foldable.minimumBy pred x)


-- *** unsafeMinimum
{-|
Largest element in a structure.
Errors if the structure is empty
-}
unsafeMinimum :: (Ord a, Foldable f) => f a -> a
unsafeMinimum = Data.Foldable.minimum


-- *** sum
{-|
Sum of the numbers of a structure
-}
sum :: (Num a, Foldable f) => f a -> a
sum = Data.Foldable.sum


-- *** product
{-|
Product of the numbers of a structure
-}
product :: (Num a, Foldable f) => f a -> a
product = Data.Foldable.product


-- *** findBy
{-|
Given some predicate, 'findBy' will return
the first element that matches the predicate
or 'Nothing' if there is no such element
-}
findBy :: (Foldable f) => (a -> Bool) -> f a -> Maybe a
findBy = Data.Foldable.find


-- *** any
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


-- *** all
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
  >>> discardTraverse putStrLn ["Hello", "world", "!"]
  Hello
  world
  !
@
-}
discardTraverse :: (Foldable f, Applicative m) => (a -> m b) -> f a -> m ()
discardTraverse = Data.Foldable.traverse_


-- *** foreach
{-|
Another alternative to 'mapAction' is to use the
'foreach' function, which is very familiar to a lot
of developers.

@
  >>> foreach [1..3] $ \i -> do
  >>>   let message = "Got number: " <+> show i
  >>>   putStrLn message
  Got number: 1
  Got number: 2
  Got number: 3
@
-}
foreach :: (Foldable f, Applicative m) => f a -> (a -> m b) -> m ()
foreach = Data.Foldable.for_


-- ** Traversable
{-|
-}
