{-|
The 'Monad' type class defines that a type
can have an 'flatMap' operation which can be used
to sequence actions over the same type.

All types that implement 'Monad' must implement
'Applicative'.

The List, 'Maybe', and 'IO' types are examples of
instances of 'Monad'.

>>> flatMap (\x -> [1 .. x]) [1, 2, 3]
[1,1,2,1,2,3]

/Mnemonic: Sequenceable/
-}
module Eta.Classes.Monad
  (Monad((>>=))
  , flatMap
  , (|>>)
  , (<<|)
  {-|
  Creates a new function that can be flatmapped by
  composing two functions:

  @
  >> readAndPrint = readFile >=> printLine
  >> readAndPrint "data.txt"
  "This is some data stored in data.txt"
  @

  /Sometimes referred as Kleisli composition/
  -}
  , (>=>)

  {-|
  Inverted '(>=>)'
  -}
  , (<=<)

  {-|
  Executes a monadic action forever:

  @
  print "Hi" |> forever
  @
  -}
  , Control.Monad.forever
  )
where

import Control.Monad (Monad((>>=)), (>=>), (<=<))
import qualified Control.Monad


flatMap :: (Monad m) => (a -> m b) -> m a -> m b
flatMap = (Control.Monad.=<<)

-- *** Flatmap forward
{-|
Flatmaps the function of the right over the Monad of the left

@
>> readFile "data.txt" |>> printLine
"This is some data stored in data.txt"
@
-}
(|>>) :: (Monad m) => m a -> (a -> m b) -> m b
(|>>) = (Control.Monad.>>=)


-- *** Flatmap backwards
{-|
Flatmaps the function of the left over the Monad of the left

@
>> printLine <<| readFile "data.txt"
"This is some data stored in data.txt"
@
-}
(<<|) :: (Monad m) => (a -> m b) -> m a -> m b
(<<|) = (Control.Monad.=<<)

