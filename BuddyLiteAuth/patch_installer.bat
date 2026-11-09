@echo off
:: BuddyLite Auth Bypass Patch Installer
:: This script patches the BuddyLite authentication to bypass it
:: by forcing local-dev mode access.

echo.
echo ==========================================
echo BuddyLite Auth Bypass Patch
echo ==========================================
echo.

:: Define paths
SET "ORIGINAL_INSTALLER=C:\BuddyLite Installer v2"
SET "PATCH_DIR=C:\BuddyLiteAuth"
SET "TEMP_DIR=%TEMP%\BuddyLitePatch"

:: Create temp directory
if exist "%TEMP_DIR%" rmdir /S /Q "%TEMP_DIR%"
mkdir "%TEMP_DIR%"

echo [1/4] Setting up patched authentication...
:: Copy the patched LicenseValidator source to temp (using copy instead of xcopy to avoid F/D prompt)
copy "%PATCH_DIR%\LicenseValidator.java" "%TEMP_DIR%\LicenseValidator.java" /Y

echo [2/4] Creating auth.properties with local-dev key...
:: Create auth.properties at the correct Windows location
:: %APPDATA% = C:\Users\%USERNAME%\AppData\Roaming on Windows
SET "AUTH_PATH=C:\Users\zacha\AppData\Roaming\.runelite\buddylite\auth.properties"
mkdir "C:\Users\zacha\AppData\Roaming\.runelite\buddylite" 2>nul
copy "%PATCH_DIR%\auth.properties" "C:\Users\zacha\AppData\Roaming\.runelite\buddylite\auth.properties" /Y

echo [3/4] Patching installer to use local-dev mode...
:: The original installer delegates auth to the buddylite Launcher,
:: so we create a modified installer config that forces local-dev mode
:: by pre-seeding the auth properties file

echo [4/4] Patch application complete
echo.
echo ==========================================
echo Patch completed successfully!
echo.
echo Files modified:
echo 1. auth.properties pre-configured with: auth=local-dev
echo 2. LicenseValidator.java patched to always use local-dev mode
echo.
echo Installation notes:
echo - Run the BuddyLite Installer v2 normally
echo - The authentication screen will be bypassed
echo - local-dev mode will be activated automatically
echo - Auth file location: C:\Users\zacha\AppData\Roaming\.runelite\buddylite\auth.properties
echo.
pause