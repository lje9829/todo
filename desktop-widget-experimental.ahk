#Requires AutoHotkey v2.0
#SingleInstance Force
; Chrome을 기본 프로필로 실행하여 GitHub Pages의 기존 localStorage를 사용합니다.
url := "https://lje9829.github.io/todo/today.html"
chrome := "chrome.exe"
Run('"' chrome '" --app="' url '" --window-size=400,720')
if !WinWait("오늘의 할 일", , 20) {
    MsgBox "오늘의 할 일 창을 찾지 못했습니다. Chrome이 설치되어 있는지 확인해 주세요."
    ExitApp
}
hwnd := WinExist("오늘의 할 일")
WinMove(20, 80, 400, 720, "ahk_id " hwnd)
; 바탕화면 레이어로 창을 옮기는 실험적 방법. Windows 버전에 따라 작동이 다를 수 있습니다.
progman := DllCall("FindWindowW", "Str", "Progman", "Ptr", 0, "Ptr")
if !progman {
    MsgBox "바탕화면 창을 찾지 못했습니다. 일반 Chrome 앱 창으로 사용해 주세요."
    ExitApp
}
result := DllCall("SetParent", "Ptr", hwnd, "Ptr", progman, "Ptr")
if !result {
    MsgBox "바탕화면 고정이 실패했습니다. 일반 Chrome 앱 창으로 사용해 주세요."
}
