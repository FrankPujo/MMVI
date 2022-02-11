local widget = require( "widget" )

local xCentre = display.contentCenterX
local yCentre = display.contentCenterY

local bg = display.newRect( xCentre, yCentre, xCentre * 3, yCentre * 4 )
bg:setFillColor( 0.5, 0.3, 0 )
local bottom = display.newRoundedRect( xCentre, 800, 700, 800, 10 )
bottom:setFillColor( 0.8, 0.4, 0.1, 0.4 )
bottom:setStrokeColor( 0.3, 0.2, 0 )
bottom.strokeWidth = 12
local title = display.newText( "MMVI", xCentre, 0 )
title.size = 100
title:setFillColor( 0.2, 0.6, 1 )

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

local input = native.newTextField( xCentre, 160, 400, 100 )

local list = display.newText( "", xCentre, 900, 580, 650 )
list.size = 61

local function start( event )
    if input.text ~= "" then
        local number = romToNum( input.text )
        list.text = string.upper(input.text) .. "   ---->   " .. tostring(number) .. "\n" .. list.text
        input.text = ""
    end
end

local btnData = {
    x = xCentre,
    y = 400,
    onRelease = start,
    label = "LessGooo",
    shape = "circle",
    fontSize = 60,
    fillColor = { default = {0.8, 0.1, 0.1}, over = {0.6, 0, 0} },
    radius = 120,
    labelColor = { default = { 1, 1, 1 } }
}

local btn = widget.newButton( btnData )