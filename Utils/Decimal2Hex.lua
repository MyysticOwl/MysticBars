function Decimal2Hex( num )
	if (type( num ) ~= "number") then
		num = tonumber( num )
	end
	if num == 0 or num == nil then return '0' end

   local neg = false
   if num < 0 then
	   neg = true
	   num = num * -1
   end

   local hexstr    = '0123456789ABCDEF'
   local result    = ''

   while num > 0 do
	   local n = math.mod( num, 16 )
	   result      = string.sub( hexstr, n + 1, n + 1 ) .. result
	   num         = math.floor( num / 16 )
   end

   if neg then
	   result = '-' .. result
   end

   return "0x" .. result
end