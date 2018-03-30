{-|
The Either type represents values with two possibilities: a value of type Either a b is either Left a or Right b.

The Either type is sometimes used to represent a value which is either correct or an error; by convention, the Left constructor is used to hold an error value and the Right constructor is used to hold a correct value (mnemonic: "right" also means "correct").
-}
module Eta.Types.Either
  ( Either(..)
  , lefts
  , rights
  , isLeft
  , isRight
  , partitionEithers
  , module Eta.Types.Either
  )
where

import Data.Either

{-|
Return the contents of a Left or a default value

>>> Left 4 `fromLeftOrElse` 0
4
>>> Right 4 `fromLeftOrElse` 0
0
-}
fromLeftOrElse :: Either a b -> a -> a
fromLeftOrElse (Left x) _ = x
fromLeftOrElse _ x = x

{-|
Return the contents of a Right or a default value

>>> Right 4 `fromRightOrElse` 0
4
>>> Left 4 `fromRightOrElse` 0
0
-}
fromRightOrElse :: Either a b -> b -> b
fromRightOrElse (Right x) _ = x
fromRightOrElse _ x = x


{-|
Handler for the 'Either' type
Takes two functions and an 'Either'.

If the value is a 'Left a' apply the first function to 'a'.
If the value is a 'Right b' apply the first function to 'b'.
-}
handleEither :: (a -> c) -> (b -> c) -> Either a b -> c
handleEither = either

