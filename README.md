# 用快捷键打开或切换到指定软件的窗口

## 用法

按下 `CapsLock + 字母` 可打开程序或在程序的已打开窗口中循环切换 `appkeyable.ini` 中配置的程序。

注：

* 脚本为 AHK v1，请安装 [AutoHotKey v1](https://www.autohotkey.com/)
* 未打开程序时执行打开程序的操作
* 已打开时在打开的程序窗口中循环切换
* 不支持任务栏中没有窗口的程序
* 部分程序比较怪异可能切换不到其窗口（比如阿里钉钉）
* `appkeyable.ini` 不存在时会自动创建，修改这个配置后需要再次运行 `appkeyable.ahk` (不需要先退出，直接双击运行即可)
* `appkeyable.ahk` 可以改名，改名后会寻找同前缀的 `.ini` 文件（比如改为 `picker.ahk` 后会去找 `picker.ini`）
* `f` 和 `/` 已被占用：
  * `CapsLock + f` 用于打开资源管理器、在资源管理器窗口间切换；
  * `CapsLock + /` 用于显示帮助信息

## 配置

见 `appkeyable.ini`
