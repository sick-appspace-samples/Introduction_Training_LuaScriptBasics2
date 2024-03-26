-- -----------------------------------------------------------------------------
print( "----- Strings" )
-- -----------------------------------------------------------------------------

-- The standard Lua library 'string' supports nice convenient functions for working with strings:
print( string.byte( "ABCDE", 1, -2 ) )         -- console output: "65    66    67    68"
print( string.rep( "w", 3 ) .. ".sick.com" )   -- console output: "www.sick.com"
print( string.reverse( "Hello" ) )             -- console output: "olleH"
print( string.sub( "AppSpace", 6, -1 ) )       -- console output: "ace"
print( string.format( "%s %.10f", "Pi is exactly", math.pi ) )
                                        -- console output: "Pi is exactly 3.1415926536"

-- -----------------------------------------------------------------------------
print( "----- Concatenate tables and access elements" )
-- -----------------------------------------------------------------------------

-- The standard Lua library 'table' offers a mighty set of functionality. Concatenating tables is very efficient in Lua:
local myTable = { "one", "two", "three", "four" }
print( table.concat( myTable ) )                       -- console output: "onetwothreefour"
print( table.concat( myTable, ":" ) )                  -- console output: "one:two:three:four"
print( table.concat( myTable, "-", 2, 4 ) )            -- console output: "two-three-four"
print( table.maxn( myTable ) .. " == " .. #myTable )   -- console output: "4.0 == 4"
-- Append an item, indices should be successive without gaps and start with 1, not 0:
myTable[ #myTable + 1 ] = "five"
table.insert( myTable, #myTable + 1, "six" )
--table.insert( myTable, 9, "nine" )
                                        -- console output: "Runtime error: bad argument #2 to 'insert' (position out of bounds)"
-- Appending a 'nil' item will not be considered:
table.insert( myTable, #myTable + 1, nil )
myTable[ #myTable + 1 ] = nil
table.insert( myTable, #myTable + 1, "nine" )
print( #myTable .. "; " .. myTable[ #myTable ] )       -- console output: "7; nine"
-- Sort with inline function as sorting method:
table.sort( myTable, function ( a, b ) return a < b end )
print( table.concat( myTable, "," ) )
                                        -- console output "five,four,nine,one,six,three,two"

-- -----------------------------------------------------------------------------
print( "----- Use tables as dictionaries or maps and access elements" )
-- -----------------------------------------------------------------------------

local myMap = { key1 = "value1", key2 = false }
print( myMap.key1 )                     -- console output: "value1"
-- Add a new key/value pair, value can also be a table:
myMap.newKey = { "one", "two", "three" }
-- Remove 'key2' from table:
myMap.key2 = nil
-- Use '.' to reach certain values:
print( myMap.key1 )                     -- console output: "value1"
print( myMap.key2 )                     -- console output: "nil"
-- Alternatively, use square brackets to reach certain values:
print( myMap[ "newKey" ][ 2 ] )         -- console output: "two"
-- Some table operations do not work with dictionaries or maps:
print( #myMap )                         -- console output: "0"
print( #myMap.newKey )                  -- console output: "3"
-- Lua will not check for the range of available indices:
print( myMap.newKey[ 10 ] )             -- console output: "nil"

-- -----------------------------------------------------------------------------
print( "----- Library math" )
-- -----------------------------------------------------------------------------

-- The standard Lua library 'math' provides a large function set. Here is just a small excerpt:
print( math.sin( math.pi / 2 ) )            -- console output: "1.0"
print( string.format( "%f", math.sin( math.pi * 0.5 ) ) )
                                            -- console output: "1.000000"
print( math.min( 56, 4, 76, 23, 2, 76 ) )   -- console output: "2"
local myNumTable = { 15, -4, 76, 32, 10, 21, -76, 63 }
table.sort( myNumTable, function ( a, b ) return math.abs( a ) < math.abs( b ) end )
print( math.abs( myNumTable[ 1 ] ) )        -- console output: "4"
local myNumber = 2 ^ 8 - 1
local fraction, exponent = math.frexp( myNumber )
print( fraction .. " * 2 ^ " .. exponent .. " = " .. fraction .. string.format( " * %i = %i", 2 ^ exponent, myNumber ) )
                                        -- console output: "0.99609375 * 2 ^ 8 = 0.99609375 * 256 = 255"

-- Try more using the standard Lua library 'math':

-- -----------------------------------------------------------------------------
print( "----- if and inline condition" )
-- -----------------------------------------------------------------------------

local a, b = 5, 5
if ( a == b ) then
  print( a .. " is equal to " .. b )       -- console output: "5 is equal to 5"
elseif ( a > b ) then
  print( a .. " is greater than " .. b )   -- console output: "5 is greater than 5"
else
  print( a .. " is less than " .. b )      -- console output: "5 is less than 5"
end
local c, d = "blue", "red"
if ( c ~= d ) then
  print( c .. " is not " .. d )            -- console output: "blue is not red"
else
  print( c .. " is " .. d )                -- console output: "blue is red"
end
local x, y = 12, 34
print( x .. ( x == y and " is equal to " or " is not equal to " ) .. y )
                                        -- console output: "12 is not equal to 34"

-- -----------------------------------------------------------------------------
print( "----- while loop" )
-- -----------------------------------------------------------------------------

a, b = 5, 1
-- If condition is false at all, block will not be executed:
while ( a > b ) do
  print( a .. " is still greater than " .. b )
  b = b + 1
  -- Do not forget about the condition to avoid infinite loops!
end

-- -----------------------------------------------------------------------------
print( "----- for loop" )
-- -----------------------------------------------------------------------------

-- A numerical 'for' loop:
local start, stop, step = 10, 0, -1
-- If start index exceeds stop index at all, i.e. even in case of decreasing step, block will not be executed:
for i = start, stop, step do
  print( i .. ( ( i % 2 == 0 ) and " is even" or " is odd" ) )
end

-- A 'for' loop based on an array, i.e. table with numeric indices:
for i, v in ipairs( { 1, 4, 9, 16, 25 } ) do
  print( "Index is " .. i .. ", value is " .. v )
end

-- A 'for' loop based on a generic map, i.e. table with string indices:
local capitals = { Germany = "Berlin", France = "Paris", Norway = "Oslo",
England = "London", Spain = "Madrid", Ukraine = "Kiew", Austria = "Vienna",
Portugal = "Lisbon", Italy = "Rome", Croatia = "Zagreb" }
print( "Some european countries and their capitals (unsorted):" )
for k, v in pairs( capitals ) do
  print( "   - The capital of " .. string.format( "% 8s", k ) .. " is " .. v .. "." )
end
table.sort( capitals )
print( "Some european countries and their capitals (sorted?):" )
for k, v in pairs( capitals ) do
  print( "   - The capital of " .. string.format( "% 8s", k ) .. " is " .. v .. "." )
end
-- Generic maps or dictionaries cannot be sorted, i.e. the 'pairs' iterator will jump unpredictable over the elements!

-- -----------------------------------------------------------------------------
print( "----- repeat loop" )
-- -----------------------------------------------------------------------------

-- A 'repeat' loop:
local i = 0
repeat
  print( "Counter is " .. i )
  i = i + 1
  -- Do not forget about the condition to avoid infinite loops!
until i > 10
-- If the condition is false at all, the block will be executed at least once!
