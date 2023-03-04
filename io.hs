-- io.hs  UNFINISHED
-- Glenn G. Chappell
-- 2023-03-03
--
-- For CS 331 Spring 2023
-- Code from 3/3 - Haskell: I/O

module Main where

import System.IO  -- for hFlush, stdout


main = do
    putStrLn ""
    putStrLn "This file contains sample code from March 3,"
    putStrLn "2023, for the topic \"Haskell: I/O\"."
    putStrLn "It will execute, but it is not intended to do anything"
    putStrLn "useful. See the source."
    putStrLn ""


-- ***** String Conversion *****


-- Function "show" converts anything showable (type must be in class
-- Show) to a String.

-- numConcat
-- Returns string containing 2 params separated by blank.
-- So (numConcat 42 7) returns "42 7".
numConcat a b = (show a) ++ " " ++ (show b)

-- Try:
--   numConcat 42 7


-- Function "read" converts a string to anything (type must be in class
-- Read).

-- Try:
--   read "42"
-- Result is error; need to force return type.


stringPlusOne str = 1 + read str

stringToInteger str = (read str)::Integer

-- Try:
--   stringPlusOne "42"
--   stringToInteger "42"


-- ***** Simple Output *****


-- An I/O action is type of value. We do I/O by returning an I/O action
-- to the outside world.

sayHowdy = putStr "Howdy!"

sayHowdyNewLine = putStrLn "Howdy!"

-- Use ">>" to join I/O actions together into a single I/O action

sayHowdyAgain = putStr "Howdy " >> putStrLn "thar!"

sayHowdy2Line = putStrLn "Howdy" >> putStrLn "thar!"

-- Try:
--   sayHowdy
--   sayHowdyNewLine
--   sayHowdyAgain
--   sayHowdy2Line

secondsInADay = 60*60*24

printSec = putStr "There are " >> putStr (show secondsInADay)
           >> putStrLn " seconds in a day."

f1 = putStr "There are "
f2 = putStr (show secondsInADay)
f3 = putStrLn " seconds in a day -- or so they say."
printSec' = f1 >> f2 >> f3

-- Try:
--   printSec
--   printSec'


-- ***** Simple Input *****


-- An I/O action wraps a value. The above I/O actions all wrapped
-- "nothing" values. getLine returns an I/O action that wraps the String
-- that is input.

-- Send the wrapped value to a function with ">>="

getPrint =    getLine >>= putStrLn
getPrint' =   getLine >>= (\ line -> putStrLn line)
getPrintRev = getLine >>= (\ line -> putStrLn (reverse line))

-- The wrapped value cannot be removed from the I/O action, but it can
-- be processed inside it (e.g., the above call to function reverse).

-- Try-:
--   getPrint
--   getPrint'
--   getPrintRev


-- ####################  MORE TO COME!  ####################

