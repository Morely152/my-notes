@echo off
:: 检查是否以管理员身份运行
net session >nul 2>&1 || (
    powershell -Command "Start-Process -Verb RunAs -WindowStyle Hidden -FilePath '%~f0'"
    exit /b
)

:: 获取日期和时间
for /f "tokens=1-3 delims=/ " %%a in ("%date%") do (
    set year=%%a
    set month=%%b
    set day=%%c
)
:: 提取年份后两位
set year=%year:~-2%
:: 确保月份和日期是两位数
if %month% lss 10 set month=%month%
if %day% lss 10 set day=%day%
:: 获取时间
for /f "tokens=1-3 delims=:. " %%a in ("%time%") do (
    set hour=%%a
    set minute=%%b
    set second=%%c
)
:: 确保时间是两位数
if %hour% lss 10 set hour=0%hour%
if %minute% lss 10 set minute=0%minute%
if %second% lss 10 set second=0%second%
set date_str=%year%%month%%day% %hour%:%minute%:%second%

:: Git操作
cd /d D:\hc\my_notes
git add . && git commit -m "%date_str% auto-commit" && git push origin main

:: 发送通知
powershell -Command "& {[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.MessageBox]::Show('Auto commit notes OK at %date_str%', 'Git Auto Commiter')}"