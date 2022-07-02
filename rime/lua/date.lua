local function translator(input, seg)
    if (input == "date" or input == "today" or input == "jt" or input=="jint" or input == "jintian" or input=="riqi" ) then
        str_alb_y=os.date("%Y") --阿拉伯年
        str_alb_m=os.date("%m") --阿拉伯月
        str_alb_d=os.date("%d") --阿拉伯日
        num_tmp_m=str_alb_m+0
        num_m=math.modf(num_tmp_m) --数字月
        num_tmp_d=str_alb_d+0
        num_d=math.modf(num_tmp_d) --数字日
        str_hz_y = str_alb_y:gsub("%d",{
            ["1"]="一",
            ["2"]="二",
            ["3"]="三",
            ["4"]="四",
            ["5"]="五",
            ["6"]="六",
            ["7"]="七",
            ["8"]="八",
            ["9"]="九",
            ["0"]="〇",
        }) --汉字年
        str_hz_m=str_alb_m:gsub("%d",{
            ["1"]="一",
            ["2"]="二",
            ["3"]="三",
            ["4"]="四",
            ["5"]="五",
            ["6"]="六",
            ["7"]="七",
            ["8"]="八",
            ["9"]="九",
            ["0"]="",
        })
        if num_m==10 then str_hz_m = "十" end
        if num_m==11 then str_hz_m = "十一" end
        if num_m==12 then str_hz_m = "十二" end
        -- 汉字月

        str_alb_d_low = tostring(math.floor(num_d%10))  --数字日低位
        str_alb_d_high = tostring(math.floor(num_d/10)) --数字日高位
        str_hz_d_low=str_alb_d_low:gsub("%d",{
            ["1"]="一",
            ["2"]="二",
            ["3"]="三",
            ["4"]="四",
            ["5"]="五",
            ["6"]="六",
            ["7"]="七",
            ["8"]="八",
            ["9"]="九",
            ["0"]="",
        }) --汉字日低位
        str_hz_d_high=str_alb_d_high:gsub("%d",{
            ["1"]="十",
            ["2"]="二十",
            ["3"]="三十",
            ["4"]="",
            ["5"]="",
            ["6"]="",
            ["7"]="",
            ["8"]="",
            ["9"]="",
            ["0"]="",
        }) --汉字日高位
        str_hz_d = str_hz_d_high..str_hz_d_low
        yield(Candidate("date", seg.start, seg._end, str_alb_y.."年"..tostring(num_m).."月"..tostring(num_d).."日", "〔日期〕")) -- 2022年7月1日
        yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "〔日期〕"))                                          -- 2022-07-01
        yield(Candidate("date", seg.start, seg._end, tostring(num_m).."月"..tostring(num_d).."日", "〔日期〕"))                   -- 7月1日
        yield(Candidate("date", seg.start, seg._end, str_hz_y.."年"..str_hz_m.."月"..str_hz_d.."日", "〔日期〕"))              -- 二〇二二年七月一日
    end
end

-- 将上述定义导出
return translator
