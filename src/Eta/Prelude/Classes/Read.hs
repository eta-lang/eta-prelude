{-|
The 'Read' type class defines an interface with a
method 'read' that allows converting a 'String' into
a value. Think of this as a naive form of deserialization.
-}
module Eta.Prelude.Classes.Read
  ( module Eta.Prelude.Classes.Read
  , module Exported
  )
where

import qualified Prelude
import qualified Text.Read
import Prelude (String, Maybe(..))
import Prelude as Exported
  ( Read
  , readsPrec
  )

{-|
Tries to deserialize a value using the 'Read'
type class. If it fails, returns 'Nothing'

>>> read "1" :: Int
Just 1
>>> read "pizza" :: Int
Nothing
-}
read :: (Read a) => String -> Maybe a
read = Text.Read.readMaybe

{-|
Tries to deserialize a value using the 'Read'
type class. If it fails, it throws an error

>>> unsafeRead "1" :: Int
1
-}
unsafeRead :: (Read a) => String -> a
unsafeRead = Prelude.read

