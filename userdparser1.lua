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

    local good = rdparser1.parse(program)
    assert(type(good) == "boolean",
           "rdparser1.parse must return boolean value")

    if good then
        io.write("Syntactically correct\n")
    else
        io.write("NOT SYNTACTICALLY CORRECT\n")
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
--check("((x)))")
--check("a,b,c")

