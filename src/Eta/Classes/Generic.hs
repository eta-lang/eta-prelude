module Eta.Classes.Generic
  (
    {-|
The 'Generic' type class is used with the @deriving@
keyword. It is used generally for stuff like automatic
instantiation of classes like JSON serializers from
@Data.Aeson@.
-}
    Generic(..)
  )
where

import GHC.Generics


