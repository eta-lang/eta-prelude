-- | * __STUFF HERE IS WORK IN PROGRESS, IGNORE THIS MODULE__
module Eta
  ( module Eta
  , module Export
  )
where

import qualified Prelude
import qualified Data.Monoid
import qualified Data.Functor
import qualified Data.Foldable
import qualified Data.Traversable
import qualified Text.Read
import Data.Monoid as Export (Monoid, (<>))
import Data.Functor as Export (Functor, fmap)
import Prelude as Export
  ( Functor
  , Applicative
  , Monad
  , Foldable
  , Traversable
  , Eq
  , Ord
  , Show
  , Read

  , Num
  , Bool
  , Int
  , String
  , IO

  , Maybe(..)
  , Ordering(..)
  , flip
  )
