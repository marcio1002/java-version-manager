@{
    ModuleVersion     = '1.0.0'
    GUID              = '8fcc88e1-b80c-4310-8968-173c7418d83c'
    Author            = 'Marcio Alemão'
    CompanyName       = 'Marcio Alemão'
    Copyright         = '(c) 2022 Marcio Alemão. All rights reserved.'
    Description       = 'Java Version Manager manages local versions leaving you free to add your own versions, just configure in the global variable the Paths and use the Java Version Manager more simply.'
    RootModule        = 'JavaVersionManager.psm1'
    FunctionsToExport = @('Get-JavaVersion', 'Set-JavaVersion')
    CmdletsToExport   = @('Get-JavaVersion', 'Set-JavaVersion')
    VariablesToExport = '*'
    AliasesToExport   = @('Get-JavaVersion', 'Set-JavaVersion')
    PrivateData       = @{
        PSData = @{
            Tags = @('Java', '')
        }
    }
}