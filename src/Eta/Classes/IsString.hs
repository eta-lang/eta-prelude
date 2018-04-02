{-|
The type class 'IsString' defines a 'convertString'
method that allows to convert from a regular 'String'
to another type that implements this type class.

It is very useful for using with other string-like types
like 'ByteString' or ByteArray
-}
module Eta.Classes.IsString
  ( module Eta.Classes.IsString
  , IsString(..)
  )
where

import Prelude (String)
import Data.String

{-|
Converts a String into another string-like type.
-}
convertString :: (IsString a) => String -> a
convertString = fromString

