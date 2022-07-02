
local function translator(input, seg)
	if (input == "time" or input == "now" or input == "shj" or input == "shij" or input == "shijian") then
		yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), " "))
		yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), " "))
	end
end

return translator