{-|
A value of type IO a is a computation which, when performed, does some I/O before returning a value of type a.

There is really only one way to "perform" an I/O action: bind it to Main.main in your program. When your program is run, the I/O will be performed. It isn't possible to perform I/O from an arbitrary function, unless that function is itself in the IO monad and called at some point, directly or indirectly, from Main.main.

IO implements 'Monad', so IO actions can be combined using either the do-notation or |>> operation from the Monad class.
-}
module Eta.Types.IO
  ( IO
  , print
  , printLine
  , printShow
  , getArgs
  )
where

import Prelude (IO, String, Show)
import qualified Prelude
import qualified System.Environment

-- ** IO operations
{-|
Print a 'String' on screen
-}
print :: String -> IO ()
print = Prelude.putStr

{-|
Print a 'String' on screen, followed by a newline.
-}
printLine :: String -> IO ()
printLine = Prelude.putStrLn

{-|
Converts the value to a 'String' using 'show' and
then 'printLine's it.
-}
printShow :: (Show a) => a -> IO ()
printShow = Prelude.print

{-|
Returns the arguments of the program
-}
getArgs :: IO [String]
getArgs = System.Environment.getArgs
