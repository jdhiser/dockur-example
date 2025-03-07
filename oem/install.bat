@echo off
:: Set log file location
set LOGFILE=C:\Windows\Logs\install_ssh_server.log

:: Create log directory if it doesn't exist
if not exist "C:\Windows\Logs" mkdir "C:\Windows\Logs"

:: Redirect all output to the log file
call :log >> "%LOGFILE%" 2>&1
exit /b

:log
echo [%DATE% %TIME%] Starting SSH server installation and configuration...

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [%DATE% %TIME%] Error: Please run this script as an administrator.
    exit /b 1
)

:: Install OpenSSH Server
echo [%DATE% %TIME%] Installing OpenSSH Server...
dism /online /add-capability /capabilityname:OpenSSH.Server~~~~0.0.1.0

:: Check if installation was successful
if %errorLevel% neq 0 (
    echo [%DATE% %TIME%] Error: Failed to install OpenSSH Server.
    exit /b 1
)

:: Configure the SSH server to start automatically
echo [%DATE% %TIME%] Configuring SSH server to start automatically...
sc config sshd start= auto

:: Start the SSH server
echo [%DATE% %TIME%] Starting SSH server...
net start sshd

:: Check if the SSH server started successfully
if %errorLevel% neq 0 (
    echo [%DATE% %TIME%] Error: Failed to start SSH server.
    exit /b 1
)

:: Configure firewall to allow SSH traffic
echo [%DATE% %TIME%] Configuring firewall to allow SSH traffic...
netsh advfirewall firewall add rule name="OpenSSH Server (SSHD)" dir=in action=allow protocol=TCP localport=22

:: Check if firewall rule was added successfully
if %errorLevel% neq 0 (
    echo [%DATE% %TIME%] Error: Failed to add firewall rule.
    exit /b 1
)

echo [%DATE% %TIME%] SSH server installation and configuration complete.
echo [%DATE% %TIME%] You can now connect to this machine using SSH on port 22.
exit /b 0
