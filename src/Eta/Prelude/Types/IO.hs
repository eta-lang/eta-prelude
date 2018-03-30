{-|
A value of type IO a is a computation which, when performed, does some I/O before returning a value of type a.

There is really only one way to "perform" an I/O action: bind it to Main.main in your program. When your program is run, the I/O will be performed. It isn't possible to perform I/O from an arbitrary function, unless that function is itself in the IO monad and called at some point, directly or indirectly, from Main.main.

IO implements 'Monad', so IO actions can be combined using either the do-notation or |>> operation from the Monad class.
-}
module Eta.Prelude.Types.IO
  (IO)
where

import Prelude (IO)
