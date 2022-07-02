local function translator(input, seg)
    if (input == "week" or input == "xingqi" or input == "xingq" or input=="xqj" ) then
        str_week = os.date("%w")
        str_week = str_week:gsub("%d",{
            ["1"]="星期一",
            ["2"]="星期二",
            ["3"]="星期三",
            ["4"]="星期四",
            ["5"]="星期五",
            ["6"]="星期六",
            ["0"]="星期天",
        })
        yield(Candidate("week", seg.start, seg._end, str_week, "〔星期〕"))
    end
end

-- 将上述定义导出
return translator