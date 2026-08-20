@echo off
chcp 65001 >nul
title MariaDB Service Manager

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell.exe -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:MENU
cls
echo(
echo ========================================
echo          MariaDB 服务管理工具
echo ========================================
echo(
echo [1] 启动 MariaDB
echo [2] 关闭 MariaDB
echo [3] 重启 MariaDB
echo [4] 查看 MariaDB 状态
echo [5] EXIT
echo(
echo ========================================
echo(

set "choice="
set /p "choice=请输入选项："

if "%choice%"=="1" goto START
if "%choice%"=="2" goto STOP
if "%choice%"=="3" goto RESTART
if "%choice%"=="4" goto STATUS
if "%choice%"=="5" goto EXIT

echo(
echo 输入错误，请输入 1、2、3、4 或 5。
timeout /t 2 /nobreak >nul
goto MENU


:START
cls
echo(
echo ========================================
echo          正在启动 MariaDB
echo ========================================
echo(

net start MariaDB

echo(
echo ========================================
echo(
pause
goto MENU


:STOP
cls
echo(
echo ========================================
echo          正在关闭 MariaDB
echo ========================================
echo(

net stop MariaDB

echo(
echo ========================================
echo(
pause
goto MENU


:RESTART
cls
echo(
echo ========================================
echo          正在重启 MariaDB
echo ========================================
echo(

echo [1/2] 正在关闭 MariaDB...
net stop MariaDB

echo(
echo [2/2] 正在启动 MariaDB...
net start MariaDB

echo(
echo ========================================
echo          重启操作完成
echo ========================================
echo(
pause
goto MENU


:STATUS
cls
echo(
echo ========================================
echo          MariaDB 服务状态
echo ========================================
echo(

sc query MariaDB

echo(
echo ========================================
echo(
pause
goto MENU


:EXIT
cls
echo(
echo MariaDB Service Manager
echo(
echo 正在退出...
timeout /t 1 /nobreak >nul
exit /b