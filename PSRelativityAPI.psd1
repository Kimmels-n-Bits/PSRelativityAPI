@{
    RootModule = 'PSRelativityAPI.psm1'
    ModuleVersion = '0.0.9'
    CompatiblePSEditions = @('Desktop')
    GUID = '95225073-9a03-4ec2-b71b-b97afe87f9ac'
    Author = 'Jarrod Kimmel'
    CompanyName = 'Jarrod Kimmel'
    Copyright = 'Copyright (c) 2024 Jarrod Kimmel. All rights reserved.'
    Description = 'A PowerShell module with cmdlets to interact with the Relativity REST API'
    PowerShellVersion = '5.1'
    NestedModules = @(
        ### General
        "$PSScriptRoot\Classes\RelativityAPI.ps1",
        "$PSScriptRoot\Public\RelativityAPI\Set-RelativityBaseUri.ps1",
        "$PSScriptRoot\Public\RelativityAPI\Set-RelativityCredential.ps1",
        "$PSScriptRoot\Private\RelativityAPI\Get-RelativityApiEndpoint.ps1",
        "$PSScriptRoot\Private\RelativityAPI\Get-RelativityApiRequestHeader.ps1",
        "$PSScriptRoot\Private\RelativityAPI\Invoke-RelativityApiRequest.ps1",

        ### Agent Manager API
        "$PSScriptRoot\Classes\AgentManager\CommonClasses.ps1",
        "$PSScriptRoot\Classes\AgentManager\RelativityAgentTypeReadResponse.ps1",
        "$PSScriptRoot\Classes\AgentManager\RelativityAgentServerReadResponse.ps1",
        "$PSScriptRoot\Classes\AgentManager\RelativityAgentCreateRequest.ps1",
        "$PSScriptRoot\Classes\AgentManager\RelativityAgentCreateResponse.ps1",
        "$PSScriptRoot\Classes\AgentManager\RelativityAgentReadResponse.ps1",
        "$PSScriptRoot\Classes\AgentManager\RelativityAgentUpdateRequest.ps1",
        "$PSScriptRoot\Classes\AgentManager\RelativityAgentDeleteRequest.ps1",
        "$PSScriptRoot\Public\AgentManager\Get-RelativityAgentType.ps1",
        "$PSScriptRoot\Public\AgentManager\Get-RelativityAgentServer.ps1",
        "$PSScriptRoot\Public\AgentManager\New-RelativityAgent.ps1",
        "$PSScriptRoot\Public\AgentManager\Get-RelativityAgent.ps1",
        "$PSScriptRoot\Public\AgentManager\Set-RelativityAgent.ps1",
        "$PSScriptRoot\Public\AgentManager\Remove-RelativityAgent.ps1",
        "$PSScriptRoot\Public\AgentManager\Test-NewRelativityAgent.ps1",
        "$PSScriptRoot\Public\AgentManager\Test-SetRelativityAgent.ps1",
        "$PSScriptRoot\Public\AgentManager\Test-RemoveRelativityAgent.ps1",

        ### ARM API
        "$PSScriptRoot\Classes\ARM\CommonClasses.ps1",
        "$PSScriptRoot\Classes\ARM\Archive\CommonClasses.ps1",
        "$PSScriptRoot\Classes\ARM\Archive\RelativityArmArchiveJobCreateOrUpdateRequest.ps1"
        "$PSScriptRoot\Classes\ARM\Archive\RelativityArmArchiveJobReadResponse.ps1"
        "$PSScriptRoot\Classes\ARM\Restore\CommonClasses.ps1",
        "$PSScriptRoot\Classes\ARM\Restore\RelativityArmRestoreJobCreateOrUpdateRequest.ps1",
        "$PSScriptRoot\Classes\ARM\Restore\RelativityArmRestoreJobReadResponse.ps1",
        "$PSScriptRoot\Classes\ARM\DatabaseRestore\RelativityArmDatabaseRestoreJobCreateOrUpdateRequest.ps1",
        "$PSScriptRoot\Classes\ARM\DatabaseRestore\RelativityArmDatabaseRestoreJobReadResponse.ps1",
        "$PSScriptRoot\Classes\ARM\Move\CommonClasses.ps1",
        "$PSScriptRoot\Classes\ARM\Move\RelativityArmMoveJobCreateOrUpdateRequest.ps1",
        "$PSScriptRoot\Classes\ARM\Move\RelativityArmMoveJobReadResponse.ps1",
        "$PSScriptRoot\Classes\ARM\RelativityArmJobStatusReadResponse.ps1",
        "$PSScriptRoot\Private\ARM\Archive\Get-RelativityArmArchiveJobCreateOrUpdateRequest.ps1",
        "$PSScriptRoot\Private\ARM\Restore\Get-RelativityArmRestoreJobCreateOrUpdateRequest.ps1",
        "$PSScriptRoot\Private\ARM\DatabaseRestore\Get-RelativityArmDatabaseRestoreJobCreateOrUpdateRequest.ps1",
        "$PSScriptRoot\Private\ARM\Move\Get-RelativityArmMoveJobCreateOrUpdateRequest.ps1",
        "$PSScriptRoot\Public\ARM\Archive\New-RelativityArmArchiveJob.ps1",
        "$PSScriptRoot\Public\ARM\Archive\Get-RelativityArmArchiveJob.ps1",
        "$PSScriptRoot\Public\ARM\Archive\Set-RelativityArmArchiveJob.ps1",
        "$PSScriptRoot\Public\ARM\Archive\Remove-RelativityArmArchiveJob.ps1",
        "$PSScriptRoot\Public\ARM\Restore\New-RelativityArmRestoreJob.ps1",
        "$PSScriptRoot\Public\ARM\Restore\Get-RelativityArmRestoreJob.ps1",
        "$PSScriptRoot\Public\ARM\Restore\Set-RelativityArmRestoreJob.ps1",
        "$PSScriptRoot\Public\ARM\Restore\Remove-RelativityArmRestoreJob.ps1",
        "$PSScriptRoot\Public\ARM\DatabaseRestore\New-RelativityArmDatabaseRestoreJob.ps1",
        "$PSScriptRoot\Public\ARM\DatabaseRestore\Get-RelativityArmDatabaseRestoreJob.ps1",
        "$PSScriptRoot\Public\ARM\DatabaseRestore\Set-RelativityArmDatabaseRestoreJob.ps1",
        "$PSScriptRoot\Public\ARM\DatabaseRestore\Remove-RelativityArmDatabaseRestoreJob.ps1",
        "$PSScriptRoot\Public\ARM\Move\New-RelativityArmMoveJob.ps1",
        "$PSScriptRoot\Public\ARM\Move\Get-RelativityArmMoveJob.ps1",
        "$PSScriptRoot\Public\ARM\Move\Set-RelativityArmMoveJob.ps1",
        "$PSScriptRoot\Public\ARM\Move\Remove-RelativityArmMoveJob.ps1",
        "$PSScriptRoot\Public\ARM\Start-RelativityArmJob.ps1",
        "$PSScriptRoot\Public\ARM\Stop-RelativityArmJob.ps1",
        "$PSScriptRoot\Public\ARM\Suspend-RelativityArmJob.ps1",
        "$PSScriptRoot\Public\ARM\Terminate-RelativityArmJob.ps1",
        "$PSScriptRoot\Public\ARM\Get-RelativityArmJobStatus.ps1",
        "$PSScriptRoot\Public\ARM\Get-RelativityArmJobLog.ps1",

        ### ObjectManager API
        "$PSScriptRoot\Classes\ObjectManager\CommonClasses.ps1",
        "$PSScriptRoot\Public\ObjectManager\New-RelativityObjectQueryCondition.ps1"
    )
    FunctionsToExport = @(
        ### General
        "Set-RelativityBaseUri",
        "Set-RelativityCredential",

        ### Agent Manager API
        "Get-RelativityAgentType",
        "Get-RelativityAgentServer",
        "New-RelativityAgent",
        "Get-RelativityAgent",
        "Set-RelativityAgent",
        "Remove-RelativityAgent",
        "Test-NewRelativityAgent",
        "Test-SetRelativityAgent",
        "Test-RemoveRelativityAgent",

        ### ARM API
        'New-RelativityArmArchiveJob',
        'Get-RelativityArmArchiveJob',
        'Set-RelativityArmArchiveJob',
        'Remove-RelativityArmArchiveJob',
        'New-RelativityArmRestoreJob',
        'Get-RelativityArmRestoreJob',
        'Set-RelativityArmRestoreJob',
        'Remove-RelativityArmRestoreJob',
        'New-RelativityArmDatabaseRestoreJob',
        'Get-RelativityArmDatabaseRestoreJob',
        'Set-RelativityArmDatabaseRestoreJob',
        'Remove-RelativityArmDatabaseRestoreJob',
        "New-RelativityArmMoveJob",
        "Get-RelativityArmMoveJob",
        "Set-RelativityArmMoveJob",
        "Remove-RelativityArmMoveJob",
        "Start-RelativityArmJob",
        "Stop-RelativityArmJob",
        "Suspend-RelativityArmJob",
        "Terminate-RelativityArmJob",
        "Get-RelativityArmJobStatus",
        "Get-RelativityArmJobLog",
        "Restart-RelativityArmJobTask",

        ### ObjectManager API
        "New-RelativityObjectQueryCondition"
    )
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()
    PrivateData = @{

        PSData = @{
            Tags = @("relativity", "rest", "api", "developer")
            LicenseUri = "https://github.com/Kimmels-n-Bits/PSRelativityAPI/blob/main/LICENSE"
            ProjectUri = "https://github.com/Kimmels-n-Bits/PSRelativityAPI/"
            IconUri = ""
            ReleaseNotes = ""
        }
    }
    HelpInfoURI = ""
}

