local widget = require( "widget" )

local function getValue( char )
    local value = 0
    if char == "I" then
        value = 1
    elseif char == "V" then
        value = 5
    elseif char == "X" then
        value = 10
    elseif char == "L" then
        value = 50
    elseif char == "C" then
        value = 100
    elseif char == "D" then
        value = 500
    elseif char == "M" then
        value = 1000
    end
    return value
end

local function romToNum( r_roman )
    local roman = string.upper( r_roman )
    local number = 0
    local chars = {}
    for i = 1, string.len( roman ) do
        local c = string.sub( roman, i, i )
        table.insert( chars, c )
    end
    for i = 1, string.len( roman ) do
        if i == string.len( roman ) then
            number = number + getValue( chars[i] )
            break
        elseif getValue(chars[i]) >= getValue(chars[i+1]) then
            number = number + getValue( chars[i] )
        elseif getValue(chars[i]) < getValue(chars[i+1]) then
            number = number - getValue( chars[i] )
        end
    end
    return number
end

local input = native.newTextField( 300, 200, 400, 100 )

local list = display.newText( "", 400, 1000, 500, 400 )

local function start( event )
    local number = romToNum( input.text )
    list.text = input.text .. "  ---  " .. tostring(number) .. "\n" .. list.text
    input.text = ""
end

local btnData = {
    x = 400,
    y = 1080,
    onRelease = start,
    label = "O",
    shape = "circle",
    fontSize = 80,
    fillColor = { default = {0.1, 0.1, 0.1}, over = {0.3, 0.3, 0.3} },
    radius = 70,
    labelColor = { default = { 1, 1, 0 } }
}

local btn = widget.newButton( btnData )