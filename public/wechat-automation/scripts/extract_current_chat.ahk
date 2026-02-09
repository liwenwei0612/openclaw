; extract_current_chat.ahk
; Extract current WeChat chat window messages
; Usage: Open chat window, press F8
; Output: Saves to Desktop\WeChat_Chat_YYYYMMDD_HHMMSS.txt

#Requires AutoHotkey v2.0
#SingleInstance Force

; Configuration
OutputDir := A_Desktop
Timestamp := FormatTime(A_Now, "yyyyMMdd_HHmmss")
OutputFile := OutputDir "\WeChat_Chat_" Timestamp ".txt"

; WeChat window classes (may vary by version)
WeChatClasses := ["WeChatMainWndForPC", "ChatWnd"]

; Hotkey: F8
F8::
{
    ; Find WeChat window
    WeChatHWND := 0
    for class in WeChatClasses {
        WeChatHWND := WinGetID("ahk_class " class)
        if (WeChatHWND) {
            break
        }
    }
    
    if (!WeChatHWND) {
        ; Try partial match
        if WinExist("微信") {
            WeChatHWND := WinGetID("微信")
        } else if WinExist("WeChat") {
            WeChatHWND := WinGetID("WeChat")
        }
    }
    
    if (!WeChatHWND) {
        MsgBox("未找到微信窗口。请先打开微信并进入聊天界面。", "错误", 16)
        return
    }
    
    ; Activate window
    WinActivate(WeChatHWND)
    WinWaitActive(WeChatHWND)
    Sleep(500)
    
    ; Initialize output
    Output := "微信聊天记录提取`n"
    Output .= "提取时间: " FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") "`n"
    Output .= "================================================`n`n"
    
    ; Try to get chat title
    try {
        ChatTitle := WinGetTitle(WeChatHWND)
        Output .= "聊天对象: " ChatTitle "`n"
        Output .= "================================================`n`n"
    } catch Error as e {
        Output .= "[无法获取聊天标题]`n`n"
    }
    
    ; Method 1: Try to extract via clipboard (select all and copy)
    try {
        ; Save current clipboard
        SavedClipboard := ClipboardAll()
        A_Clipboard := ""
        
        ; Click in chat area (approximate position)
        WinGetPos(&X, &Y, &W, &H, WeChatHWND)
        ChatAreaX := X + W // 2
        ChatAreaY := Y + H // 2
        
        ; Click to focus chat area
        Click(ChatAreaX, ChatAreaY)
        Sleep(300)
        
        ; Select all messages
        Send("^a")
        Sleep(200)
        
        ; Copy to clipboard
        Send("^c")
        Sleep(500)
        
        if (A_Clipboard) {
            Output .= "[通过剪贴板提取]`n"
            Output .= A_Clipboard "`n"
            Output .= "`n================================================`n"
        } else {
            Output .= "[剪贴板无数据]`n"
        }
        
        ; Restore clipboard
        A_Clipboard := SavedClipboard
        
    } catch Error as e {
        Output .= "[剪贴板方法失败: " e.Message "]`n"
    }
    
    ; Method 2: Try ControlGetText on message list
    try {
        ; Try different control names
        ControlNames := ["ChatMsgList", "RichEditComponent", "CefBrowserWindow"]
        
        for ctrlName in ControlNames {
            try {
                Text := ControlGetText(ctrlName, WeChatHWND)
                if (Text && StrLen(Text) > 10) {
                    Output .= "`n[控件 " ctrlName " 提取]`n"
                    Output .= Text "`n"
                    break
                }
            } catch Error {
                continue
            }
        }
    } catch Error as e {
        Output .= "`n[控件提取失败: " e.Message "]`n"
    }
    
    ; Method 3: Screenshot as fallback
    try {
        ScreenshotFile := OutputDir "\WeChat_Chat_" Timestamp ".png"
        WinGetPos(&X, &Y, &W, &H, WeChatHWND)
        
        ; Use PrintScreen for active window
        Send("!{PrintScreen}")  ; Alt+PrintScreen for active window
        Sleep(500)
        
        if (A_Clipboard) {
            ; If clipboard has image, mention it
            Output .= "`n[截图已复制到剪贴板]`n"
            Output .= "提示: 可以将剪贴板中的截图粘贴到文件保存`n"
        }
        
        ; Also try full screenshot
        Send("{PrintScreen}")
        Sleep(200)
        
    } catch Error as e {
        Output .= "`n[截图失败: " e.Message "]`n"
    }
    
    ; Save output
    Output .= "`n================================================`n"
    Output .= "提取完成`n"
    Output .= "注意: 由于微信的安全机制，部分数据可能无法自动提取。`n"
    Output .= "建议手动选择聊天内容复制粘贴作为补充。`n"
    
    try {
        FileAppend(Output, OutputFile)
        MsgBox("聊天记录已提取到:`n" OutputFile "`n`n注意: 如果提取内容为空，请尝试手动选择聊天内容复制粘贴。", "完成", 64)
    } catch Error as e {
        MsgBox("保存文件失败: " e.Message, "错误", 16)
    }
}

; Helper: Click function
Click(X, Y)
{
    MouseMove(X, Y)
    Sleep(50)
    MouseClick("Left")
}

; Help hotkey
F1::
{
    HelpText := "微信聊天记录提取工具`n`n"
    HelpText .= "使用方法:`n"
    HelpText .= "1. 打开微信桌面版`n"
    HelpText .= "2. 进入要提取的聊天窗口`n"
    HelpText .= "3. 按 F8 提取数据`n`n"
    HelpText .= "快捷键:`n"
    HelpText .= "F8 - 提取当前聊天记录`n"
    HelpText .= "F1 - 显示帮助`n`n"
    HelpText .= "注意事项:`n"
    HelpText .= "- 微信使用自定义控件，可能无法提取所有内容`n"
    HelpText .= "- 建议重要数据手动复制备份`n"
    HelpText .= "- 提取的数据仅保存在本地`n"
    MsgBox(HelpText, "帮助", 64)
}
