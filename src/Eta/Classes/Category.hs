{-|
The 'Category' type class defines an interface for functions.
You can create your own way of applying functions by instantiating
this type class.

It defines two methods:

* @id@ for defining how does the identity function work
* @.@ for defining how the right-to-left function composition works
-}
module Eta.Classes.Category
  ( Category(..)
  , identity
  , (>>>)
  , (<<<)
  )
where

import Control.Category


{-|
The identity function, returns the parameter as it is

>>> identity 1
1
-}
identity :: (Category function) => function a a
identity = Control.Category.id

