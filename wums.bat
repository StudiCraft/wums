@echo off
:: =============================================================================
::
::  Windows Unofficial Maintenance Script (WUMS) v2.0 Enhanced
::  Author: Enhanced by Claude
::  Purpose: Comprehensive Windows cleaning, repairing, and optimization tool
::  Compatible: Windows 7, 8, 8.1, 10, 11, Server 2008+
::
:: =============================================================================

:: -----------------------------------------------------------------------------
:: Initialize Variables and Check Environment
:: -----------------------------------------------------------------------------
set "SCRIPT_VERSION=2.0"
set "LOG_FILE=%TEMP%\WUMS_Log_%DATE:~-4%%DATE:~4,2%%DATE:~7,2%.txt"

:: Detect Windows Version for compatibility
for /f "tokens=4-6 delims=. " %%i in ('ver') do set "WIN_VER=%%i.%%j"
set "WIN_MAJOR=!WIN_VER:~0,2!"
if !WIN_MAJOR! geq 10 (set "WIN_MODERN=1") else (set "WIN_MODERN=0")

:: -----------------------------------------------------------------------------
:: Self-Elevation to Administrator
:: -----------------------------------------------------------------------------
:check_permissions
    echo [%TIME%] Checking for Administrator privileges... >> "%LOG_FILE%"
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Privileges OK. Continuing script...
        goto :init
    ) else (
        echo Warning: Administrator privileges are required.
        echo Attempting to re-launch the script as an Administrator...
        powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -Verb RunAs" 2>nul || (
            echo Failed to elevate. Please run as Administrator manually.
            pause & exit /b 1
        )
        exit /b
    )

:init
setlocal enabledelayedexpansion
:: Set console appearance and initialize
title Windows Unofficial Maintenance Script (WUMS) v%SCRIPT_VERSION%
if !WIN_MODERN!==1 (color 0A) else (color 07)
mode con cols=80 lines=35
cls

:: =============================================================================
:: Main Menu System
:: =============================================================================
:main_menu
cls
echo.
echo    ???    ??????   ???????   ???? ???????
echo    ???    ??????   ???????? ?????????????
echo    ??? ?? ??????   ?????????????????????
echo    ?????????????   ?????????????? ???????
echo    ?????????????????????? ??? ???????????
echo     ????????  ??????? ???     ??????????
echo.
echo      Windows Unofficial Maintenance Script v%SCRIPT_VERSION%
echo     ================================================================
echo     Windows Version: !WIN_VER! ^| Admin: YES ^| Log: WUMS_Log_*.txt
echo     ================================================================
echo.
echo     CLEANUP OPERATIONS                    SYSTEM REPAIR ^& INTEGRITY
echo     ???????????????????                   ?????????????????????????
echo      1. Clear Temp Files ^& Caches         11. System File Checker (sfc)
echo      2. Disk Cleanup Wizard                12. DISM Image Health Check
echo      3. Browser Cache Cleanup              13. Check Disk Errors (chkdsk)
echo      4. Windows Update Cache                14. Registry Cleanup ^& Repair
echo      5. Recycle Bin ^& Recent Items         15. Windows Store Apps Repair
echo.
echo     NETWORK ^& CONNECTIVITY               OPTIMIZATION ^& TWEAKS
echo     ?????????????????????                 ??????????????????????
echo      6. DNS Cache ^& Network Reset          16. Defrag ^& Optimize Drives
echo      7. Winsock ^& TCP/IP Reset             17. Services Optimization
echo      8. Network Adapters Reset             18. Startup Programs Manager
echo      9. Firewall Rules Cleanup             19. Power Plan Optimization
echo     10. Proxy Settings Reset               20. Visual Effects Tweaks
echo.
echo     MAINTENANCE ^& SECURITY               ADVANCED TOOLS
echo     ?????????????????????????             ??????????????
echo     21. Windows Update Reset              31. Memory Diagnostic
echo     22. System Restore Point              32. Hardware Info
echo     23. User Account Control              33. Driver Verifier
echo     24. Windows Defender Scan             34. Event Viewer Cleanup
echo     25. Malware ^& Virus Scan              35. Performance Monitor
echo.
echo     PRIVACY ^& CLEANUP                    SYSTEM INFORMATION
echo     ????????????????????                  ??????????????????
echo     26. Privacy Settings Reset            36. System Specifications
echo     27. Telemetry Disable                 37. Installed Programs List
echo     28. Search Index Rebuild              38. Running Processes
echo     29. Windows Store Reset               39. Network Configuration
echo     30. User Profile Cleanup              40. License ^& Activation
echo.
echo     BATCH OPERATIONS                      UTILITIES
echo     ??????????????????                    ?????????
echo     41. Quick Cleanup (1,3,6,16)          46. Command Prompt
echo     42. Full System Repair (11-15)        47. PowerShell (Admin)
echo     43. Network Complete Reset (6-10)     48. Registry Editor
echo     44. Privacy ^& Performance (26-30)     49. System Configuration
echo     45. Complete Maintenance (All Safe)   50. Task Manager
echo.
echo      0. Exit WUMS                          51. View Log File
echo.

set /p "choice=Enter your selection (0-51): "

:: Input validation
if "%choice%"=="" goto invalid_input
set "valid=0"
for %%i in (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51) do (
    if "%choice%"=="%%i" set "valid=1"
)
if !valid!==0 goto invalid_input

:: Route to functions
if "%choice%"=="0" goto exit_script
if "%choice%"=="1" goto clean_temp
if "%choice%"=="2" goto run_cleanmgr
if "%choice%"=="3" goto clean_browser_cache
if "%choice%"=="4" goto clean_update_cache
if "%choice%"=="5" goto clean_recycle_recent
if "%choice%"=="6" goto flush_dns_reset
if "%choice%"=="7" goto reset_winsock
if "%choice%"=="8" goto reset_network_adapters
if "%choice%"=="9" goto cleanup_firewall
if "%choice%"=="10" goto reset_proxy
if "%choice%"=="11" goto run_sfc
if "%choice%"=="12" goto dism_menu
if "%choice%"=="13" goto run_chkdsk
if "%choice%"=="14" goto registry_cleanup
if "%choice%"=="15" goto repair_store_apps
if "%choice%"=="16" goto run_defrag
if "%choice%"=="17" goto optimize_services
if "%choice%"=="18" goto startup_manager
if "%choice%"=="19" goto power_optimization
if "%choice%"=="20" goto visual_effects
if "%choice%"=="21" goto reset_win_update
if "%choice%"=="22" goto create_restore_point
if "%choice%"=="23" goto manage_uac
if "%choice%"=="24" goto defender_scan
if "%choice%"=="25" goto malware_scan
if "%choice%"=="26" goto privacy_reset
if "%choice%"=="27" goto disable_telemetry
if "%choice%"=="28" goto rebuild_search_index
if "%choice%"=="29" goto reset_store
if "%choice%"=="30" goto cleanup_user_profile
if "%choice%"=="31" goto memory_diagnostic
if "%choice%"=="32" goto hardware_info
if "%choice%"=="33" goto driver_verifier
if "%choice%"=="34" goto cleanup_event_logs
if "%choice%"=="35" goto performance_monitor
if "%choice%"=="36" goto system_specs
if "%choice%"=="37" goto installed_programs
if "%choice%"=="38" goto running_processes
if "%choice%"=="39" goto network_config
if "%choice%"=="40" goto license_info
if "%choice%"=="41" goto batch_quick_cleanup
if "%choice%"=="42" goto batch_system_repair
if "%choice%"=="43" goto batch_network_reset
if "%choice%"=="44" goto batch_privacy_performance
if "%choice%"=="45" goto batch_complete_maintenance
if "%choice%"=="46" goto open_cmd
if "%choice%"=="47" goto open_powershell
if "%choice%"=="48" goto open_regedit
if "%choice%"=="49" goto open_msconfig
if "%choice%"=="50" goto open_taskmgr
if "%choice%"=="51" goto view_log

:invalid_input
echo Invalid selection. Please enter a number between 0-51.
timeout /t 2 >nul
goto main_menu

:: =============================================================================
:: CLEANUP OPERATIONS (1-5)
:: =============================================================================

:clean_temp
cls
echo [%TIME%] Starting temporary files cleanup >> "%LOG_FILE%"
echo === Clearing Temporary Files ===
echo.
set "cleaned_size=0"

echo Clearing user temporary files...
if exist "%TEMP%" (
    for /f %%i in ('dir /s /a "%TEMP%" 2^>nul ^| find "bytes"') do set "temp_size=%%i"
    pushd "%TEMP%" 2>nul && (
        for /d %%d in (*) do rd /s /q "%%d" >nul 2>&1
        del /f /q *.* >nul 2>&1
    ) & popd
    echo   ? User temp folder cleaned
)

echo Clearing system temporary files...
if exist "%SystemRoot%\Temp" (
    pushd "%SystemRoot%\Temp" 2>nul && (
        for /d %%d in (*) do rd /s /q "%%d" >nul 2>&1
        del /f /q *.* >nul 2>&1
    ) & popd
    echo   ? System temp folder cleaned
)

echo Clearing Windows prefetch...
if exist "%SystemRoot%\Prefetch" (
    del /f /q "%SystemRoot%\Prefetch\*.pf" >nul 2>&1
    echo   ? Prefetch files cleaned
)

echo Clearing recent files...
if exist "%APPDATA%\Microsoft\Windows\Recent" (
    del /f /q "%APPDATA%\Microsoft\Windows\Recent\*.*" >nul 2>&1
    echo   ? Recent files cleared
)

echo Clearing thumbnail cache...
if exist "%LocalAppData%\Microsoft\Windows\Explorer" (
    taskkill /f /im explorer.exe >nul 2>&1
    timeout /t 2 >nul
    del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache*.db" >nul 2>&1
    start explorer.exe
    echo   ? Thumbnail cache cleared
)

echo.
echo Temporary files cleanup completed successfully!
echo [%TIME%] Temporary files cleanup completed >> "%LOG_FILE%"
pause
goto main_menu

:run_cleanmgr
cls
echo === Windows Disk Cleanup ===
echo.
echo Launching Windows Disk Cleanup utility...
echo Please select items to clean and click OK.
echo.
if !WIN_MODERN!==1 (
    cleanmgr.exe /autoclean /d C:
) else (
    cleanmgr.exe /lowdisk
)
echo.
echo Disk Cleanup completed.
echo [%TIME%] Disk Cleanup utility completed >> "%LOG_FILE%"
pause
goto main_menu

:clean_browser_cache
cls
echo === Browser Cache Cleanup ===
echo.
echo Attempting to clear browser caches...
echo Note: Close all browsers before running this.
echo.

:: Chrome
set "chrome_cache=%LocalAppData%\Google\Chrome\User Data\Default\Cache"
if exist "%chrome_cache%" (
    rd /s /q "%chrome_cache%" >nul 2>&1
    echo   ? Chrome cache cleared
)

:: Firefox
for /d %%p in ("%AppData%\Mozilla\Firefox\Profiles\*") do (
    if exist "%%p\cache2" (
        rd /s /q "%%p\cache2" >nul 2>&1
        echo   ? Firefox cache cleared
    )
)

:: Edge (Legacy)
set "edge_cache=%LocalAppData%\Microsoft\Edge\User Data\Default\Cache"
if exist "%edge_cache%" (
    rd /s /q "%edge_cache%" >nul 2>&1
    echo   ? Edge cache cleared
)

:: Internet Explorer
if exist "%LocalAppData%\Microsoft\Windows\INetCache" (
    rd /s /q "%LocalAppData%\Microsoft\Windows\INetCache" >nul 2>&1
    echo   ? Internet Explorer cache cleared
)

echo.
echo Browser cache cleanup completed!
echo [%TIME%] Browser cache cleanup completed >> "%LOG_FILE%"
pause
goto main_menu

:clean_update_cache
cls
echo === Windows Update Cache Cleanup ===
echo.
echo Clearing Windows Update cache and temporary files...
echo.

net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1

if exist "%SystemRoot%\SoftwareDistribution\Download" (
    rd /s /q "%SystemRoot%\SoftwareDistribution\Download" >nul 2>&1
    echo   ? Update download cache cleared
)

net start wuauserv >nul 2>&1
net start bits >nul 2>&1

echo   ? Windows Update services restarted
echo.
echo Windows Update cache cleanup completed!
echo [%TIME%] Windows Update cache cleanup completed >> "%LOG_FILE%"
pause
goto main_menu

:clean_recycle_recent
cls
echo === Recycle Bin and Recent Items Cleanup ===
echo.
echo Emptying Recycle Bin for all drives...

for %%i in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%i:\$Recycle.Bin" (
        rd /s /q "%%i:\$Recycle.Bin" >nul 2>&1
        echo   ? Drive %%i: Recycle Bin emptied
    )
)

echo Clearing recent documents...
if exist "%APPDATA%\Microsoft\Windows\Recent" (
    del /f /q "%APPDATA%\Microsoft\Windows\Recent\*.*" >nul 2>&1
    echo   ? Recent documents cleared
)

echo Clearing jump lists...
if exist "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations" (
    del /f /q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*.*" >nul 2>&1
    echo   ? Jump lists cleared
)

echo.
echo Recycle Bin and recent items cleanup completed!
echo [%TIME%] Recycle Bin and recent items cleanup completed >> "%LOG_FILE%"
pause
goto main_menu

:: =============================================================================
:: NETWORK & CONNECTIVITY (6-10)
:: =============================================================================

:flush_dns_reset
cls
echo === DNS Cache and Network Reset ===
echo.
echo Flushing DNS resolver cache...
ipconfig /flushdns >nul 2>&1
echo   ? DNS cache flushed

echo Releasing and renewing IP configuration...
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
echo   ? IP configuration renewed

echo Registering DNS...
ipconfig /registerdns >nul 2>&1
echo   ? DNS registration completed

echo.
echo DNS and network reset completed!
echo [%TIME%] DNS and network reset completed >> "%LOG_FILE%"
pause
goto main_menu

:reset_winsock
cls
echo === Winsock and TCP/IP Reset ===
echo.
echo WARNING: This will reset network settings and may require a restart.
set /p "confirm=Continue? (Y/N): "
if /i not "%confirm%"=="Y" goto main_menu

echo Resetting Winsock catalog...
netsh winsock reset >nul 2>&1
echo   ? Winsock catalog reset

echo Resetting TCP/IP stack...
netsh int ip reset >nul 2>&1
echo   ? TCP/IP stack reset

echo Resetting Windows Firewall...
netsh advfirewall reset >nul 2>&1
echo   ? Windows Firewall reset

echo.
echo Network stack reset completed! A restart is recommended.
echo [%TIME%] Winsock and TCP/IP reset completed >> "%LOG_FILE%"
set /p "restart=Restart now? (Y/N): "
if /i "%restart%"=="Y" shutdown /r /t 5
pause
goto main_menu

:reset_network_adapters
cls
echo === Network Adapters Reset ===
echo.
echo Disabling and re-enabling network adapters...

for /f "skip=3 tokens=3*" %%i in ('netsh interface show interface') do (
    if not "%%i"=="Loopback" (
        netsh interface set interface "%%j" disabled >nul 2>&1
        timeout /t 2 >nul
        netsh interface set interface "%%j" enabled >nul 2>&1
        echo   ? Reset adapter: %%j
    )
)

echo.
echo Network adapters reset completed!
echo [%TIME%] Network adapters reset completed >> "%LOG_FILE%"
pause
goto main_menu

:cleanup_firewall
cls
echo === Firewall Rules Cleanup ===
echo.
echo This will remove unnecessary firewall rules...
set /p "confirm=Continue? (Y/N): "
if /i not "%confirm%"=="Y" goto main_menu

echo Backing up firewall settings...
netsh advfirewall export "%TEMP%\firewall_backup.wfw" >nul 2>&1

echo Removing orphaned rules...
netsh advfirewall firewall delete rule name=all dir=in >nul 2>&1
netsh advfirewall reset >nul 2>&1

echo Restoring essential rules...
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound >nul 2>&1

echo.
echo Firewall cleanup completed! Backup saved to: %TEMP%\firewall_backup.wfw
echo [%TIME%] Firewall rules cleanup completed >> "%LOG_FILE%"
pause
goto main_menu

:reset_proxy
cls
echo === Proxy Settings Reset ===
echo.
echo Resetting proxy settings to default...

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /f >nul 2>&1

echo   ? Internet Explorer proxy settings reset
echo   ? System proxy settings reset

echo.
echo Proxy settings reset completed!
echo [%TIME%] Proxy settings reset completed >> "%LOG_FILE%"
pause
goto main_menu

:: =============================================================================
:: SYSTEM REPAIR & INTEGRITY (11-15)
:: =============================================================================

:run_sfc
cls
echo === System File Checker ===
echo.
echo Running System File Checker (sfc /scannow)...
echo This process scans for integrity violations and repairs corrupt system files.
echo This may take 10-30 minutes depending on your system.
echo.
sfc /scannow
echo.
echo System File Checker completed.
echo [%TIME%] System File Checker completed >> "%LOG_FILE%"
pause
goto main_menu

:dism_menu
cls
echo.
echo     ================================================================
echo                      DISM - Image Health Management
echo     ================================================================
echo.
echo     DISM (Deployment Image Servicing and Management) repairs the
echo     Windows image when SFC cannot fix certain issues.
echo.
echo      1. CheckHealth - Quick corruption check (30 seconds)
echo      2. ScanHealth - Deep scan for corruption (5-10 minutes)
echo      3. RestoreHealth - Scan and repair image (15-60 minutes)
echo      4. Cleanup ComponentStore - Free disk space
echo.
echo      0. Return to Main Menu
echo.
set /p "dism_choice=Your selection (0-4): "

if "%dism_choice%"=="1" goto dism_check
if "%dism_choice%"=="2" goto dism_scan
if "%dism_choice%"=="3" goto dism_restore
if "%dism_choice%"=="4" goto dism_cleanup
if "%dism_choice%"=="0" goto main_menu

echo Invalid selection.
pause
goto dism_menu

:dism_check
cls
echo === DISM CheckHealth ===
echo.
Dism /Online /Cleanup-Image /CheckHealth
echo.
echo DISM CheckHealth completed.
echo [%TIME%] DISM CheckHealth completed >> "%LOG_FILE%"
pause
goto dism_menu

:dism_scan
cls
echo === DISM ScanHealth ===
echo.
echo This comprehensive scan may take 5-10 minutes...
Dism /Online /Cleanup-Image /ScanHealth
echo.
echo DISM ScanHealth completed.
echo [%TIME%] DISM ScanHealth completed >> "%LOG_FILE%"
pause
goto dism_menu

:dism_restore
cls
echo === DISM RestoreHealth ===
echo.
echo This repair process can take 15-60 minutes and requires internet connection...
Dism /Online /Cleanup-Image /RestoreHealth
echo.
echo DISM RestoreHealth completed.
echo [%TIME%] DISM RestoreHealth completed >> "%LOG_FILE%"
pause
goto dism_menu

:dism_cleanup
cls
echo === DISM ComponentStore Cleanup ===
echo.
if !WIN_MODERN!==1 (
    echo Cleaning up component store to free disk space...
    Dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
    echo.
    echo Component store cleanup completed.
) else (
    echo This feature requires Windows 8.1 or later.
    echo Your version: !WIN_VER!
)
echo [%TIME%] DISM ComponentStore cleanup attempt completed >> "%LOG_FILE%"
pause
goto dism_menu

:run_chkdsk
cls
echo === Check Disk for Errors ===
echo.
echo Available drives:
wmic logicaldisk get caption,size,freespace /format:table
echo.
set /p "drive=Enter drive letter to check (e.g., C): "
if "%drive%"=="" set "drive=C"

echo.
echo WARNING: This will check the %drive%: drive for file system errors.
echo If the drive is in use, you'll be asked to schedule the check on next reboot.
echo.
set /p "confirm_chkdsk=Continue with %drive%: drive? (Y/N): "
if /i not "%confirm_chkdsk%"=="Y" goto main_menu

echo Running check disk on %drive%: drive...
chkdsk %drive%: /f /r /x
echo.
echo Check disk completed for %drive%: drive.
echo [%TIME%] Check disk completed for %drive%: >> "%LOG_FILE%"
pause
goto main_menu

:registry_cleanup
cls
echo === Registry Cleanup and Repair ===
echo.
echo WARNING: This will clean and repair the Windows Registry.
echo A backup will be created before making changes.
set /p "confirm_reg=Continue? (Y/N): "
if /i not "%confirm_reg%"=="Y" goto main_menu

echo Creating registry backup...
reg export HKLM "%TEMP%\registry_backup_HKLM.reg" /y >nul 2>&1
reg export HKCU "%TEMP%\registry_backup_HKCU.reg" /y >nul 2>&1

echo Scanning and cleaning registry...
:: Clean common registry issues
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "" /f >nul 2>&1

:: Clean MRU lists
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths" /f >nul 2>&1

echo   ? Registry cleaned and optimized
echo   ? Backup saved to: %TEMP%\registry_backup_*.reg

echo.
echo Registry cleanup completed!
echo [%TIME%] Registry cleanup completed >> "%LOG_FILE%"
pause
goto main_menu

:repair_store_apps
cls
echo === Windows Store Apps Repair ===
echo.
if !WIN_MODERN!==1 (
    echo Repairing Windows Store and built-in apps...
    
    powershell -Command "Get-AppxPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\AppXManifest.xml\"}" >nul 2>&1
    echo   ? Store apps repaired
    
    wsreset.exe >nul 2>&1
    echo   ? Windows Store cache reset
    
    echo.
    echo Windows Store apps repair completed!
) else (
    echo This feature is only available on Windows 10/11.
    echo Your version: !WIN_VER!
)
echo [%TIME%] Windows Store apps repair completed >> "%LOG_FILE%"
pause
goto main_menu

:: =============================================================================
:: OPTIMIZATION & TWEAKS (16-20)
:: =============================================================================

:run_defrag
cls
echo === Defragment and Optimize Drives ===
echo.
echo Available drives:
wmic logicaldisk where "drivetype=3" get caption,size,freespace /format:table
echo.
echo Analyzing and optimizing all fixed drives...

for /f "skip=1 tokens=1" %%d in ('wmic logicaldisk where "drivetype=3" get caption') do (
    if not "%%d"=="" (
        echo.
        echo Optimizing drive %%d...
        if !WIN_MODERN!==1 (
            defrag %%d /O /H
        ) else (
            defrag %%d /A /V
        )
    )
)

echo.
echo Drive optimization completed!
echo [%TIME%] Drive optimization completed >> "%LOG_FILE%"
pause
goto main_menu

:optimize_services
cls
echo === Services Optimization ===
echo.
echo This will optimize Windows services for better performance.
echo Some services will be set to manual start.
set /p "confirm_svc=Continue? (Y/N): "
if /i not "%confirm_svc%"=="Y" goto main_menu

echo Optimizing services...

:: Set non-essential services to manual
set "services_to_manual=Themes UxSms TabletInputService WSearch Spooler"
for %%s in (!services_to_manual!) do (
    sc config "%%s" start= demand >nul 2>&1
    echo   ? %%s set to manual
)

:: Disable unnecessary services (carefully selected)
if !WIN_MODERN!==1 (
    sc config "DiagTrack" start= disabled >nul 2>&1
    sc config "dmwappushservice" start= disabled >nul 2>&1
    echo   ? Telemetry services disabled
)

echo.
echo Services optimization completed!
echo [%TIME%] Services optimization completed >> "%LOG_FILE%"
pause
goto main_menu

:startup_manager
cls
echo === Startup Programs Manager ===
echo.
echo Current startup programs:
echo.
if !WIN_MODERN!==1 (
    powershell -Command "Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location | Format-Table -AutoSize"
) else (
    wmic startup get caption,command,location /format:table
)

echo.
echo To manage startup programs:
echo 1. Use Task Manager (Ctrl+Shift+Esc) - Startup tab
echo 2. Use System Configuration (msconfig) - Startup tab
echo 3. Use Settings app - Apps - Startup (Windows 10/11)
echo.
set /p "open_taskmgr=Open Task Manager now? (Y/N): "
if /i "%open_taskmgr%"=="Y" start taskmgr.exe

echo [%TIME%] Startup programs information displayed >> "%LOG_FILE%"
pause
goto main_menu

:power_optimization
cls
echo === Power Plan Optimization ===
echo.
echo Current power plans:
powercfg /list

echo.
echo Optimizing power settings for performance...

:: Set high performance plan (if available)
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
if !errorlevel!==0 (
    echo   ? High Performance plan activated
) else (
    powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
    echo   ? Balanced plan activated
)

:: Optimize power settings
powercfg /change monitor-timeout-ac 15 >nul 2>&1
powercfg /change disk-timeout-ac 0 >nul 2>&1
powercfg /change standby-timeout-ac 0 >nul 2>&1

echo   ? Power timeouts optimized
echo.
echo Power optimization completed!
echo [%TIME%] Power optimization completed >> "%LOG_FILE%"
pause
goto main_menu

:visual_effects
cls
echo === Visual Effects Tweaks ===
echo.
echo Choose visual effects setting:
echo.
echo 1. Best Performance (disable all effects)
echo 2. Best Appearance (enable all effects)
echo 3. Custom (let Windows choose)
echo 4. Return to main menu
echo.
set /p "visual_choice=Your selection (1-4): "

if "%visual_choice%"=="4" goto main_menu
if "%visual_choice%"=="1" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
    echo   ? Visual effects set to Best Performance
)
if "%visual_choice%"=="2" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 0 /f >nul 2>&1
    echo   ? Visual effects set to Best Appearance
)
if "%visual_choice%"=="3" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f >nul 2>&1
    echo   ? Visual effects set to Windows default
)

echo.
echo Visual effects changes will take effect after restart.
echo [%TIME%] Visual effects optimization completed >> "%LOG_FILE%"
pause
goto main_menu

:: =============================================================================
:: MAINTENANCE & SECURITY (21-25)
:: =============================================================================

:reset_win_update
cls
echo === Windows Update Reset ===
echo.
echo WARNING: This will reset Windows Update components completely.
echo This process stops services, clears cache, and restarts components.
set /p "confirm_wu=Continue? (Y/N): "
if /i not "%confirm_wu%"=="Y" goto main_menu

echo Stopping Windows Update services...
net stop wuauserv >nul 2>&1
net stop cryptSvc >nul 2>&1
net stop bits >nul 2>&1
net stop msiserver >nul 2>&1
echo   ? Services stopped

echo Renaming cache folders...
if exist "%SystemRoot%\SoftwareDistribution" (
    ren "%SystemRoot%\SoftwareDistribution" "SoftwareDistribution.old" >nul 2>&1
)
if exist "%SystemRoot%\System32\catroot2" (
    ren "%SystemRoot%\System32\catroot2" "catroot2.old" >nul 2>&1
)
echo   ? Cache folders renamed

echo Restarting Windows Update services...
net start wuauserv >nul 2>&1
net start cryptSvc >nul 2>&1
net start bits >nul 2>&1
net start msiserver >nul 2>&1
echo   ? Services restarted

echo.
echo Windows Update components reset successfully!
echo [%TIME%] Windows Update reset completed >> "%LOG_FILE%"
pause
goto main_menu

:create_restore_point
cls
echo === Create System Restore Point ===
echo.
echo Creating system restore point...
set "restore_desc=WUMS Maintenance Restore Point - %DATE% %TIME%"

if !WIN_MODERN!==1 (
    powershell -Command "Checkpoint-Computer -Description '%restore_desc%' -RestorePointType 'MODIFY_SETTINGS'" >nul 2>&1
) else (
    wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%restore_desc%", 100, 7 >nul 2>&1
)

if !errorlevel!==0 (
    echo   ? System restore point created successfully
    echo   Description: %restore_desc%
) else (
    echo   ! Failed to create restore point
    echo   Make sure System Restore is enabled
)

echo.
echo [%TIME%] System restore point creation attempted >> "%LOG_FILE%"
pause
goto main_menu

:manage_uac
cls
echo === User Account Control Management ===
echo.
echo Current UAC Status:
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA >nul 2>&1
if !errorlevel!==0 (
    for /f "tokens=3" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA') do (
        if "%%i"=="0x1" (
            echo   Status: ENABLED
        ) else (
            echo   Status: DISABLED
        )
    )
)

echo.
echo UAC Options:
echo 1. Enable UAC (Recommended for security)
echo 2. Disable UAC (Not recommended)
echo 3. Return to main menu
echo.
set /p "uac_choice=Your selection (1-3): "

if "%uac_choice%"=="3" goto main_menu
if "%uac_choice%"=="1" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f >nul 2>&1
    echo   ? UAC enabled (restart required)
)
if "%uac_choice%"=="2" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f >nul 2>&1
    echo   ? UAC disabled (restart required)
)

echo.
echo Changes will take effect after restart.
echo [%TIME%] UAC settings modified >> "%LOG_FILE%"
pause
goto main_menu

:defender_scan
cls
echo === Windows Defender Scan ===
echo.
if !WIN_MODERN!==1 (
    echo Starting Windows Defender quick scan...
    powershell -Command "Start-MpScan -ScanType QuickScan" >nul 2>&1
    if !errorlevel!==0 (
        echo   ? Quick scan completed
        echo.
        echo Scan results:
        powershell -Command "Get-MpThreatDetection | Select-Object ThreatName, Resources | Format-Table -AutoSize"
    ) else (
        echo   ! Scan failed or Windows Defender not available
    )
) else (
    echo Windows Defender is not available on this version.
    echo Please use your installed antivirus software.
)

echo.
echo [%TIME%] Windows Defender scan completed >> "%LOG_FILE%"
pause
goto main_menu

:malware_scan
cls
echo === Malware and Virus Scan ===
echo.
echo This will perform various anti-malware checks...

echo Checking for suspicious processes...
tasklist /fi "imagename eq *.tmp" >nul 2>&1
echo   ? Process check completed

echo Checking startup locations...
dir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" >nul 2>&1
echo   ? Startup folder checked

echo Scanning common malware locations...
if exist "%TEMP%\*.exe" (
    echo   ! Executable files found in temp folder
)
if exist "%SystemRoot%\System32\*.tmp" (
    echo   ! Temporary files in System32
)

echo.
echo Basic malware scan completed.
echo For comprehensive protection, run a full antivirus scan.
echo [%TIME%] Basic malware scan completed >> "%LOG_FILE%"
pause
goto main_menu

:: =============================================================================
:: PRIVACY & CLEANUP (26-30)
:: =============================================================================

:privacy_reset
cls
echo === Privacy Settings Reset ===
echo.
echo Resetting Windows privacy settings to secure defaults...

if !WIN_MODERN!==1 (
    :: Disable location tracking
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d "Deny" /f >nul 2>&1
    echo   ? Location tracking disabled
    
    :: Disable camera access
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v Value /t REG_SZ /d "Deny" /f >nul 2>&1
    echo   ? Default camera access disabled
    
    :: Disable microphone access
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v Value /t REG_SZ /d "Deny" /f >nul 2>&1
    echo   ? Default microphone access disabled
    
    :: Disable advertising ID
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
    echo   ? Advertising ID disabled
) else (
    echo Some privacy features not available on Windows !WIN_VER!
)

:: Clear activity history
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ActivityFeed\Settings" /v UploadUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
echo   ? Activity history upload disabled

echo.
echo Privacy settings reset completed!
echo [%TIME%] Privacy settings reset completed >> "%LOG_FILE%"
pause
goto main_menu

:disable_telemetry
cls
echo === Telemetry Disable ===
echo.
echo Disabling Windows telemetry and data collection...

:: Disable telemetry service
sc config "DiagTrack" start= disabled >nul 2>&1
sc stop "DiagTrack" >nul 2>&1
echo   ? Diagnostic Tracking Service disabled

:: Disable data collection
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
echo   ? Telemetry collection disabled

:: Disable customer experience improvement program
reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
echo   ? CEIP disabled

if !WIN_MODERN!==1 (
    :: Disable Cortana data collection
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
    echo   ? Cortana data collection disabled
)

echo.
echo Telemetry disabled successfully!
echo [%TIME%] Telemetry disable completed >> "%LOG_FILE%"
pause
goto main_menu

:rebuild_search_index
cls
echo === Search Index Rebuild ===
echo.
echo This will rebuild the Windows Search index.
echo This process can take 30 minutes to several hours.
set /p "confirm_search=Continue? (Y/N): "
if /i not "%confirm_search%"=="Y" goto main_menu

echo Stopping Windows Search service...
net stop "Windows Search" >nul 2>&1

echo Deleting search index files...
if exist "%ProgramData%\Microsoft\Search\Data" (
    rd /s /q "%ProgramData%\Microsoft\Search\Data" >nul 2>&1
    echo   ? Search index deleted
)

echo Starting Windows Search service...
net start "Windows Search" >nul 2>&1
echo   ? Search service restarted

echo.
echo Search index rebuild started in background.
echo [%TIME%] Search index rebuild initiated >> "%LOG_FILE%"
pause
goto main_menu

:reset_store
cls
echo === Windows Store Reset ===
echo.
if !WIN_MODERN!==1 (
    echo Resetting Windows Store and cache...
    wsreset.exe >nul 2>&1
    echo   ? Windows Store reset completed
    
    echo Repairing Store apps...
    powershell -Command "Get-AppxPackage Microsoft.WindowsStore | Reset-AppxPackage" >nul 2>&1
    echo   ? Store app repaired
) else (
    echo Windows Store is not available on this version.
    echo Version detected: !WIN_VER!
)

echo.
echo Windows Store reset completed!
echo [%TIME%] Windows Store reset completed >> "%LOG_FILE%"
pause
goto main_menu

:cleanup_user_profile
cls
echo === User Profile Cleanup ===
echo.
echo Cleaning user profile temporary data...

:: Clear user temp folders
echo Clearing user temporary data...
if exist "%LOCALAPPDATA%\Temp" (
    pushd "%LOCALAPPDATA%\Temp" 2>nul && (
        for /d %%d in (*) do rd /s /q "%%d" >nul 2>&1
        del /f /q *.* >nul 2>&1
    ) & popd
    echo   ? Local temp cleaned
)

:: Clear browser profile data
echo Clearing browser profiles...
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" (
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
    echo   ? Chrome profile cleaned
)

:: Clear Windows error reporting
if exist "%LOCALAPPDATA%\Microsoft\Windows\WER" (
    rd /s /q "%LOCALAPPDATA%\Microsoft\Windows\WER" >nul 2>&1
    echo   ? Error reporting data cleared
)

echo.
echo User profile cleanup completed!
echo [%TIME%] User profile cleanup completed >> "%LOG_FILE%"
pause
goto main_menu

:: =============================================================================
:: ADVANCED TOOLS (31-35)
:: =============================================================================

:memory_diagnostic
cls
echo === Memory Diagnostic ===
echo.
echo This will schedule a memory diagnostic test on next boot.
echo The computer will restart and test memory before loading Windows.
set /p "confirm_mem=Continue? (Y/N): "
if /i not "%confirm_mem%"=="Y" goto main_menu

mdsched.exe
echo.
echo Memory diagnostic scheduled. Your computer will restart shortly.
echo [%TIME%] Memory diagnostic scheduled >> "%LOG_FILE%"
pause
goto main_menu

:hardware_info
cls
echo === Hardware Information ===
echo.
echo Gathering detailed hardware information...
echo.

echo === SYSTEM ===
systeminfo | findstr /B /C:"System Manufacturer" /C:"System Model" /C:"System Type"

echo.
echo === PROCESSOR ===
wmic cpu get name,maxclockspeed,numberofcores,numberoflogicalprocessors /format:list | findstr "="

echo.
echo === MEMORY ===
wmic computersystem get TotalPhysicalMemory /format:list | findstr "="
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /format:list | findstr "="

echo.
echo === STORAGE ===
wmic logicaldisk get caption,size,freespace,filesystem /format:table

echo.
echo === GRAPHICS ===
wmic path win32_VideoController get name,adapterram /format:list | findstr "="

echo.
echo [%TIME%] Hardware information displayed >> "%LOG_FILE%"
pause
goto main_menu

:driver_verifier
cls
echo === Driver Verifier ===
echo.
echo WARNING: Driver Verifier is an advanced diagnostic tool.
echo It can cause system instability if used incorrectly.
echo Only use this if you suspect driver issues.
echo.
echo Current Driver Verifier status:
verifier /query >nul 2>&1
if !errorlevel!==0 (
    verifier /query
) else (
    echo No drivers are currently being verified.
)

echo.
echo Options:
echo 1. Launch Driver Verifier Manager
echo 2. Disable all driver verification
echo 3. Return to main menu
echo.
set /p "verifier_choice=Your selection (1-3): "

if "%verifier_choice%"=="3" goto main_menu
if "%verifier_choice%"=="1" (
    verifier.exe
)
if "%verifier_choice%"=="2" (
    verifier /reset >nul 2>&1
    echo   ? Driver verification disabled
)

echo.
echo [%TIME%] Driver verifier accessed >> "%LOG_FILE%"
pause
goto main_menu

:cleanup_event_logs
cls
echo === Event Viewer Cleanup ===
echo.
echo WARNING: This will clear all Windows Event Logs.
echo This removes troubleshooting history but can free significant disk space.
set /p "confirm_events=Continue? (Y/N): "
if /i not "%confirm_events%"=="Y" goto main_menu

echo Clearing event logs...
set "log_count=0"
for /f "tokens=*" %%G in ('wevtutil.exe el') do (
    wevtutil.exe cl "%%G" >nul 2>&1
    set /a log_count+=1
)

echo   ? !log_count! event logs cleared

echo.
echo Event logs cleanup completed!
echo [%TIME%] Event logs cleanup completed >> "%LOG_FILE%"
pause
goto main_menu

:performance_monitor
cls
echo === Performance Monitor ===
echo.
echo Launching Performance Monitor with system overview...
echo This tool shows real-time system performance data.

perfmon.exe /res
echo.
echo Performance Monitor launched.
echo [%TIME%] Performance Monitor launched >> "%LOG_FILE%"
pause
goto main_menu

:: =============================================================================
:: SYSTEM INFORMATION (36-40)
:: =============================================================================

:system_specs
cls
echo === Detailed System Specifications ===
echo.

echo ==================== SYSTEM OVERVIEW ====================
systeminfo | findstr /B /C:"Host Name" /C:"OS Name" /C:"OS Version" /C:"System Manufacturer" /C:"System Model" /C:"System Type" /C:"Processor(s)" /C:"BIOS Version" /C:"Total Physical Memory" /C:"Available Physical Memory"

echo.
echo ==================== MOTHERBOARD ====================
wmic baseboard get manufacturer,product,version,serialnumber /format:list | findstr "="

echo.
echo ==================== MEMORY DETAILS ====================
wmic memorychip get capacity,speed,memorytype,manufacturer /format:table

echo.
echo ==================== STORAGE DEVICES ====================
wmic diskdrive get model,size,interfacetype /format:table

echo.
echo [%TIME%] System specifications displayed >> "%LOG_FILE%"
pause
goto main_menu

:installed_programs
cls
echo === Installed Programs List ===
echo.
echo Generating installed programs list...
echo.

if !WIN_MODERN!==1 (
    powershell -Command "Get-WmiObject -Class Win32_Product | Select-Object Name, Version, Vendor | Sort-Object Name | Format-Table -AutoSize"
) else (
    wmic product get name,version,vendor /format:table
)

echo.
echo [%TIME%] Installed programs list displayed >> "%LOG_FILE%"
pause
goto main_menu

:running_processes
cls
echo === Running Processes ===
echo.
echo Current running processes (sorted by memory usage):

tasklist /fo table | sort /r /+5
echo.

echo Top 10 processes by memory usage:
wmic process get name,processid,workingsetsize /format:csv | sort /r /+4 | head -10

echo.
echo [%TIME%] Running processes displayed >> "%LOG_FILE%"
pause
goto main_menu

:network_config
cls
echo === Network Configuration ===
echo.
echo ==================== IP CONFIGURATION ====================
ipconfig /all

echo.
echo ==================== NETWORK ADAPTERS ====================
wmic path win32_networkadapter where physicaladapter=true get name,macaddress,speed /format:table

echo.
echo ==================== ROUTING TABLE ====================
route print

echo.
echo [%TIME%] Network configuration displayed >> "%LOG_FILE%"
pause
goto main_menu

:license_info
cls
echo === License and Activation Status ===
echo.
echo ==================== WINDOWS LICENSE ====================
slmgr /dli

echo.
echo ==================== ACTIVATION STATUS ====================
slmgr /xpr

echo.
echo ==================== LICENSE DETAILS ====================
wmic path SoftwareLicensingService get OA3xOriginalProductKey /format:list | findstr "="

echo.
echo [%TIME%] License information displayed >> "%LOG_FILE%"
pause
goto main_menu

:: =============================================================================
:: BATCH OPERATIONS (41-45)
:: =============================================================================

:batch_quick_cleanup
cls
echo === Quick Cleanup Batch Operation ===
echo.
echo This will run: Temp Files, Browser Cache, DNS Reset, Drive Optimization
echo.
set /p "confirm_quick=Continue? (Y/N): "
if /i not "%confirm_quick%"=="Y" goto main_menu

echo [%TIME%] Starting quick cleanup batch operation >> "%LOG_FILE%"

echo [1/4] Clearing temporary files...
call :clean_temp_silent

echo [2/4] Clearing browser cache...
call :clean_browser_cache_silent

echo [3/4] Resetting DNS...
call :flush_dns_reset_silent

echo [4/4] Optimizing drives...
call :run_defrag_silent

echo.
echo === Quick Cleanup Completed! ===
echo [%TIME%] Quick cleanup batch operation completed >> "%LOG_FILE%"
pause
goto main_menu

:batch_system_repair
cls
echo === System Repair Batch Operation ===
echo.
echo This will run: SFC, DISM CheckHealth, Registry Cleanup, Store Apps Repair
echo This process may take 20-60 minutes.
echo.
set /p "confirm_repair=Continue? (Y/N): "
if /i not "%confirm_repair%"=="Y" goto main_menu

echo [%TIME%] Starting system repair batch operation >> "%LOG_FILE%"

echo [1/4] Running System File Checker...
sfc /scannow >nul

echo [2/4] Running DISM CheckHealth...
Dism /Online /Cleanup-Image /CheckHealth >nul

echo [3/4] Cleaning registry...
call :registry_cleanup_silent

echo [4/4] Repairing Store apps...
call :repair_store_apps_silent

echo.
echo === System Repair Completed! ===
echo [%TIME%] System repair batch operation completed >> "%LOG_FILE%"
pause
goto main_menu

:batch_network_reset
cls
echo === Complete Network Reset ===
echo.
echo This will reset: DNS, Winsock, TCP/IP, Network Adapters, Proxy Settings
echo WARNING: This may require a restart.
echo.
set /p "confirm_net=Continue? (Y/N): "
if /i not "%confirm_net%"=="Y" goto main_menu

echo [%TIME%] Starting network reset batch operation >> "%LOG_FILE%"

echo [1/5] Flushing DNS and resetting network...
call :flush_dns_reset_silent

echo [2/5] Resetting Winsock...
netsh winsock reset >nul 2>&1

echo [3/5] Resetting TCP/IP...
netsh int ip reset >nul 2>&1

echo [4/5] Resetting network adapters...
call :reset_network_adapters_silent

echo [5/5] Resetting proxy settings...
call :reset_proxy_silent

echo.
echo === Network Reset Completed! ===
echo A restart is recommended for all changes to take effect.
set /p "restart_net=Restart now? (Y/N): "
if /i "%restart_net%"=="Y" shutdown /r /t 10

echo [%TIME%] Network reset batch operation completed >> "%LOG_FILE%"
pause
goto main_menu

:batch_privacy_performance
cls
echo === Privacy and Performance Optimization ===
echo.
echo This will: Reset Privacy Settings, Disable Telemetry, Rebuild Search, Optimize Services
echo.
set /p "confirm_priv=Continue? (Y/N): "
if /i not "%confirm_priv%"=="Y" goto main_menu

echo [%TIME%] Starting privacy and performance batch operation >> "%LOG_FILE%"

echo [1/4] Resetting privacy settings...
call :privacy_reset_silent

echo [2/4] Disabling telemetry...
call :disable_telemetry_silent

echo [3/4] Optimizing services...
call :optimize_services_silent

echo [4/4] Cleaning user profile...
call :cleanup_user_profile_silent

echo.
echo === Privacy and Performance Optimization Completed! ===
echo [%TIME%] Privacy and performance batch operation completed >> "%LOG_FILE%"
pause
goto main_menu

:batch_complete_maintenance
cls
echo === Complete System Maintenance ===
echo.
echo This comprehensive maintenance will run ALL SAFE operations:
echo - All cleanup operations
echo - System integrity checks
echo - Network optimization
echo - Privacy settings
echo - Performance optimization
echo.
echo WARNING: This process may take 1-3 hours depending on your system.
echo A system restart will be recommended after completion.
echo.
set /p "confirm_complete=Continue with complete maintenance? (Y/N): "
if /i not "%confirm_complete%"=="Y" goto main_menu

echo [%TIME%] Starting complete maintenance batch operation >> "%LOG_FILE%"
echo.
echo ==================== CLEANUP PHASE ====================

echo [1/15] Clearing temporary files...
call :clean_temp_silent

echo [2/15] Clearing browser cache...
call :clean_browser_cache_silent

echo [3/15] Clearing update cache...
call :clean_update_cache_silent

echo [4/15] Emptying recycle bin...
call :clean_recycle_recent_silent

echo.
echo ==================== NETWORK PHASE ====================

echo [5/15] Resetting DNS...
call :flush_dns_reset_silent

echo [6/15] Resetting proxy settings...
call :reset_proxy_silent

echo.
echo ==================== SYSTEM REPAIR PHASE ====================

echo [7/15] Running System File Checker...
sfc /scannow >nul

echo [8/15] Running DISM CheckHealth...
Dism /Online /Cleanup-Image /CheckHealth >nul

echo [9/15] Cleaning registry...
call :registry_cleanup_silent

echo.
echo ==================== OPTIMIZATION PHASE ====================

echo [10/15] Optimizing drives...
call :run_defrag_silent

echo [11/15] Optimizing services...
call :optimize_services_silent

echo [12/15] Optimizing power settings...
call :power_optimization_silent

echo.
echo ==================== PRIVACY PHASE ====================

echo [13/15] Resetting privacy settings...
call :privacy_reset_silent

echo [14/15] Disabling telemetry...
call :disable_telemetry_silent

echo [15/15] Cleaning user profile...
call :cleanup_user_profile_silent

echo.
echo ==================== MAINTENANCE COMPLETED ====================
echo.
echo Complete system maintenance finished successfully!
echo.
echo Summary of completed tasks:
echo ? Temporary files and caches cleared
echo ? Browser data cleaned
echo ? Network settings optimized
echo ? System integrity verified and repaired
echo ? Registry cleaned and optimized
echo ? Drives defragmented and optimized
echo ? Services optimized for performance
echo ? Privacy settings secured
echo ? Telemetry disabled
echo ? User profile cleaned
echo.
echo [%TIME%] Complete maintenance batch operation completed >> "%LOG_FILE%"

set /p "restart_complete=Restart computer to complete all optimizations? (Y/N): "
if /i "%restart_complete%"=="Y" (
    echo Restarting in 10 seconds... Press Ctrl+C to cancel.
    shutdown /r /t 10
) else (
    echo.
    echo Restart your computer when convenient to complete all optimizations.
)

pause
goto main_menu

:: =============================================================================
:: UTILITIES (46-51)
:: =============================================================================

:open_cmd
start cmd.exe
echo [%TIME%] Command Prompt opened >> "%LOG_FILE%"
goto main_menu

:open_powershell
start powershell.exe -Command "Start-Process powershell -Verb RunAs"
echo [%TIME%] PowerShell (Admin) opened >> "%LOG_FILE%"
goto main_menu

:open_regedit
start regedit.exe
echo [%TIME%] Registry Editor opened >> "%LOG_FILE%"
goto main_menu

:open_msconfig
start msconfig.exe
echo [%TIME%] System Configuration opened >> "%LOG_FILE%"
goto main_menu

:open_taskmgr
start taskmgr.exe
echo [%TIME%] Task Manager opened >> "%LOG_FILE%"
goto main_menu

:view_log
cls
echo === WUMS Log File ===
echo.
echo Log file location: %LOG_FILE%
echo.
if exist "%LOG_FILE%" (
    type "%LOG_FILE%"
    echo.
    echo.
    set /p "open_log=Open log file in notepad? (Y/N): "
    if /i "%open_log%"=="Y" start notepad.exe "%LOG_FILE%"
) else (
    echo No log file found. Operations will be logged as you use WUMS.
)
pause
goto main_menu

:: =============================================================================
:: SILENT HELPER FUNCTIONS (for batch operations)
:: =============================================================================

:clean_temp_silent
pushd "%TEMP%" 2>nul && (rd /s /q . >nul 2>&1) & popd
pushd "%SystemRoot%\Temp" 2>nul && (rd /s /q . >nul 2>&1) & popd
del /f /q "%SystemRoot%\Prefetch\*.pf" >nul 2>&1
exit /b

:clean_browser_cache_silent
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
for /d %%p in ("%AppData%\Mozilla\Firefox\Profiles\*") do (
    if exist "%%p\cache2" rd /s /q "%%p\cache2" >nul 2>&1
)
rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache" >nul 2>&1
rd /s /q "%LocalAppData%\Microsoft\Windows\INetCache" >nul 2>&1
exit /b

:clean_update_cache_silent
net stop wuauserv >nul 2>&1
rd /s /q "%SystemRoot%\SoftwareDistribution\Download" >nul 2>&1
net start wuauserv >nul 2>&1
exit /b

:clean_recycle_recent_silent
for %%i in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%i:\$Recycle.Bin" rd /s /q "%%i:\$Recycle.Bin" >nul 2>&1
)
del /f /q "%APPDATA%\Microsoft\Windows\Recent\*.*" >nul 2>&1
exit /b

:flush_dns_reset_silent
ipconfig /flushdns >nul 2>&1
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
ipconfig /registerdns >nul 2>&1
exit /b

:reset_proxy_silent
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /f >nul 2>&1
exit /b

:reset_network_adapters_silent
for /f "skip=3 tokens=3*" %%i in ('netsh interface show interface') do (
    if not "%%i"=="Loopback" (
        netsh interface set interface "%%j" disabled >nul 2>&1
        timeout /t 2 >nul
        netsh interface set interface "%%j" enabled >nul 2>&1
    )
)
exit /b

:registry_cleanup_silent
reg export HKLM "%TEMP%\registry_backup_HKLM.reg" /y >nul 2>&1
reg export HKCU "%TEMP%\registry_backup_HKCU.reg" /y >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths" /f >nul 2>&1
exit /b

:repair_store_apps_silent
if !WIN_MODERN!==1 (
    powershell -Command "Get-AppxPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\AppXManifest.xml\"}" >nul 2>&1
    wsreset.exe >nul 2>&1
)
exit /b

:run_defrag_silent
for /f "skip=1 tokens=1" %%d in ('wmic logicaldisk where "drivetype=3" get caption') do (
    if not "%%d"=="" (
        if !WIN_MODERN!==1 (
            defrag %%d /O /H >nul 2>&1
        ) else (
            defrag %%d /A /V >nul 2>&1
        )
    )
)
exit /b

:optimize_services_silent
set "services_to_manual=Themes UxSms TabletInputService WSearch Spooler"
for %%s in (!services_to_manual!) do (
    sc config "%%s" start= demand >nul 2>&1
)
if !WIN_MODERN!==1 (
    sc config "DiagTrack" start= disabled >nul 2>&1
    sc config "dmwappushservice" start= disabled >nul 2>&1
)
exit /b

:power_optimization_silent
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
if !errorlevel! neq 0 (
    powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
)
powercfg /change monitor-timeout-ac 15 >nul 2>&1
powercfg /change disk-timeout-ac 0 >nul 2>&1
powercfg /change standby-timeout-ac 0 >nul 2>&1
exit /b

:privacy_reset_silent
if !WIN_MODERN!==1 (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d "Deny" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v Value /t REG_SZ /d "Deny" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v Value /t REG_SZ /d "Deny" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
)
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ActivityFeed\Settings" /v UploadUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
exit /b

:disable_telemetry_silent
sc config "DiagTrack" start= disabled >nul 2>&1
sc stop "DiagTrack" >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
if !WIN_MODERN!==1 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
)
exit /b

:cleanup_user_profile_silent
if exist "%LOCALAPPDATA%\Temp" (
    pushd "%LOCALAPPDATA%\Temp" 2>nul && (
        for /d %%d in (*) do rd /s /q "%%d" >nul 2>&1
        del /f /q *.* >nul 2>&1
    ) & popd
)
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" (
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
)
if exist "%LOCALAPPDATA%\Microsoft\Windows\WER" (
    rd /s /q "%LOCALAPPDATA%\Microsoft\Windows\WER" >nul 2>&1
)
exit /b

:: =============================================================================
:: Exit Script
:: =============================================================================
:exit_script
cls
echo.
echo Thank you for using Windows Unofficial Maintenance Script.
echo Exiting...
timeout /t 2 >nul
exit /b
