#Requires AutoHotkey 2.0
#SingleInstance
#Include "_jxon.ahk"
#Include lib\WebView2.ahk
Persistent

/*
====================================================
Script Tray Menu
====================================================
*/

TraySetIcon("IconOn.ico")
A_TrayMenu.Delete
A_TrayMenu.Add("&Debug", Debug)
A_TrayMenu.Add("&Reload Script", ReloadScript)
A_TrayMenu.Add("E&xit", Exit)
A_IconTip := "ChatGPT AutoHotkey Utility"

ReloadScript(*) {
	Reload
}

Debug(*) {
	ListLines
}

Exit(*) {
	ExitApp
}

/*
====================================================
Initialize Suspend GUI
====================================================
*/

ScriptSuspendStatus := Gui()
ScriptSuspendStatus.Add("Text", "cWhite", "ChatGPT AutoHotkey Utility Suspended")
ScriptSuspendStatus.BackColor := "0x7F00FF" ; Violet
ScriptSuspendStatus.Opt("-Caption +Owner -SysMenu +AlwaysOnTop")

/*
====================================================
Toggle Suspend
====================================================
*/

Toggle_Suspend(*) {
	Suspend -1
	if (A_IsSuspended) {
		TraySetIcon("IconOff.ico",, 1)
		A_IconTip := "ChatGPT AutoHotkey Utility - Suspended (Press CapsLock + backtick (``) to unsuspend)"
		ScriptSuspendStatus.Show("AutoSize x885 y35 NA")
	} else {
		TraySetIcon("IconOn.ico")
		A_IconTip := "ChatGPT AutoHotkey Utility"
		ScriptSuspendStatus.Hide()
	}
}

/*
====================================================
Dark mode tray menu
====================================================
*/

Class DarkMode {
    Static __New(Mode := 1) => ( ; Mode: Dark = 1, Default (Light) = 0
        DllCall(DllCall("GetProcAddress", "ptr", DllCall("GetModuleHandle", "str", "uxtheme", "ptr"), "ptr", 135, "ptr"), "int", mode),
        DllCall(DllCall("GetProcAddress", "ptr", DllCall("GetModuleHandle", "str", "uxtheme", "ptr"), "ptr", 136, "ptr"))
    )
}

/*
====================================================
Variables
====================================================
*/

API_Key := "Your_API_Key_Here"
API_URL := "https://api.openai.com/v1/chat/completions"
Status_Message := ""
Response_Window_Status := "Closed"
Retry_Status := ""

/*
====================================================
Menus and ChatGPT prompts
====================================================
*/

MenuPopup := Menu()
MenuPopup.Add("&1 - Rephrase", Rephrase)
MenuPopup.Add("&2 - Reply", Reply)
MenuPopup.Add("&3 - Answer", Answer)
MenuPopup.Add("&4 - Translate to English", TranslateToEnglish)
MenuPopup.Add("&5 - Follow instructions", FollowInstructions)
MenuPopup.Add("&6 - Find action items", FindActionItems)
MenuPopup.Add("&7 - Define", Define)
MenuPopup.Add("&8 - Opinion", Opinion)

Rephrase(*) {
    ChatGPT_Prompt := "Rephrase the following text or paragraph to ensure clarity, conciseness, and a natural flow. The revision should preserve the tone, style, and formatting of the original text. If possible, split it into paragraphs to improve readability. Additionally, correct any grammar and spelling errors you come across:"
    Status_Message := "Rephrasing..."
    API_Model := "gpt-4o"
    ProcessRequest(ChatGPT_Prompt, Status_Message, API_Model, Retry_Status)
}

Answer(*) {
    ChatGPT_Prompt := "Answer the following:"
    Status_Message := "Answering..."
    API_Model := "gpt-4o-mini"
    ProcessRequest(ChatGPT_Prompt, Status_Message, API_Model, Retry_Status)
}

FollowInstructions(*) {
    ChatGPT_Prompt := "Follow the instructions:"
    Status_Message := "Following the instructions..."
    API_Model := "gpt-4o"
    ProcessRequest(ChatGPT_Prompt, Status_Message, API_Model, Retry_Status)
}

FindActionItems(*) {
    ChatGPT_Prompt := "Find action items that needs to be done and present them in a list:"
    Status_Message := "Finding action items..."
    API_Model := "gpt-4o-mini"
    ProcessRequest(ChatGPT_Prompt, Status_Message, API_Model, Retry_Status)
}

TranslateToEnglish(*) {
    ChatGPT_Prompt := "Generate an English translation for the following text or paragraph, ensuring the translation accurately conveys the intended meaning or idea without excessive deviation. The translation should preserve the tone, style, and formatting of the original text. If possible, split it into paragraphs to improve readability. Additionally, correct any grammar and spelling errors you come across:"
    Status_Message := "Translating to English..."
    API_Model := "gpt-4o"
    ProcessRequest(ChatGPT_Prompt, Status_Message, API_Model, Retry_Status)
}

Reply(*) {
    ChatGPT_Prompt := "Reply to the following message:"
    Status_Message := "Replying..."
    API_Model := "gpt-4o-mini"
    ProcessRequest(ChatGPT_Prompt, Status_Message, API_Model, Retry_Status)
}

Define(*) {
    ChatGPT_Prompt := "Define the following:"
    Status_Message := "Defining..."
    API_Model := "gpt-4o"
    ProcessRequest(ChatGPT_Prompt, Status_Message, API_Model, Retry_Status)
}

Opinion(*) {
    ChatGPT_Prompt := "What is your opinion on this:"
    Status_Message := "Thinking..."
    API_Model := "gpt-4o-mini"
    ProcessRequest(ChatGPT_Prompt, Status_Message, API_Model, Retry_Status)
}

/*
====================================================
Create Response Window
====================================================
*/

Response_Window := Gui("-Caption", "Response")
Response_Window.BackColor := "0x212529"
Response_Window.SetFont("s13 cWhite", "Bookerly")
Placeholder := Response_Window.Add("Text", "x+20 h580 w580")
RetryButton := Response_Window.Add("Button", "x190 Disabled", "Retry")
RetryButton.OnEvent("Click", Retry)
CopyButton := Response_Window.Add("Button", "x+30 w80 Disabled", "Copy")
CopyButton.OnEvent("Click", Copy)
Response_Window.Add("Button", "x+30", "Close").OnEvent("Click", Close)
Response_Window.Show("AutoSize Center")
WebView := WebView2.create(Placeholder.Hwnd)
HTML_Preview := 'file:///' A_LineFile '\..\markdown.html'
If WinActive("ahk_exe AutoHotkey64.exe" && "Response") {
    Response_Window.Hide
}

/*
====================================================
Buttons
====================================================
*/

Retry(*) {
    Retry_Status := "Retry"
    RetryButton.Enabled := 0
    CopyButton.Enabled := 0
    CopyButton.Text := "Copy"
    ProcessRequest(Previous_ChatGPT_Prompt, Previous_Status_Message, Previous_API_Model, Retry_Status)
}

Copy(*) {
    A_Clipboard := Response
    CopyButton.Enabled := 0
    CopyButton.Text := "Copied!"

    DllCall("SetFocus", "Ptr", 0)
    Sleep 2000

    CopyButton.Enabled := 1
    CopyButton.Text := "Copy"
}

Close(*) {
    HTTP_Request.Abort
    Response_Window.Hide
    global Response_Window_Status := "Closed"
    global Response := ""
    UpdateContent()
}

/*
====================================================
Connect to ChatGPT API and process request
====================================================
*/

ProcessRequest(ChatGPT_Prompt, Status_Message, API_Model, Retry_Status) {
    if (Retry_Status != "Retry") {
        A_Clipboard := ""
        Send "^c"
        if !ClipWait(2) {
            MsgBox "The attempt to copy text onto the clipboard failed."
            return
        }
        CopiedText := A_Clipboard
        ChatGPT_Prompt :=  ChatGPT_Prompt "`n`n"  "`"" CopiedText "`""
        ChatGPT_Prompt := RegExReplace(ChatGPT_Prompt, '(\\|")+', '\$1') ; Clean back spaces and quotes
        ChatGPT_Prompt := RegExReplace(ChatGPT_Prompt, "`n", "\n") ; Clean newlines
        ChatGPT_Prompt := RegExReplace(ChatGPT_Prompt, "`r", "") ; Remove carriage returns
        ChatGPT_Prompt := RegExReplace(ChatGPT_Prompt, "	", " ") ; Remove tabs
        global Previous_ChatGPT_Prompt := ChatGPT_Prompt
        global Previous_Status_Message := Status_Message
        global Previous_API_Model := API_Model
        global Response_Window_Status
    }

    OnMessage 0x200, WM_MOUSEHOVER
    Response := Status_Message
    UpdateContent()
    if (Response_Window_Status = "Closed") {
        Response_Window.Show("AutoSize Center")
        Response_Window_Status := "Open"
        RetryButton.Enabled := 0
        CopyButton.Enabled := 0
    }
    DllCall("SetFocus", "Ptr", 0)

    global HTTP_Request := ComObject("WinHttp.WinHttpRequest.5.1")
    HTTP_Request.open("POST", API_URL, true)
    HTTP_Request.SetRequestHeader("Content-Type", "application/json")
    HTTP_Request.SetRequestHeader("Authorization", "Bearer " API_Key)
    Messages := '{ "role": "user", "content": "' ChatGPT_Prompt '" }'
    JSON_Request := '{ "model": "' API_Model '", "messages": [' Messages '] }'
    HTTP_Request.SetTimeouts(60000, 60000, 60000, 60000)
    HTTP_Request.Send(JSON_Request)
    SetTimer LoadingCursor, 1
    if WinExist("Response") {
        WinActivate "Response"
    }
    HTTP_Request.WaitForResponse
    try {
        if (HTTP_Request.status == 200) {
            SafeArray := HTTP_Request.responseBody
            pData := NumGet(ComObjValue(SafeArray) + 8 + A_PtrSize, 'Ptr')
            length := SafeArray.MaxIndex() + 1
            JSON_Response := StrGet(pData, length, 'UTF-8')
            var := Jxon_Load(&JSON_Response)
            JSON_Response := var.Get("choices")[1].Get("message").Get("content")
            RetryButton.Enabled := 1
            CopyButton.Enabled := 1
            global Response := JSON_Response

            SetTimer LoadingCursor, 0
            OnMessage 0x200, WM_MOUSEHOVER, 0
            Cursor := DllCall("LoadCursor", "uint", 0, "uint", 32512) ; Arrow cursor
            DllCall("SetCursor", "UPtr", Cursor)

            Response_Window.Flash()
            DllCall("SetFocus", "Ptr", 0)
        } else {
            RetryButton.Enabled := 1
            CopyButton.Enabled := 1
            Response := "Status " HTTP_Request.status " " HTTP_Request.responseText

            SetTimer LoadingCursor, 0
            OnMessage 0x200, WM_MOUSEHOVER, 0
            Cursor := DllCall("LoadCursor", "uint", 0, "uint", 32512) ; Arrow cursor
            DllCall("SetCursor", "UPtr", Cursor)

            Response_Window.Flash()
            DllCall("SetFocus", "Ptr", 0)
        }
        UpdateContent()
    }
}

/*
====================================================
Update content of GUI
====================================================
*/

UpdateContent(*) {
    content := StrReplace(Response, "\", "\\")
    content := StrReplace(content, "``", "\``")
    script_content := "var textcontent = ``" content "``"
    render_script := '
    (
        document.addEventListener("DOMContentLoaded", () => {
            const md = markdownit({ html: true })
                .use(texmath, {
                    engine: katex,
                    delimiters: "dollars",
                    katexOptions: {
                        macros: {
                            "\\RR": "\\mathbb{R}"
                        } 
                    }
                });
            out.innerHTML = md.render(textcontent);
        });
        )'
WebView.CoreWebView2.Navigate(HTML_Preview)
WebView.CoreWebView2.ExecuteScript(script_content, 0)
WebView.CoreWebView2.ExecuteScript(render_script, 0)
}

/*
====================================================
Cursors
====================================================
*/

WM_MOUSEHOVER(*) {
    Cursor := DllCall("LoadCursor", "uint", 0, "uint", 32648) ; Unavailable cursor
    MouseGetPos ,,, &MousePosition
    if (CopyButton.Enabled = 0) & (MousePosition = "Button2") {
        DllCall("SetCursor", "UPtr", Cursor)
    } else if (RetryButton.Enabled = 0) & (MousePosition = "Button1") | (MousePosition = "Button2") {
        DllCall("SetCursor", "UPtr", Cursor)
    }
}

LoadingCursor() {
    MouseGetPos ,,, &MousePosition
    if (MousePosition = "Intermediate D3D Window1") {
        Cursor := DllCall("LoadCursor", "uint", 0, "uint", 32514) ; Loading cursor
        DllCall("SetCursor", "UPtr", Cursor)
    }
}

/*
====================================================
Hotkeys
====================================================
*/

`::MenuPopup.Show()

#HotIf WinActive("ahk_exe AutoHotkey64.exe" && "Response")
~Esc::Close()

#HotIf

#SuspendExempt
CapsLock & `:: {
    KeyWait "CapsLock", "L"
    KeyWait "``", "L"
    SetCapsLockState "Off"
    Toggle_Suspend(A_IsSuspended)
}
