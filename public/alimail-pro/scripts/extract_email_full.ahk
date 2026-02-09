; extract_email_full.ahk
; Extract full email data from Alibaba Mail
; Usage: Open email, press F8
; Output: Saves to Desktop\AliMail_Email_YYYYMMDD_HHMMSS.txt

#Requires AutoHotkey v2.0
#SingleInstance Force

; Configuration
OutputDir := A_Desktop
Timestamp := FormatTime(A_Now, "yyyyMMdd_HHmmss")
OutputFile := OutputDir "\AliMail_Email_" Timestamp ".txt"

; Hotkey: F8
F8::
{
    ; Verify AliMail window
    AliMailHWND := 0
    
    ; Try different window title patterns
    if WinExist("阿里邮箱") {
        AliMailHWND := WinGetID("阿里邮箱")
    } else if WinExist("Alibaba Mail") {
        AliMailHWND := WinGetID("Alibaba Mail")
    } else if WinExist("Mail") {
        AliMailHWND := WinGetID("Mail")
    }
    
    if (!AliMailHWND) {
        MsgBox("未找到阿里邮箱窗口。请先打开阿里邮箱并进入邮件详情页。", "错误", 16)
        return
    }
    
    ; Activate window
    WinActivate(AliMailHWND)
    WinWaitActive(AliMailHWND)
    Sleep(500)
    
    ; Initialize output
    Output := "阿里邮箱邮件提取`n"
    Output .= "=" . String("=", 50) . "`n"
    Output .= "提取时间: " FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") "`n"
    Output .= "=" . String("=", 50) . "`n`n"
    
    ; Method 1: Try to extract via clipboard (copy email content)
    try {
        ; Save current clipboard
        SavedClipboard := ClipboardAll()
        A_Clipboard := ""
        
        ; Select all and copy
        Send("^a")
        Sleep(300)
        Send("^c")
        Sleep(500)
        
        if (A_Clipboard) {
            ClipboardText := A_Clipboard
            if (StrLen(ClipboardText) > 50) {
                Output .= "[邮件内容 - 通过剪贴板提取]`n"
                Output .= "-" . String("-", 50) . "`n"
                Output .= ClipboardText "`n"
                Output .= "-" . String("-", 50) . "`n`n"
            }
        }
        
        ; Restore clipboard
        A_Clipboard := SavedClipboard
        
    } catch Error as e {
        Output .= "[剪贴板提取失败: " e.Message "]`n`n"
    }
    
    ; Method 2: Try ControlGetText on various controls
    ControlNames := ["RichEdit", "Edit", "MailView", "Body", "Content"]
    FoundContent := false
    
    for ctrlName in ControlNames {
        try {
            Text := ControlGetText(ctrlName, AliMailHWND)
            if (Text && StrLen(Text) > 100) {
                Output .= "[控件提取: " ctrlName "]`n"
                Output .= "-" . String("-", 50) . "`n"
                Output .= Text "`n"
                Output .= "-" . String("-", 50) . "`n`n"
                FoundContent := true
                break
            }
        } catch Error {
            continue
        }
    }
    
    if (!FoundContent) {
        Output .= "[提示: 无法通过控件提取内容，依赖剪贴板方法]`n`n"
    }
    
    ; Method 3: Try to get window title (may contain subject)
    try {
        WinTitle := WinGetTitle(AliMailHWND)
        if (WinTitle && WinTitle != "阿里邮箱") {
            Output .= "[窗口标题 - 可能包含主题]`n"
            Output .= WinTitle "`n"
            Output .= "-" . String("-", 50) . "`n`n"
        }
    } catch Error as e {
        Output .= "[无法获取窗口标题: " e.Message "]`n`n"
    }
    
    ; Method 4: Screenshot fallback
    try {
        WinGetPos(&X, &Y, &W, &H, AliMailHWND)
        
        ; Take screenshot via PrintScreen
        Send("!{PrintScreen}")  ; Active window only
        Sleep(500)
        
        if (A_Clipboard) {
            Output .= "[截图已捕获]`n"
            Output .= "截图已复制到剪贴板，可以粘贴到图像编辑器保存。`n"
            Output .= "-" . String("-", 50) . "`n`n"
        }
        
    } catch Error as e {
        Output .= "[截图失败: " e.Message "]`n`n"
    }
    
    ; Footer
    Output .= "=" . String("=", 50) . "`n"
    Output .= "提取完成`n"
    Output .= "提示: 由于阿里邮箱的安全机制，部分数据可能需要手动复制。`n"
    Output .= "建议重要邮件使用邮箱自带的导出功能备份。`n"
    
    ; Save to file
    try {
        FileAppend(Output, OutputFile)
        MsgBox("邮件已提取到:`n" OutputFile "`n`n如果内容为空或不完整，请尝试手动选择邮件内容复制粘贴。", "完成", 64)
    } catch Error as e {
        MsgBox("保存文件失败: " e.Message, "错误", 16)
    }
}

; Helper function: Create string of repeated character
String(Char, Count)
{
    Result := ""
    Loop(Count) {
        Result .= Char
    }
    return Result
}

; Help hotkey
F1::
{
    HelpText := "阿里邮箱邮件提取工具 (专业版)`n`n"
    HelpText .= "使用方法:`n"
    HelpText .= "1. 打开阿里邮箱桌面版`n"
    HelpText .= "2. 打开要提取的邮件详情页`n"
    HelpText .= "3. 按 F8 提取邮件内容`n`n"
    HelpText .= "快捷键:`n"
    HelpText .= "F8 - 提取当前邮件`n"
    HelpText .= "F1 - 显示帮助`n`n"
    HelpText .= "注意事项:`n"
    HelpText .= "- 提取的内容保存为文本文件在桌面`n"
    HelpText .= "- 附件需要手动下载`n"
    HelpText .= "- 部分邮件可能无法完整提取`n"
    MsgBox(HelpText, "帮助", 64)
}
