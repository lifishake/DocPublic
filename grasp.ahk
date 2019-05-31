{
    SetTitleMatchMode, 2
    myLocation = %1%
    myYear = %2%
    myMonth = %3%
    myDay = %4%
    If (myLocation<>11 && myLocation<>12 && myLocation<>10 && myLocation<>50)
    {
        MsgBox,Unknown location code %myLocation%.
        return
    }
    If (StrLen(myYear)<>4 || StrLen(myMonth)<>2 || StrLen(myDay)<>2)
    {
        MsgBox,Unknown Date Format %myYear%-%myMonth%-%myDay%.
        return
    }
    myUrl = https://www.caipiaoapi.com/hall/hallhistory/detail/%myLocation%/%myYear%-%myMonth%-%myDay%
    myTopChar = %myYear%%myMonth%%myDay%
    ;江苏50
    IfEqual, myLocation, 50, myTopChar = %myTopChar%41
    ;山东
    IfEqual, myLocation, 11, myTopChar = %myTopChar%43
    ;江西
    IfEqual, myLocation, 10, myTopChar = %myTopChar%42
    ;广东
    IfEqual, myLocation, 12, myTopChar = %myTopChar%42
    ;打开火狐
    If !WinExist("ahk_class MozillaWindowClass")
    {
        MsgBox,Must open firefox!
        return
    }
    If !WinExist("ahk_exe notepad++.exe")
    {
        MsgBox,Must open notepad++!
        return
    }
    WinActivate,ahk_class MozillaWindowClass
    Sleep 2000
    Send ^t
    Sleep, 500
    ;输网址
    Send, %myUrl%
    Sleep, 200
    Send, {Enter}
    Sleep, 200
    Send, {Enter}
    Sleep, 5000

    ;全选,复制
    Send, {Ctrl down}a{Ctrl up}
    Sleep, 100
    Send, {Ctrl down}c{Ctrl up}
    Sleep, 2000
    clip := Clipboard
    Sleep, 1000
    ;关闭火狐页
    Send, ^w

    ;打开notepad++
    WinActivate, ahk_exe notepad++.exe
    Sleep, 2000

    ;打开新空白页
    Send, {Ctrl down}n{Ctrl up}
    Sleep, 100
    ;粘贴
    Send, {Ctrl down}v{Ctrl up}
    Sleep, 1000
    ;文件开始
    Send, ^{Home}
    Sleep, 100

    ;删除最新一条以前的东西
    Send, ^f
    Sleep, 1000
    WinGet, myHwnd, ID, Find
    SetControlDelay -1
    Control, Check, ,Button17, ahk_id %myHwnd%
    Sleep, 100
    ControlSetText, Edit1, %myTopChar%, ahk_id %myHwnd%
    Sleep, 100
    ControlClick, Button20, ahk_id %myHwnd%
    Sleep, 1000
    ControlClick, Button29, ahk_id %myHwnd%
    Sleep, 500
    Send, {Home}
    Sleep,100
    Send, ^+{Home}
    Sleep, 100
    Send, {Del}
    Sleep, 100

    ;找最后的一个页面号1并删除后面的东西
    Send, ^f
    Sleep, 1000
    WinGet, myHwnd, ID, Find
    Sleep, 100
    ControlSetText, Edit1, \r\n1\r\n\r\n, ahk_id %myHwnd%
    Sleep, 100
    ControlClick, Button20, ahk_id %myHwnd%
    Sleep, 1000
    ControlClick, Button29, ahk_id %myHwnd%
    Sleep, 500
    Send, {Up}{Up}{Up}
    Sleep, 100
    Send, ^+{End}
    Sleep, 500
    Send, {Del}
    
    ;替换\r\n四空格为逗号
    Send ^h
    Sleep, 1000
    WinGet, myHwnd, ID, Replace
    Sleep, 100
    ControlSetText, Edit1, \r\n%A_Space%%A_Space%%A_Space%%A_Space%, ahk_id %myHwnd%
    Sleep, 100
    ControlSetText, Edit2, `, , ahk_id %myHwnd%
    Sleep, 100
    ControlClick, Button25, ahk_id %myHwnd%
    Sleep, 1000

    ;替换\t\r\n,为空
    ControlSetText, Edit1, \t\r\n`,, ahk_id %myHwnd%
    Sleep,100
    ControlSetText, Edit2, \t, ahk_id %myHwnd%
    Sleep, 100
    ControlClick, Button25, ahk_id %myHwnd%
    Sleep, 1000
    
    ;替换\r\n\r\n为\r\n
    ControlSetText, Edit1, \r\n\r\n, ahk_id %myHwnd%
    Sleep,100
    ControlSetText, Edit2, \r\n, ahk_id %myHwnd%
    Sleep, 100
    ControlClick, Button25, ahk_id %myHwnd%
    Sleep, 1000
    ControlClick, Button29, ahk_id %myHwnd%
    
    Send, ^a
    Sleep, 1000
    Send, ^c
    Sleep, 100
    
}