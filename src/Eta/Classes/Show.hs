{-|
The 'Show' type class defines an interface with a
method 'show' that allows converting a value into
a 'String'
-}
module Eta.Classes.Show
  ( module Exported
    -- $show
  , show
  )
where

import qualified Prelude
import Prelude (show)
import Prelude as Exported
  ( Show
  , showsPrec
  , showList
  )

-- $show
-- Converts a value into a 'String'
--
-- >>> show 1
-- "1"
