{-|
The 'Real' type class defines how to convert
a numerical value into a full precision 'Rational'
value
-}
module Eta.Classes.Real
  ( module Eta.Classes.Real
  , module Exported
  , toRational
  -- | The rational equivalent of its argument
  )
where

import Prelude (toRational)
import Prelude as Exported
  ( Real
  )

