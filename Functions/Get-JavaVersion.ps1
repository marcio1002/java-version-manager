
<#
    .SYNOPSIS
        Lista todas as versões do java instaladas por chocolatey
        e mostra versão atual sendo utilizada
    .EXAMPLE
        Get-Java
        RESULT: 
            1.8.0_144
            1.8.0_144-b01
            1.8.0_144-b02
            1.8.0_144-b03 [current]

            With Path:
            1.8.0_144 -> C:\Program Files\Java\jre1.8.0_144
            1.8.0_144-b01 -> C:\Program Files\Java\jre1.8.0_144
            1.8.0_144-b02 -> C:\Program Files\Java\jre1.8.0_144
            1.8.0_144-b03 -> C:\Program Files\Java\jre1.8.0_144 [current]
#>
function Get-JavaVersion {

    param(
        [Parameter(Mandatory = $false)]
        [switch] $IncludePathBinary,

        [Parameter(Mandatory = $false)]
        [System.EnvironmentVariableTarget] $Target = [System.EnvironmentVariableTarget]::Process
    )

    if (-not $Global:JavaVersions) {
        Write-Host -ForegroundColor Red "Nenhuma versão encontrada"
        
        return
    }

    [string] $currentVersionJava = [System.Environment]::GetEnvironmentVariable('JAVA_HOME', $Target) ?? '' 

    foreach ($key in $Global:JavaVersions.Keys) {
        $isCurrent = $Global:JavaVersions[$key] -eq $CurrentVersionJava
        $bgColor = $isCurrent ? 'Green' : 'Yellow'

        Write-Host `
            -ForegroundColor Black `
            -BackgroundColor $bgColor `
            "$key$($IncludePathBinary ? " -> $($Global:JavaVersions[$key])" : '')$($isCurrent ? ' [current]' : '')"
    }
}