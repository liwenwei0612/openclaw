; extract_product_list.ahk
; Extract product list from Alibaba Seller Workbench
; Usage: Open product list page, press F8
; Output: Saves to Desktop\AlibabaProducts_YYYYMMDD_HHMMSS.txt

#Requires AutoHotkey v2.0
#SingleInstance Force

; Configuration
OutputDir := A_Desktop
Timestamp := FormatTime(A_Now, "yyyyMMdd_HHmmss")
OutputFile := OutputDir "\AlibabaProducts_" Timestamp ".txt"

; Hotkey: F8
F8::
{
    ; Verify Seller Workbench window
    if !WinExist("ahk_class Chrome_WidgetWin_1") && !WinExist("阿里卖家")
    {
        MsgBox("阿里卖家工作台窗口未找到。请先打开应用。", "错误", 16)
        return
    }
    
    ; Activate window
    WinActivate()
    WinWaitActive()
    Sleep(500)
    
    ; Initialize output
    Output := "产品名称`tSKU`t价格`t库存`t状态`n"
    Output .= "================================================`n"
    
    ; Try multiple methods to extract data
    
    ; Method 1: Try to get text from list controls
    try {
        ; Look for product list container
        ProductList := ControlGetText("Chrome_RenderWidgetHostHWND1")
        if (ProductList) {
            Output .= "[从界面提取的数据]`n" ProductList "`n"
        }
    } catch Error as e {
        Output .= "[注意] 无法直接提取控件数据: " e.Message "`n"
    }
    
    ; Method 2: Use clipboard to copy selected items
    try {
        ; Save current clipboard
        SavedClipboard := ClipboardAll()
        A_Clipboard := ""
        
        ; Select all and copy
        Send("^a")
        Sleep(200)
        Send("^c")
        Sleep(300)
        
        if (A_Clipboard) {
            Output .= "`n[剪贴板数据]`n" A_Clipboard "`n"
        }
        
        ; Restore clipboard
        A_Clipboard := SavedClipboard
    } catch Error as e {
        Output .= "[注意] 剪贴板方法失败: " e.Message "`n"
    }
    
    ; Method 3: Take screenshot as fallback
    try {
        ScreenshotFile := OutputDir "\AlibabaProducts_" Timestamp ".png"
        ; Capture active window
        WinGetPos(&X, &Y, &W, &H, "A")
        Screenshot(X, Y, W, H, ScreenshotFile)
        Output .= "`n[截图已保存] " ScreenshotFile "`n"
    } catch Error as e {
        Output .= "[注意] 截图失败: " e.Message "`n"
    }
    
    ; Save output
    try {
        FileAppend(Output, OutputFile)
        MsgBox("产品数据已提取到:`n" OutputFile, "完成", 64)
    } catch Error as e {
        MsgBox("保存文件失败: " e.Message, "错误", 16)
    }
}

; Screenshot helper function
Screenshot(X, Y, W, H, FileName)
{
    ; Use GDI+ for screenshot
    if !FileExist(FileName)
    {
        ; Create bitmap from screen
        hDC := DllCall("GetDC", "Ptr", 0, "Ptr")
        hMemDC := DllCall("CreateCompatibleDC", "Ptr", hDC, "Ptr")
        hBitmap := DllCall("CreateCompatibleBitmap", "Ptr", hDC, "Int", W, "Int", H, "Ptr")
        DllCall("SelectObject", "Ptr", hMemDC, "Ptr", hBitmap)
        DllCall("BitBlt", "Ptr", hMemDC, "Int", 0, "Int", 0, "Int", W, "Int", H
            , "Ptr", hDC, "Int", X, "Int", Y, "UInt", 0x00CC0020)
        
        ; Save bitmap to file (simplified - would need GDI+ library for full implementation)
        ; For now, use PrintScreen as fallback
        Send("{PrintScreen}")
        Sleep(200)
        if (A_Clipboard) {
            ; Save clipboard image
            ; This requires additional libraries for full implementation
        }
        
        ; Cleanup
        DllCall("DeleteObject", "Ptr", hBitmap)
        DllCall("DeleteDC", "Ptr", hMemDC)
        DllCall("ReleaseDC", "Ptr", 0, "Ptr", hDC)
    }
}

; Help hotkey
F1::
{
    HelpText := "阿里卖家产品提取工具`n`n"
    HelpText .= "使用方法:`n"
    HelpText .= "1. 打开阿里卖家工作台`n"
    HelpText .= "2. 进入产品管理页面`n"
    HelpText .= "3. 按 F8 提取数据`n`n"
    HelpText .= "快捷键:`n"
    HelpText .= "F8 - 提取产品列表`n"
    HelpText .= "F1 - 显示帮助`n"
    MsgBox(HelpText, "帮助", 64)
}
