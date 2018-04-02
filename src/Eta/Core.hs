-- | * Eta Core
module Eta.Core where

import Eta.Types.String

import qualified Prelude

-- $setup
-- >>> import Eta.Classes.Num
-- >>> import Eta.Classes.Functor
-- >>> import Eta.Classes.Show
-- >>> import Eta.Types.IO


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
Stops execution and displays an error message.
-}
die :: String -> a
die = Prelude.error
{-# WARNING die "Partial functions should be avoided"#-}


{-|
A value that can be of any type. The compiler will recognize this
and insert an error message appropriate to the context where it
appears.

/Usually, also called __Bottom__/
-}
undefined :: a
undefined = Prelude.undefined
{-# WARNING undefined "Partial functions should be avoided"#-}

{-|
Returns 'undefined' if 'a' is 'undefined', otherwise returns 'b'

>>> stopIfUndefined 1 2
2
-}
stopIfUndefined :: a -> b -> b
stopIfUndefined = Prelude.seq


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

