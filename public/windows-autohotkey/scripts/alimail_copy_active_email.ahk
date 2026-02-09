#Requires AutoHotkey v2.0
#SingleInstance Force

; alimail_copy_active_email.ahk
; Read-only helper: copies the currently focused email body and saves it to Desktop.
; Usage: open an email, click inside the email body, press F8.

F8::{
    ClipSaved := ClipboardAll()
    A_Clipboard := ""

    ; Try to copy selected content; if nothing selected, select all then copy.
    Send "^c"
    if !ClipWait(0.3) {
        Send "^a"
        Sleep 80
        Send "^c"
        if !ClipWait(1.0) {
            ; Restore clipboard and exit.
            Clipboard := ClipSaved
            MsgBox "Copy failed. Please click inside the email body and try again.", "Alibaba Mail Copy", 48
            return
        }
    }

    text := A_Clipboard

    ; Basic guard: avoid writing empty/very short outputs.
    if StrLen(Trim(text)) < 20 {
        Clipboard := ClipSaved
        MsgBox "Copied text is too short. Make sure the email body is focused.", "Alibaba Mail Copy", 48
        return
    }

    ts := FormatTime(, "yyyy-MM-dd_HH-mm-ss")
    outPath := A_Desktop "\\Alimail_Email_" ts ".txt"

    try {
        FileDelete outPath
    }
    FileAppend text, outPath, "UTF-8"

    ; Restore clipboard
    Clipboard := ClipSaved

    MsgBox "Saved to: `n" outPath, "Alibaba Mail Copy", 64
}
