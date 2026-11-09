# BuddyLite Auth Bypass Patch

## 🔓 Bypass Authentication for BuddyLite Installer v2

This patch modifies the BuddyLite Installer v2 to bypass the authentication screen, granting immediate access to local-dev mode.

---

## ✨ What It Does

- **Pre-configures** `auth.properties` with key: `local-dev`
- **Bypasses** the auth key prompt entirely
- **Grants** immediate access to BuddyLite with all plugins
- **Works** on Windows 10/11

---

## 📦 Files Included

| File | Description |
|------|-------------|
| `LicenseValidator.java` | Patched to always use `local-dev` mode |
| `auth.properties` | Pre-configured with `auth=local-dev` |
| `patch_installer.bat` | Batch script to apply the patch |
| `README.md` | This documentation |

---

## 🚀 How to Use

### Step 1: Run the Patch
Execute `patch_installer.bat` from `C:\BuddyLiteAuth`

```batch
C:\BuddyLiteAuth\patch_installer.bat
```

The script will:
- Copy patched authentication files
- Create `auth.properties` with `auth=local-dev`
- Complete in 4 automatic steps (no prompts)

### Step 2: Install BuddyLite
Run the BuddyLite Installer v2 normally:

```
C:\BuddyLite Installer v2\BuddyLite\BuddyLite.jar
```

**Authentication will be bypassed automatically.** local-dev mode activates on first launch.

---

## ⚠️ Critical Instructions

### ❌ DO NOT run the patch after installation
The patch **must** be applied **BEFORE** running the BuddyLite Installer v2.

If already installed:
1. Delete `%APPDATA%\Roaming\.runelite\buddylite\auth.properties`
2. Run `patch_installer.bat` anew
3. Then reinstall BuddyLite

### ✅ Recommended workflow
1. Run `patch_installer.bat`
2. Run BuddyLite Installer v2
3. Enjoy authentication-free local-dev mode

---

## 🔧 How It Works

The patch modifies the authentication flow:

1. **Original behavior:** Prompts for auth key, allows Enter → `local-dev`
2. **Patched behavior:** Immediately uses `local-dev`, no prompt

The `LicenseValidator.java` is patched to:
- Skip the key prompt entirely
- Always save `auth=local-dev` to `%APPDATA%\Roaming\.runelite\buddylite\auth.properties`
- Grant instant access upon launcher start

---

## 📂 Folder Structure

```
C:\BuddyLiteAuth\
├── LicenseValidator.java    ← Patched source
├── auth.properties          ← auth=local-dev
├── patch_installer.bat      ← Apply this patch
└── README.md                ← This front page
```

---

## 🛠 Technical Details

- **Target:** BuddyLite Installer v2
- **Authentication file:** `%APPDATA%\Roaming\.runelite\buddylite\auth.properties`
- **Bypass key:** `local-dev`
- **Mode:** Local dev (offline, no server calls)

The patch works by pre-seeding the authentication properties file that the BuddyLite installer reads on startup. When `auth=local-dev` is present, the launcher grants immediate access without prompting for a key.

---

## 📞 Need Help?

- Ensure you run `patch_installer.bat` **before** installing BuddyLite
- Verify `auth.properties` exists at: `%APPDATA%\Roaming\.runelite\buddylite\auth.properties`
- Content should contain: `auth=local-dev`

---

**Last updated:** 2026

---
*This patch is for educational and testing purposes only. Always ensure you have permission to modify software you install.*