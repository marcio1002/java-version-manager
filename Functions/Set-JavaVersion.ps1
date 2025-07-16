<#
    .SYNOPSIS
        Define
    .EXAMPLE
        Set-JavaVersion openjdk22
#>
function Set-JavaVersion {
    param(
        [Parameter(Position = 0, Mandatory)]
        [string] $Version,

        [Parameter(Mandatory = $false)]
        [System.EnvironmentVariableTarget] $Target = [System.EnvironmentVariableTarget]::Process
    )

    if (-not $Global:JavaVersions) {
        Write-Host -ForegroundColor Red "Nenhuma versão encontrada"
        return
    }

    if (-not $Version -or $Version -notin $Global:JavaVersions.Keys) {
        Write-Host -ForegroundColor Red "Especifique uma versão java`nUtilize Get-Java para ver todas as versões disponíveis"
        return
    }

    [string] $currentVersionJava = [System.Environment]::GetEnvironmentVariable('JAVA_HOME', $Target) ?? ''
    [string] $path = [System.Environment]::GetEnvironmentVariable('PATH', $Target)
    [string] $selectedVersion = $Global:JavaVersions[$Version]

    if ($selectedVersion -eq $currentVersionJava) {
        return
    }

    [System.Environment]::SetEnvironmentVariable('JAVA_HOME', $selectedVersion, 'Process')

    $path = $path.Replace("$currentVersionJava\bin", "$selectedVersion\bin")
    [System.Environment]::SetEnvironmentVariable('PATH', $path, 'Process')

    Write-Host -ForegroundColor Green "Versão java definida: $Version"
}