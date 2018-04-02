-- | * String operations
module Eta.Types.String
  ( String
  {-|
  Breaks a 'String' into a @[String]@ at newline 'Char's

  >>> lines "Hello\nI'm Joe"
  ["Hello","I'm Joe"]
  -}
  , lines
  {-|
  Joins a @[String]@ appending a newline to each element

  >>> unlines ["Hello", "I'm Joe"]
  "Hello\nI'm Joe\n"
  -}
  , unlines
  {-|
  Splits a 'String' into a @[String]@ at 'Char's representing
  white spaces.

  >>> words "How are you"
  ["How","are","you"]
  -}
  , words
  {-|
  Joins a @[String]@ appending a space to each element

  >>> unwords ["How", "are", "you"]
  "How are you"
  -}
  , unwords
  )
where

import Data.String

