#!/usr/bin/env lua
-- adv.lua
-- Glenn G. Chappell
-- 2023-02-06
--
-- For CS 331 Spring 2023
-- Code from 2/6 - Lua: Advanced Flow


-- ***** Coroutines *****


io.write("\n*** Coroutines:\n")

-- Here is a coroutine: a function that can temporarily give up control
-- ("yield"), and then be resumed again.

-- small_fibos1
-- Yield Fibonacci numbers at most given limit.
function small_fibos1(limit)
    local currfib, nextfib = 0, 1
    while currfib <= limit do
        coroutine.yield(currfib)  -- yield value; resumable afterwards
        currfib, nextfib = nextfib, currfib + nextfib
    end
end

-- Use the above coroutine
io.write("Small Fibonacci numbers, using a coroutine\n")

-- Upper limit for the Fibonacci numbers we print
max_fibo = 3000

-- Get the coroutine wrapper function
cw = coroutine.wrap(small_fibos1)

f = cw(max_fibo)  -- Attempt to get value from coroutine;
                  --  argument passed to small_fibos1
while f ~= nil do  -- While coroutine has not returned
    io.write(f .. "  ")  -- Do something with our value
    f = cw()             -- Attempt to get another value from coroutine
end
io.write("\n")


-- ***** Custom Iterators *****


io.write("\n*** Custom Iterators:\n")

-- You can make your own iterators for use with the for-in control
-- structure.

-- The following code:
--
--   for u, v1, v2 in XYZ do
--       FOR_LOOP_BODY
--   end
--
-- is translated to:
--
--   local iter, state, u = XYZ
--   local v1, v2
--   while true do
--       u, v1, v2 = iter(state, u)
--       if u == nil then
--           break
--       end
--       FOR_LOOP_BODY
--   end
--
-- Above, "v1, v2" can be replaced with an arbitrary number of
-- variables, or with no variables at all.

-- Here is an example (with the same result as the above coroutine
-- example):

-- small_fibos2
-- Allows for-in iteration through Fibonacci numbers at most n.
function small_fibos2(limit)
    local currfib, nextfib = 0, 1

    function iter(dummy1, dummy2)
        if currfib > limit then
            return nil  -- End iteration
        end
        local save_curr = currfib
        currfib, nextfib = nextfib, currfib + nextfib
        return save_curr
    end

    return iter, nil, nil
end

-- Use the above iterator
io.write("Small Fibonacci numbers, using a custom iterator\n")

for f in small_fibos2(max_fibo) do
    io.write(f .. "  ")
end
io.write("\n")


io.write("\n")
io.write("This file contains sample code from February 6, 2023,\n")
io.write("for the topic \"Lua: Advanced Flow\".\n")
io.write("It will execute, but it is not intended to do anything\n")
io.write("useful. See the source.\n")

io.write("\n")
-- Uncomment the following to wait for the user before quitting
--io.write("Press ENTER to quit ")
--io.read("*l")

