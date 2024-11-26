; 用快捷键打开或切换到预定的软件窗口
; 仅支持任务栏中有窗口的程序（不支持缩小后只存在于托盘的那些）

#NoEnv
#SingleInstance force
#WinActivateForce
#UseHook
#InstallKeybdHook
;SendMode Input

global updatedAt := "20240220"
global applications := {}
global configFile := A_ScriptDir . "\appkeyable.ini"

if !FileExist(configFile)
{
  text = 
(
;; 用逗号分隔3项：键, 进程名, 启动器，逗号前后可以有空白，路径中不能出现非英文字符
;; 双分号开头的行将被忽略
;; CapsLock + / 已被用于显示帮助信息（/ 和 ? 同键位）
;; 例：
;; c, chrome.exe, C:\Program Files\Google\Chrome\Application\chrome.exe"

)
  FileAppend, %text%, %configFile%
}

Loop, Read, %configFile%
{
  params := StrSplit(A_LoopReadLine, ",")
  ; 排除不足3项、以双分号开头、按键是“/”的行，“/”被绑给帮助窗口了
  if(params.Length() < 3 or RegExMatch(A_LoopReadLine, "^\s*;;") or RegExMatch(A_LoopReadLine, "^\s*/"))
      continue
  hotkey := "Capslock & " . Trim(params[1])
  function := Func("LaunchOrFocus").Bind({ select: "ahk_exe " . Trim(params[2]), run: Trim(params[3]) })
  Hotkey, ~%hotkey%, % function
  applications[params[1]] := params[2]
}

Capslock & /::ShowAppShortcuts()

;; 运行或切换到指定的程序窗口
LaunchOrFocus(configuration) {
  SetCapsLockState, On ; 关闭 CapsLock （即设为未亮灯状态；为什么是 On 而不是 Off？因为： 莫名地 Off 不能关闭，而 On 能关闭）
  selector := configuration["select"]
  if (selector and WinExist(selector)) {
    if (WinActive(selector)) {
      WinActivateBottom % selector
    } else {
      WinActivate
    }
  } else {
    Run % configuration["run"]
  }
}

;; 显示帮助信息
ShowAppShortcuts() {
  message := ""
  For key, value in applications {
    message := message . key . " -> " . value . "`n"
  }
  message := message = "" ? "请先在 " . configFile . " 中配置程序快捷键" : "用 CapsLock + {key} 打开这些程序：`n" . message
  MsgBox, 0, Help v%updatedAt%, % message, 30
  SetCapsLockState, Off
}

;; eof
