module Eta.Classes.MonadTrans
  ( {-|
A Monad Transformer is a typeclass that
allows to execute functions of one Monad
inside of another by providing a 'lift'
operation:

@
wontWork :: Maybe (IO Int)
wontWork = do
  someString <- getLine    -- Compile error: getLine returns an IO action, not Maybe
  if someString == ""
     then Nothing
     else length someString |> Just


ok :: MaybeT IO Int
ok = do
  someString <- lift getLine
  if someString == ""
     then Nothing
     else length someString |> Just
@

There are quite a lot of transformers available:

* ExceptT
* IdentityT
* MaybeT
* ReaderT
* StateT
* WriterT
-}
    module Control.Monad.Trans.Class
  , module Exported
  )
where

import Control.Monad.Trans.Class

import Control.Monad.Trans.Except as Exported hiding (liftCallCC, liftListen, liftPass, liftCatch)
import Control.Monad.Trans.Identity as Exported hiding (liftCallCC, liftListen, liftPass, liftCatch)
import Control.Monad.Trans.Maybe as Exported hiding (liftCallCC, liftListen, liftPass, liftCatch)
import Control.Monad.Trans.Reader as Exported hiding (liftCallCC, liftListen, liftPass, liftCatch)
import Control.Monad.Trans.State as Exported hiding (liftCallCC, liftListen, liftPass, liftCatch)
import Control.Monad.Trans.Writer as Exported hiding (liftCallCC, liftListen, liftPass, liftCatch)
