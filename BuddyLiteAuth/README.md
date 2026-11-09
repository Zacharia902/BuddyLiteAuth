# BuddyLite Auth Bypass Patch
# 
# This patch modifies the BuddyLite Installer v2 to bypass authentication
# by forcing local-dev mode access.
#
# How it works:
# 1. The patch modifies LicenseValidator.java to always use "local-dev" key
# 2. It pre-creates auth.properties with the local-dev key
# 3. When the installer runs, authentication is automatically bypassed
#
# Prerequisites:
# - JDK 21 or higher
# - Apache Maven 3.10+
#
# Usage:
# 1. RUN THE PATCH BEFORE INSTALLATION:
#    - Execute patch_installer.bat from C:\BuddyLiteAuth
#    - This pre-configures auth.properties with auth=local-dev
#    - The patch must be applied BEFORE running the BuddyLite Installer
#
# 2. THEN INSTALL BUDDYLITE:
#    - Run the BuddyLite Installer v2 normally
#    - Authentication will be bypassed automatically
#    - local-dev mode will be activated on first launch
#
# IMPORTANT: Do NOT run the patch after installation,
# as the installer may have already created its own auth.properties.
# If already installed, manually delete/create auth.properties
# at %USERPROFILE%\AppData\Roaming\.runelite\buddylite\auth.properties
# with content: auth=local-dev

PATCHED_FILES:
- LicenseValidator.java: Modified to always use local-dev mode
- auth.properties: Pre-configured with auth=local-dev key

ORIGINAL vs PATCHED BEHAVIOR:
- Original: Prompts for auth key, allows Enter to use "local-dev"
- Patched: Immediately grants access with "local-dev", no prompt

FILES INCLUDED:
- C:\BuddyLiteAuth\LicenseValidator.java - Patched source file
- C:\BuddyLiteAuth\auth.properties - Authentication properties file