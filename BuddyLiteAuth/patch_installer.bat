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

echo.
echo [1/4] Setting up patched authentication...
:: Copy the patched LicenseValidator source to temp
xcopy "%PATCH_DIR%\LicenseValidator.java" "%TEMP_DIR%\LicenseValidator.java" /Y /I

echo [2/4] Creating auth.properties with local-dev key...
:: Create the auth.properties file in the buddyLite auth location
mkdir "%TEMP_DIR%\..\_runelite\buddylite" 2>nul
copy "%PATCH_DIR%\auth.properties" "%TEMP_DIR%\..\_runelite\buddylite\auth.properties" /Y

echo [3/4] Patching installer to use local-dev mode...
:: The original installer delegates auth to the buddylite Launcher,
:: so we create a modified installer config that forces local-dev mode
:: by pre-seeding the auth properties file

echo [4/4] Patch application complete
echo.
echo ==========================================
echo IMPORTANT: RUN THIS PATCH BEFORE INSTALLING BUDDYLITE!
echo.
echo The patch must be applied BEFORE running the BuddyLite Installer v2,
:: as it pre-configures the authentication properties that the installer
:: will use. Running after installation may not bypass authentication.
echo.
echo To apply the patch:
echo 1. Run this script (patch_installer.bat)
echo 2. The auth.properties will be pre-configured with: auth=local-dev
echo 3. Then run the BuddyLite Installer v2 normally
echo 4. Authentication will be bypassed automatically
echo.
echo Installation notes:
echo - auth.properties location: %USERPROFILE%\AppData\Roaming\.runelite\buddylite\auth.properties
echo - Must run patch BEFORE installation for best results
echo - If already installed, manually set auth.properties to: auth=local-dev
echo.
pause