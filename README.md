# JavaVersionManager

**JavaVersionManager** is a lightweight PowerShell module for managing multiple installed Java versions on Windows. It allows you to list configured Java versions and easily switch between them by updating the `JAVA_HOME` environment variable and adjusting the `PATH` for the current session.

---

## Features

- List installed Java versions
- Display the currently active Java version
- Switch Java version in the current terminal session
- Optional output of the full Java binary path

---

## Installation

### From PowerShell Gallery

```powershell
Install-Module -Name JavaVersionManager -Scope CurrentUser
```

Then import it:

```powershell
Import-Module JavaVersionManager
```

### From local folder

```powershell
Import-Module ./JavaVersionManager.psm1
```

---

## Environment Configuration

Before using the module, you must define the available Java versions on your machine using a global hashtable. This should be done in your PowerShell profile (e.g., `Microsoft.PowerShell_profile.ps1`).

```powershell
# JAVA VERSION MANAGER
if (-not $Global:JavaVersions) {
    $Global:JavaVersions = @{
        jdk8  = 'C:\Program Files\Java\jdk1.8.0_211'
        jdk11 = 'C:\Program Files\Java\jdk-11.0.27'
        jdk17 = 'C:\Program Files\Java\jdk-17.0.15'
        jdk22 = 'C:\Program Files\Java\jdk-22.0.2'
    }
}
```

---

## Functions

### `Get-JavaVersion`

Lists all installed Java versions and highlights the one currently in use.

#### Parameters

- `-IncludePathBinary` – Optional. Shows the full path to the Java binary.
- `-Target` – Optional. Specifies which environment scope to read (`Process`, `User`, or `Machine`). Default: `Process`.

#### Example

```powershell
Get-JavaVersion
Get-JavaVersion -IncludePathBinary
Get-JavaVersion -Target Machine
```

---

### `Set-JavaVersion`

Sets the desired Java version by updating the `JAVA_HOME` environment variable and modifying the `PATH` for the current session.

#### Parameters

- `-Version` – The Java version to set (must exist in `$Global:JavaVersions`).
- `-Target` – Optional. Defines the environment scope to update. Default: `Process`.

#### Example

```powershell
Set-JavaVersion jdk22
Set-JAvaVersion jdk17 -Target Machine
```

---

## Requirements

- Windows 10 or 11
- PowerShell 5.1+ or PowerShell Core
- `$Global:JavaVersions` configured as shown above

---

## License

This project is licensed under [CC BY-NC-SA 4.0](./LICENCE.md)

© [marcio1002](https://github.com/marcio1002)
