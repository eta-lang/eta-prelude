{-|
The 'Maybe' type encapsulates an __optional__
value.

It either contains a value, represented by 'Just' @a@,
or not, represented by 'Nothing'.
-}
module Eta.Types.Maybe
  ( Maybe(..)
  , isJust
  -- | Returns 'True' if the Maybe is a Just
  , isNothing
  -- | Returns 'True' if the Maybe is a Nothing
  , module Eta.Types.Maybe
  )
where

import Data.Maybe
import Eta.Classes.Monoid ((<+>))
import Eta.Classes.Show

{-|
Extracts the element out of a 'Just'.
Throws an error if it is 'Nothing'

>>> unsafeGetValue (Just 1)
1
-}
unsafeGetValue :: Maybe a -> a
unsafeGetValue = fromJust
{-# WARNING unsafeGetValue "Partial functions should be avoided." #-}


{-|
Takes a default value and a
'Maybe' value. If the Maybe is 'Nothing',
it returns the default value, returns the
contents of the Maybe

>>> x = Just "Something"
>>> x `getOrElse` "Nothing found!"
"Something"

>>> y = Nothing
>>> y `getOrElse` "Nothing found!"
"Nothing found!"
-}
getOrElse :: Maybe a -> a -> a
getOrElse x def = handleMaybe def (\x -> x) x

{-|
Handler for the 'Maybe' type
Takes a default value, a function and a
'Maybe' value. If the Maybe is 'Nothing',
it returns the default value, otherwise,
it maps the function and returns the
result

>>> myMaybe = Just 42
>>> handleMaybe "Nothing found" (\x -> "Got: " <+> show x) myMaybe
"Got: 42"

>>> myMaybe' = Nothing
>>> handleMaybe "Nothing found" (\x -> "Got: " <+> show x) myMaybe'
"Nothing found"
-}
handleMaybe :: b -> (a -> b) -> Maybe a -> b
handleMaybe = maybe


{-|
Discards all 'Nothing's from the list,
returning all values

>>> onlyJustValues [Just 1, Nothing, Just 2]
[1,2]
-}
onlyJustValues :: [Maybe a] -> [a]
onlyJustValues = catMaybes

