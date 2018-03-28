-- | The Eta Prelude
module Eta where

import qualified Prelude
import qualified Data.Monoid
import Data.Monoid as Export (Monoid, (<>))
import Prelude as Export
  ( Functor
  , Applicative
  , Monad
  , Foldable
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
  + 2 \<| 1    -- => 3
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
  map (+1) [1, 2, 3]    -- => [2, 3, 4]
@

/Mnemonic: Mappable/
-}
map :: (Functor f) => (a -> b) -> f a -> f b
map = Prelude.fmap


-- *** Map forward
{-|
Maps the function of the right to the Functor of the left:

@
  [1, 2, 3] |$> (+ 1)     -- => [2, 3, 4]
@
-}
(|$>) :: (Functor f) => f a -> (a -> b) -> f b
(|$>) = flip map


-- *** Map backwards
{-|
Maps the function of the left to the Functor of the right:

@
  (+1) \<$| [1, 2, 3]     -- => [2, 3, 4]
@
-}
(<$|) :: (Functor f) => (a -> b) -> f a -> f b
(<$|) = map




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
  apply (Just (+1)) (Just 2)    -- => Just 3
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
  Just 1 |*> Just (+2)   -- => Just 3
@
-}
(|*>) :: (Applicative f) => f a -> f (a -> b) -> f b
(|*>) = flip (Prelude.<*>)


-- *** Apply backwards
{-|
Applies the function contained in the Applicative of the left
to the Applicative which contains a value of the right:

@
  Just (+ 1) \<*| Just 2   -- => Just 3
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
  flatMap (\x -> [1 .. x]) [1, 2, 3]    -- => [1,1,2,1,2,3]
@

/Mnemonic: Sequenceable/
-}
flatMap :: (Monad m) => (a -> m b) -> m a -> m b
flatMap = (Prelude.=<<)

-- *** Flatmap forward
{-|
Flatmaps the function of the right over the Monad of the left

@
  readFile "data.txt" |>> putStrLn
@
-}
(|>>) :: (Monad m) => m a -> (a -> m b) -> m b
(|>>) = (Prelude.>>=)


-- *** Flatmap backwards
{-|
Flatmaps the function of the left over the Monad of the left

@
  putStrLn <<| readFile "data.txt"
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
  append "Hello " "world!"    -- => "Hello world!"
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

  foo    -- => ""
  bar    -- => []
@
-}
neutral :: (Monoid a) => a
neutral = Data.Monoid.mempty


-- *** Monoid reduction
{-|
You can reduce a list of elements that implement the
'Monoid' type class by using 'concat'

@
  concat ["Hello ", "world ", "!"]    -- => "Hello world!"
@

-}
concat :: (Monoid a) => [a] -> a
concat = Data.Monoid.mconcat


-- *** Append operator
{-|
Operator for the 'append' operation

@
  "Hello " \<+> "world!"    -- => "Hello world!"
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
  foldRight (+) 0 [1, 2, 3]    -- => 6
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
strictFoldLeft :: (Foldable f) => (b -> a -> b) -> b -> f a -> b
strictFoldLeft = Prelude.foldl


-- *** strictFoldLeft
{-|
A version of 'foldLeft' that evaluates the operations inline,
hence /strict/, the opposite of lazy.
-}
strictFoldLeft :: (Foldable f) => (b -> a -> b) -> b -> f a -> b
strictFoldLeft = Prelude.foldl


-- *** foldMap
{-|
'foldMap' is an operation that first converts all the elements
into a 'Monoid' and then 'foldRight's them using the `append` and
`neutral` functions.

@
  -- Converts all the elements to Strings and then folds them
  foldMap show [1, 2, 3]    -- => "123"
@

This is the same as doing

@
  [1, 2, 3]
    |> map show
    |> foldRight append neutral
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


-- TODO: Check totallity
-- *** maximum
{-|
Largest element in a structure
-}
maximum :: (Ord a, Foldable f) => f a -> a
maximum = Data.Foldable.maximum


-- TODO: Check totallity
-- *** minimum
{-|
Smallest element in a structure
-}
minimum :: (Ord a, Foldable f) => f a -> a
minimum = Data.Foldable.minimum


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





-- *** Monadic map
{-|
A variant of 'map' that accepts a flatmappable function,
like in monads.

An example is to read all the files from some file names
that are stored in a list.

@
  readFiles :: [FilePath] -> IO [String]
  readFiles fileNames = monadicMap readFile fileNames
@

Note how @ readFile :: FilePath -> IO String @ is typed.

'monadicMap' takes all the 'IO's and puts only one outside
of the list in this case.
-}
-- monadicMap :: (Monad m) => (a -> m b) -> f a -> m (f b)
-- monadicMap = Prelude.mapM


