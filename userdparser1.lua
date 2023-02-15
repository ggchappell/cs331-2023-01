#!/usr/bin/env lua
-- userdparser1.lua
-- Glenn G. Chappell
-- 2023-02-13
--
-- For CS 331 Spring 2023
-- Simple Main Program for rdparser1 Module
-- Requires rdparser1.lua

rdparser1 = require "rdparser1"


-- check
-- Given a "program", check its syntactic correctness using rdparser1.
-- Print results.
function check(program)
    dashstr = "-"
    io.write(dashstr:rep(72).."\n")
    io.write("Program: "..program.."\n")

    local good, done = rdparser1.parse(program)
    assert(type(good) == "boolean",
           "Function parse must return 2 boolean values")
    assert(type(done) == "boolean",
           "Function parse must return 2 boolean values")

    if good then
        io.write("Syntactically correct; ")
    else
        io.write("NOT SYNTACTICALLY CORRECT; ")
    end

    if done then
        io.write("all input parsed\n")
    else
        io.write("NOT ALL INPUT PARSED\n")
    end

    io.write("Conclusion: ")
    if good and done then
        io.write("Good!\n")
    elseif good and not done then
        io.write("Bad - extra characters at end\n")
    elseif not good and done then
        io.write("Unfinished - more is needed\n")
    else  -- not good and not done
        io.write("Bad - syntax error\n")
    end
end


-- Main program
-- Check several "programs".
io.write("Recursive-Descent Parser: Simple\n")
check("")
check("xyz")
check("123")
check("%")
check("((abc_39))")
check("(((((%)))))")
check("(a,b,c)")
check("(((x))")
check("((x)))")
check("a,b,c")

