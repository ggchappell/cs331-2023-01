#!/usr/bin/env lua
-- userdparser3.lua
-- Glenn G. Chappell
-- 2023-02-17
--
-- For CS 331 Spring 2023
-- Simple Main Program for rdparser3 Module
-- Requires rdparser3.lua

rdparser3 = require "rdparser3"


-- String forms of symbolic constants
-- Used by writeAST_rdparser3
symbolNames = {
  [1]="BIN_OP",
  [2]="NUMLIT_VAL",
  [3]="SIMPLE_VAR",
}

-- writeAST_rdparser3
-- Write an AST, in (roughly) Lua form, with numbers replaced by the
-- symbolic constants used in rdparser3.
-- A table is assumed to represent an array.
-- See rdparser3.lua for the AST Specification.
function writeAST_rdparser3(x)
    if type(x) == "number" then
        local name = symbolNames[x]
        if name == nil then
            io.write("<ERROR: Unknown constant: "..x..">")
        else
            io.write(name)
        end
    elseif type(x) == "string" then
        io.write('"'..x..'"')
    elseif type(x) == "boolean" then
        if x then
            io.write("true")
        else
            io.write("false")
        end
    elseif type(x) == "table" then
        local first = true
        io.write("{")
        for k = 1, #x do  -- ipairs is problematic
            if not first then
                io.write(", ")
            end
            writeAST_rdparser3(x[k])
            first = false
        end
        io.write("}")
    elseif type(x) == "nil" then
        io.write("nil")
    else
        io.write("<ERROR: "..type(x)..">")
    end
end


-- check
-- Given a "program", check its syntactic correctness using rdparser3.
-- Print results.
function check(program)
    dashstr = "-"
    io.write(dashstr:rep(72).."\n")
    io.write("Program: "..program.."\n")

    local good, done, ast = rdparser3.parse(program)
    assert(type(good) == "boolean")
    assert(type(done) == "boolean")
    if good then
        assert(type(ast) == "table")
    end

    if good and done then
        io.write("Good! - AST: ")
        writeAST_rdparser3(ast)
        io.write("\n")
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
io.write("Recursive-Descent Parser: Expressions\n")
check("")
check("xyz")
check("123")
check("a b")
check("3a")
check("a +")
check("a + * b")
check("a + b (* c)")
check("a * -3")
check("3 - a")
check("a + +3 - c")
check("a + b - c + d - e")
check("a + (b - (c + (d - e)))")
check("a * +3 + c")
check("(a * +3) + c")
check("a * (+3 + c)")
check("a + +3 * c")
check("(a + +3) * c")

