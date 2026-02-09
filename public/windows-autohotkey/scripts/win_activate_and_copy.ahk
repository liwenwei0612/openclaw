#Requires AutoHotkey v2.0
#SingleInstance Force

; win_activate_and_copy.ahk
; Generic copy helper: Press F9 to copy focused control text (Ctrl+C; fallback Ctrl+A then Ctrl+C)

F9::{
    ClipSaved := ClipboardAll()
    A_Clipboard := ""

    Send "^c"
    if !ClipWait(0.3) {
        Send "^a"
        Sleep 80
        Send "^c"
        if !ClipWait(1.0) {
            Clipboard := ClipSaved
            MsgBox "Copy failed. Click the target area first.", "Copy", 48
            return
        }
    }

    MsgBox "Copied to clipboard (length: " StrLen(A_Clipboard) ")", "Copy", 64
    Clipboard := ClipSaved
}
