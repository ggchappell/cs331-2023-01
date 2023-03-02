-- flow.hs
-- Glenn G. Chappell
-- 2023-03-01
--
-- For CS 331 Spring 2023
-- Code from 3/1 - Haskell: Flow of Control

module Main where

import System.IO  -- for hFlush, stdout


main = do
    putStrLn ""
    putStrLn "This file contains sample code from March 1, 2023,"
    putStrLn "for the topic \"Haskell: Flow of Control\"."
    putStrLn "It will execute, but it is not intended to do anything"
    putStrLn "useful. See the source."
    putStrLn ""


-- ***** Pattern Matching, Recursion, Lazy Evaluation *****


-- A function can be given multiple definitions (as long as the types
-- are consistent!). The first definition that matches is the one used.

-- Pattern "[]" matches the empty list.
-- A pattern like "x:xs" matches any nonempty list.

-- isEmpty
-- (isEmpty x) returns True is list x is empty, False otherwise.
isEmpty [] = True
isEmpty (x:xs) = False

-- Try:
--   isEmpty []
--   isEmpty [1,2,3]
--   isEmpty ""
--   isEmpty "abc"

-- A numeric literal as a pattern matches only that value.
-- A variable name matches any single value.

-- sfibo
-- Slow Fibonacci
sfibo 0 = 0
sfibo 1 = 1
sfibo n = sfibo (n-2) + sfibo (n-1)

-- Try:
--   sfibo 6

-- "_" used in a pattern matches any single value, also marking the
-- value as unused.

-- listLength
-- Return the length of a given list.
-- So (listLength [4,5,2]) returns 3.
listLength [] = 0
listLength (_:xs) = 1 + listLength xs

-- Try:
--   listLength [1..50]
--   length [1..50000000]      -- That's 7 zeroes.
--   listLength [1..50000000]  -- I get stack overflow. If you don't,
--                             -- then increase the large number until
--                             -- you do. We deal with this later.

-- Thanks to lazy evaluation, the following works!

-- listFrom
-- (listFrom n) returns the infinite list [n, n+1, n+2, ...].
listFrom n = n:listFrom (n+1)

-- Try:
--   take 20 (listFrom 10)

-- myIf
-- Returns 2nd argument if 1st is true, 3rd if 1st is false.
myIf True  tval _    = tval
myIf False _    fval = fval

-- Try:
--   myIf (3 > 4) "yes" "no"

-- sfibo'
-- Slow Fibonacci using myIf
sfibo' n = myIf (n <= 1) n (sfibo' (n-2) + sfibo' (n-1))

-- Try:
--   sfibo' 6

-- evenOddString
-- Given an integer, returns "even" if it is even, and "odd"
-- if it is odd.
evenOddString n = myIf (n `mod` 2 == 0) "even" "odd"

-- myAbs
-- Returns absolute value of argument.
-- Same as standard function abs.
myAbs n = myIf (n >= 0) n (-n)


-- ***** Selection *****


-- * If-Then-Else

-- sfibo''
-- Slow Fibonacci using if-then-else
sfibo'' n = if (n <= 1) then n else (sfibo'' (n-2) + sfibo'' (n-1))

-- Try:
--   sfibo'' 6

-- * Guards

-- myAbs'
-- Returns absolute value of argument.
-- Same as standard function abs.
myAbs' x
    | x >= 0     = x   -- First line with True expression is used
    | otherwise  = -x  -- "otherwise" same as "True"

-- sfibo'''
-- Slow Fibonacci using guards.
sfibo''' n
    | n <= 1     = n
    | otherwise  = sfibo''' (n-2) + sfibo''' (n-1)

-- stringSign
-- Returns sign of argument, as string ("positive", "negative", "zero").
stringSign x
    | x > 0      = "positive"
    | x < 0      = "negative"
    | otherwise  = "zero"

-- Try:
--   stringSign (3-6)


-- ***** Error Handling *****


-- Fatal Errors

-- error :: String -> a
-- Crashes program on execution, displaying given error message.

-- lookInd
-- (lookInd n x) returns item n in list x (zero-based), or flags an
-- error if the index is out of range.
lookInd 0 (x:_) = x
lookInd n (_:xs) = lookInd (n-1) xs
lookInd _ [] = error "lookInd: index out of range"

-- Try:
--   lookInd 1 [5,4,28]
--   lookInd 12 [5,4,28]

-- undefined :: a
-- Crashes program on execution, displaying fixed error message.

-- fiboFast
-- Improved Fibonacci function.
fiboFast n
    | n < 0      = undefined
    | otherwise  = a where
        (a, b) = fiboPair n
        fiboPair 0 = (0, 1)
        fiboPair n = (d, c+d) where
            (c, d) = fiboPair (n-1)

-- Try:
--   fiboFast 8
--   fiboFast 1000
--   fiboFast (-2)


-- ***** Encapsulated Loops *****


-- * map: Apply function to each item of list

-- square
-- Returns square of a number - for use with map.
square x = x*x

-- myMap
-- Applies function to each item of a list.
-- Same as standard function map.
myMap f [] = []
myMap f (x:xs) = f x : myMap f xs

-- Try:
--   myMap square [1,4,6]
--   map square [1,4,6]
--   [ square x | x <- [1,4,6] ]

-- * filter: Return list of items in a given list meeting some condition

-- myFilter
-- Returns list of all items for which boolean func returns True.
-- Same as standard function filter.
myFilter f [] = []
myFilter f (x:xs)
    | f x        = x:rest
    | otherwise  = rest where
    rest = myFilter f xs

-- Try:
--   myFilter (<= 2) [4,0,8,-2,1,6]
--   filter (<= 2) [4,0,8,-2,1,6]
--   [x | x <- [4,0,8,-2,1,6], x <= 2]

-- * zip: Turn two lists into a list of pairs

-- myZip
-- Given two lists, returns list of pairs: the first pair holds the
-- first item from one list and the first item from the other list, etc.
-- This continues until one of the lists runs out.
-- Same as standard function zip.
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (y:ys) = (x,y):zip xs ys

-- Try:
--   myZip [6,3,2,8] "Howdy!"

-- * Fold operations: Functions for computing a single value from a list

-- mySum
-- Returns sum of items in list.
-- Same as standard function sum.
mySum [] = 0
mySum (a:as) = a + mySum as

-- Same thing, done with a fold

-- mySum' - same as mySum.
mySum' xs = foldl (+) 0 xs

-- mySum'' - same, but will not handle an empty list.
mySum'' xs = foldl1 (+) xs

-- Try:
--   mySum [1..100]
--   mySum' [1..100]
--   mySum'' [1..100]
--   mySum'' []

-- commafy
-- Join two String values, with comma-blank between.
commafy s1 s2 = s1 ++ ", " ++ s2

-- Try:
--   foldl1 commafy ["cats", "hamsters", "chocolate", "happiness"]

-- parenify
-- Join two String values, with a blank between and parentheses around.
parenify s1 s2 = "(" ++ s1 ++ " " ++ s2 ++ ")"

-- Try:
--   foldl1 parenify ["cats", "hamsters", "chocolate", "happiness"]
--   foldr1 parenify ["cats", "hamsters", "chocolate", "happiness"]


-- ***** Other *****


-- * seq

-- Here is a 2-argument function that returns its second argument.

second _ y = y

-- Try:
--   second 11 22
--   second undefined 22

-- Primitive "seq" is much the same, except that it always evaluates its
-- first argument.

-- Try:
--   seq 11 22
--   seq undefined 22

-- Again, our function listLength has a problem.

-- Try:
--   listLength [1..50]
--   listLength [1..50000000]  -- Use the same large number as above.

-- We get stack overflow. This is because listLength is not
-- tail-recursive, so TCO does not help us. Let's try to fix this by
-- writing a tail-recursive list-length function.

-- listLength'
-- Return the length of a given list.
listLength' xs = llenplus 0 xs  where
    llenplus n [] = n
    llenplus n (_:xs) = llenplus (n+1) xs

-- Try:
--   listLength' [1..50]
--   listLength' [1..50000000]  -- Use the same large number as above.

-- We still have a problem. Here is the fix:

-- listLength''
-- Return the length of a given list.
listLength'' xs = llenplus 0 xs  where
    llenplus n [] = n
    llenplus n (_:xs) = seq n (llenplus (n+1) xs)

-- Try:
--   listLength'' [1..50]
--   listLength'' [1..50000000]  -- Use the same large number as above.

-- No more stack overflow. Using seq as above prevents the construction
-- of increasingly complex unevaluated expressions for n.

-- * Do-Expression

-- reverseIt
-- Prompt the user for input, read a line, and print it reversed.
reverseIt = do
    putStr "Type something: "
    hFlush stdout  -- Requires "import System.IO"
    line <- getLine
    putStr "What you typed, reversed: "
    putStrLn (reverse line)

-- Try:
--   reverseIt
--   x = reverseIt
--   x
