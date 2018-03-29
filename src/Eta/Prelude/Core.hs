module Eta.Prelude.Core
  ( module Eta.Prelude.Core
  , module Exported
  )
where

import Eta.Prelude.Classes

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
Takes a default value and a
'Maybe' value. If the Maybe is 'Nothing',
it returns the default value, returns the
contents of the Maybe
>>> let x = Just "Something"
>>> x `getOrElse` "Nothing found!"
"Something"

>>> let y = Nothing
>>> y `getOrElse` "Nothing found!"
"Nothing found!"
-}
getOrElse :: Maybe a -> a -> a
getOrElse x def = handleMaybe def identity x

{-|
Handler for the 'Maybe' type
Takes a default value, a function and a
'Maybe' value. If the Maybe is 'Nothing',
it returns the default value, otherwise,
it maps the function and returns the
result

>>> let myMaybe = Just 42
>>> handleMaybe "Nothing found" (\x -> "Got: " <+> show x) myMaybe
"Got: 42"

>>> let myMaybe' = Nothing
>>> handleMaybe "Nothing found" (\x -> "Got: " <+> show x) myMaybe'
"Nothing found"
-}
handleMaybe :: b -> (a -> b) -> Maybe a -> b
handleMaybe = Prelude.maybe

{-|
Handler for the 'Either' type
Takes two functions and an 'Either'.

If the value is a 'Left a' apply the first function to 'a'.
If the value is a 'Right b' apply the first function to 'b'.
-}
handleEither :: (a -> c) -> (b -> c) -> Either a b -> c
handleEither = Prelude.either

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

-- ** Boolean
{-|
Boolean not

>>> not True
False
-}
not :: Bool -> Bool
not = Prelude.not


{-|
'otherwise' is defined as 'True'.

Used for guards:
>>> :{
 factorial n
  | n == 0      = 1
  | otherwise   = n * factorial (n - 1)
:}

>>> factorial 3
6
-}
otherwise :: Bool
otherwise  = Prelude.otherwise


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
