-- | * __STUFF HERE IS WORK IN PROGRESS, IGNORE THIS MODULE__
module Eta.Core
  ( module Eta.Core
  , module Exported
  )
where

import Eta.Classes as Exported

import qualified Prelude
import qualified Control.Arrow
import qualified System.Environment

import Prelude as Exported
  ( Bool(..)
  , Maybe (..)
  , Either (..)

  , String
  , IO
  , Char

  , Num

  , (+)
  , (-)
  , (/)
  , (*)
  , (<)
  , (>)
  , (==)
  )


-- * Operators
-- ** Flow and application
{-|
Pipe operator. Functions can be applied using the pipe operator,
reducing parentheses and increasing the code readability.

Instead of writing

@
  (printLine (join ", " (sort names)))
@

Use the pipe operator:

@
  names
    |> sort
    |> join ", "
    |> printLine
@
-}
(|>) :: a -> (a -> b) -> b
(|>) = flip ($)


{-|
Pipe backwards operator.
Applies the function of the left to the value of the right.

>>> (+ 2) <| 1
3
-}
(<|) :: (a -> b) -> a -> b
(<|) = ($)


{-|
Application operator.
Synonymous to (<|), useful for skipping a level of parentheses.

It can be read as /\"enclose in parentheses from here to the end of the expression."/

>>> (print $ show 4)
4
-}
($) :: (a -> b) -> a -> b
($) = (Prelude.$)


{-|
Forward function composition.

Creates a new function that acts as a "pipe",
passing the arguments to the first one and then
to the second:

>>> addOne x = x + 1
>>> subTwo x = x - 2
>>> subOne = addOne >>> subTwo
>>> subOne 4
3
-}
(>>>) :: (a -> b) -> (b -> c) -> (a -> c)
(>>>) = flip (Prelude..)

{-|
Backwards function composition.

Creates a new function that acts as a "pipe",
passing the arguments to the second one and then
to the first:

>>> addOne x = x + 1
>>> subTwo x = x - 2
>>> subOne = subTwo <<< addOne
>>> subOne 4
3
-}
(<<<) :: (a -> b) -> (b -> c) -> (a -> c)
(<<<) = flip (Prelude..)






-- ** Boolean
{-|
Boolean and

>>> True && True
True
>>> True && False
False
-}
(&&) :: Bool -> Bool -> Bool
(&&) = (Prelude.&&)


{-|
Boolean or

>>> True || True
True
>>> True || False
True
-}
(||) :: Bool -> Bool -> Bool
(||) = (Prelude.||)


-- * Functions
-- ** General functions
{-|
Extract the first component of a pair

>>> first (1, 2)
1
-}
first :: (a, b) -> a
first = Prelude.fst


{-|
Extract the second component of a pair

>>> second (1, 2)
2
-}
second :: (a, b) -> b
second = Prelude.snd


{-|
The identity function,
returns the passed argument as it is

>>> identity 1
1
-}
identity :: a -> a
identity = Prelude.id

{-|
Flips the arguments of a function

>>> subtract a b = a - b
>>> inverseSubtract = flip subtract
>>> subtract 3 2
1
>>> inverseSubtract 3 2
-1
-}
flip :: (a -> b -> c) -> (b -> a -> c)
flip = Prelude.flip

{-|
Constructs a function that returns the same output for
the same input

>>> universe = constantly 42
>>> universe 35
42
>>> map (constantly 10) [1..3]
[10,10,10]
-}
constantly :: a -> b -> a
constantly = Prelude.const

{-|
Stops execution and displays an error message.
-}
-- die :: HasCallStack => String -> a
die = Prelude.error
{-# WARNING die "die detected: Partial functions should be avoided"#-}


{-|
Converts a two argument function in a
function that accepts a pair

>>> addElements = uncurry (+)
>>> addElements (1,2)
3
-}
uncurry :: (a -> b -> c) -> ((a, b) -> c)
uncurry = Prelude.uncurry

{-|
Converts a function that accepts a pair in a
two argument function

>>> firstArgument = curry first
>>> firstArgument 1 2
1
-}
curry :: ((a, b) -> c) -> (a -> b -> c)
curry = Prelude.curry


{-|
Swaps the components of a pair

>>> swap (1,2)
(2,1)
-}
swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)

{-|
A value that can be of any type. The compiler will recognize this
and insert an error message appropriate to the context where it
appears.

/Usually, also called __Bottom__/
-}
undefined = Prelude.undefined

{-|
Returns 'undefined' if 'a' is 'undefined', otherwise returns 'b'

>>> stopIfUndefined 1 2
2
-}
stopIfUndefined :: a -> b -> b
stopIfUndefined = Prelude.seq

-- ** Boolean
{-|
Boolean not

>>> not True
False
-}
not :: Bool -> Bool
not = Prelude.not


-- ** IO operations
{-|
Print a 'String' on screen
-}
print :: String -> IO ()
print = Prelude.putStr

{-|
Print a 'String' on screen, followed by a newline.
-}
printLine :: String -> IO ()
printLine = Prelude.putStrLn

{-|
Converts the value to a 'String' using 'show' and
then 'printLine's it.
-}
printShow :: String -> IO ()
printShow = Prelude.print

{-|
Returns the arguments of the program
-}
getArgs :: IO [String]
getArgs = System.Environment.getArgs
