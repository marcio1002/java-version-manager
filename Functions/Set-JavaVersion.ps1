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
        Write-Host -ForegroundColor Red "Nenhuma versão encontrada nas variáveis de ambiente de `$Global:JavaVersions"
        return
    }

    if (-not $Version -or $Version -notin $Global:JavaVersions.Keys) {
        Write-Host -ForegroundColor Red "Especifique uma versão java`nUtilize Get-Java para ver todas as versões disponíveis"
        return
    }

    [string] $currentVersionJava = [System.Environment]::GetEnvironmentVariable('JAVA_HOME', $Target) ?? ''
    [string] $path = [System.Environment]::GetEnvironmentVariable('PATH', $Target)
    [string] $selectedJavaVersion = $Global:JavaVersions[$Version]

    if ($selectedJavaVersion -ieq $currentVersionJava) {
        return
    }

    Write-Host "$currentVersionJava -> $selectedJavaVersion"

    $pathSplit = New-Object System.Collections.ArrayList

    $path.Split(";") | ForEach-Object {
        $currentPath = $_

        [void]$pathSplit.Add(
            $currentPath -eq "$currentVersionJava\bin" ? "$selectedJavaVersion\bin" : $currentPath
        )
    }

    $path = $pathSplit -join ";"

    [System.Environment]::SetEnvironmentVariable('JAVA_HOME', $selectedJavaVersion, $Target)
    [System.Environment]::SetEnvironmentVariable('PATH', $path, $Target)

    Write-Host -ForegroundColor Green "Agora você esta utilizando: $Version"
}