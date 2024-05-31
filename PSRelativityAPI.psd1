@{
    RootModule = 'PSRelativityAPI.psm1'
    ModuleVersion = '0.1.0'
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

        ### Shared
        "$PSScriptRoot\Classes\Shared\V1\Models\RelativitySharedV1ModelsAction.ps1",
        "$PSScriptRoot\Classes\Shared\V1\Models\RelativitySharedV1ModelsMeta.ps1",
        "$PSScriptRoot\Classes\Shared\V1\Models\RelativitySharedV1ModelsSecurable.ps1",
        "$PSScriptRoot\Classes\Shared\V1\Models\RelativitySharedV1ModelsSecurableList.ps1",
        "$PSScriptRoot\Classes\Shared\V1\Models\RelativitySharedV1ModelsObjectIdentifier.ps1",
        "$PSScriptRoot\Classes\Shared\V1\Models\RelativitySharedV1ModelsDisplayableObjectIdentifier.ps1",
        "$PSScriptRoot\Classes\Shared\V1\Models\RelativitySharedV1ModelsDisplayableObjectTypeIdentifier.ps1",

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
        "$PSScriptRoot\Classes\ARM\Archive\RelativityArmArchiveJobCreateOrUpdateRequest.ps1",
        "$PSScriptRoot\Classes\ARM\Archive\RelativityArmArchiveJobReadResponse.ps1",
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

        ### Environment API
        "$PSScriptRoot\Classes\Environment\V1\RelativityEnvironmentV1MatterModelsResponse.ps1",

        "$PSScriptRoot\Public\Environment\Get-RelativityMatter.ps1",

        ### Identity API
        "$PSScriptRoot\Classes\Identity\V1\Shared\RelativityIdentityV1SharedAction.ps1",
        "$PSScriptRoot\Classes\Identity\V1\Shared\RelativityIdentityV1SharedMeta.ps1",
        "$PSScriptRoot\Classes\Identity\V1\Shared\RelativityIdentityV1SharedObjectIdentifier.ps1",
        "$PSScriptRoot\Classes\Identity\V1\Shared\RelativityIdentityV1SharedDisplayableObjectIdentifier.ps1",
        "$PSScriptRoot\Classes\Identity\V1\UserModels\RelativityIdentityV1UserModelsEnums.ps1",
        "$PSScriptRoot\Classes\Identity\V1\UserModels\RelativityIdentityV1UserModelsDocumentViewerProperties.ps1",

        "$PSScriptRoot\Classes\Identity\V1\ClientModels\RelativityIdentityV1ClientModelsClientResponse.ps1",
        "$PSScriptRoot\Classes\Identity\V1\UserModels\RelativityIdentityV1UserModelsUserAvailableTypesResponse.ps1",
        "$PSScriptRoot\Classes\Identity\V1\UserModels\RelativityIdentityV1UserModelsUserResponse.ps1",
        
        "$PSScriptRoot\Public\Identity\Get-RelativityClient.ps1",
        "$PSScriptRoot\Public\Identity\Get-RelativityUser.ps1",
        "$PSScriptRoot\Public\Identity\Get-RelativityUserAvailableTypes.ps1",

        ### Infrastructure
        "$PSScriptRoot\Classes\Infrastructure\V1\Shared\RelativityInfrastructureV1SharedEnums.ps1",
        "$PSScriptRoot\Classes\Infrastructure\V1\Shared\RelativityInfrastructureV1SampleDetails.ps1",
        "$PSScriptRoot\Classes\Infrastructure\V1\Shared\RelativityInfrastructureV1SharedField.ps1",
        "$PSScriptRoot\Classes\Infrastructure\V1\Shared\RelativityInfrastructureV1SharedObjectType.ps1",
        "$PSScriptRoot\Classes\Infrastructure\V1\Shared\RelativityInfrastructureV1SharedRelativityObjectSlim.ps1",
        "$PSScriptRoot\Classes\Infrastructure\V1\Shared\RelativityInfrastructureV1SharedQueryResultSlim.ps1",
        "$PSScriptRoot\Classes\Infrastructure\V1\RelativityInfrastructureResourcePoolResourceRequest.ps1",
        "$PSScriptRoot\Classes\Infrastructure\V1\Models\RelativityInfrastructureV1AnalyticsServerModelsResponse.ps1",
        "$PSScriptRoot\Classes\Infrastructure\V1\Models\RelativityInfrastructureV1CacheLocationServerModelsResponse.ps1",
        "$PSScriptRoot\Classes\Infrastructure\V1\Models\RelativityInfrastructureV1FileRespositoryServerModelsResponse.ps1",
        "$PSScriptRoot\Classes\Infrastructure\V1\Models\RelativityInfrastructureV1ResourcePoolModelsResponse.ps1",
        "$PSScriptRoot\Classes\Infrastructure\V1\Models\RelativityInfrastructureV1ResourceServerModelsServerTypeResponse.ps1",

        "$PSScriptRoot\Public\Infrastructure\Add-RelativityResourcePoolResource.ps1",
        "$PSScriptRoot\Public\Infrastructure\Get-RelativityAnalyticsServer.ps1",
        "$PSScriptRoot\Public\Infrastructure\Get-RelativityCacheLocation.ps1",
        "$PSScriptRoot\Public\Infrastructure\Get-RelativityFileRepository.ps1",
        "$PSScriptRoot\Public\Infrastructure\Get-RelativityResourcePool.ps1",
        "$PSScriptRoot\Public\Infrastructure\Get-RelativityResourcePoolResource.ps1",
        "$PSScriptRoot\Public\Infrastructure\Get-RelativityResourceServerType.ps1",
        "$PSScriptRoot\Public\Infrastructure\New-RelativityResourcePool.ps1",

        ### ObjectManager API
        "$PSScriptRoot\Classes\ObjectManager\Custom\RelativityObjectQueryConditionCombinationOperator.ps1",
        "$PSScriptRoot\Classes\ObjectManager\Custom\RelativityObjectQueryConditionComparisonOperator.ps1",
        "$PSScriptRoot\Classes\ObjectManager\Custom\RelativityObjectQueryConditionKeyword.ps1",
        "$PSScriptRoot\Classes\ObjectManager\Custom\RelativityObjectQueryConditionMonthOf.ps1",
        "$PSScriptRoot\Classes\ObjectManager\Custom\RelativityObjectQueryCondition.ps1",
        "$PSScriptRoot\Classes\ObjectManager\V1\Models\RelativityObjectManagerV1ModelsFieldRef.ps1",
        "$PSScriptRoot\Classes\ObjectManager\V1\Models\RelativityObjectManagerV1ModelsObjectTypeRef.ps1",
        "$PSScriptRoot\Classes\ObjectManager\V1\Models\RelativityObjectManagerV1ModelsSampleParameters.ps1",
        "$PSScriptRoot\Classes\ObjectManager\V1\Models\RelativityObjectManagerV1ModelsSearchIndexRef.ps1",
        "$PSScriptRoot\Classes\ObjectManager\V1\Models\RelativityObjectManagerV1ModelsSearchProviderConditions.ps1",
        "$PSScriptRoot\Classes\ObjectManager\V1\Models\RelativityObjectManagerV1ModelsLongTextBehavior.ps1",
        "$PSScriptRoot\Classes\ObjectManager\V1\Models\RelativityObjectManagerV1ModelsSortEnum.ps1",
        "$PSScriptRoot\Classes\ObjectManager\V1\Models\RelativityObjectManagerV1ModelsSort.ps1",
        "$PSScriptRoot\Classes\ObjectManager\V1\Models\RelativityObjectManagerV1ModelsQueryRequest.ps1",
        "$PSScriptRoot\Private\ObjectManager\Get-RelativityObjectReadRequest.ps1",
        "$PSScriptRoot\Public\ObjectManager\Get-RelativityObject.ps1",
        "$PSScriptRoot\Public\ObjectManager\New-RelativityObjectQueryCondition.ps1",
        "$PSScriptRoot\Public\ObjectManager\New-RelativityObjectQuerySampleParameterSet.ps1",
        "$PSScriptRoot\Public\ObjectManager\New-RelativityObjectQuerySearchProviderCondition.ps1",
        "$PSScriptRoot\Public\ObjectManager\New-RelativityObjectQuerySort.ps1",

        ### ObjectModel API
        "$PSScriptRoot\Classes\ObjectModel\V1\Models\RelativityObjectModelV1ChoiceModelsColor.ps1",
        "$PSScriptRoot\Classes\ObjectModel\V1\Models\RelativityObjectModelV1FieldModelsEnums.ps1",
        "$PSScriptRoot\Classes\ObjectModel\V1\Models\RelativityObjectModelV1FieldModelsFieldSource.ps1",
        "$PSScriptRoot\Classes\ObjectModel\V1\Models\RelativityObjectModelV1FieldModelsPaneIcon.ps1",
        "$PSScriptRoot\Classes\ObjectModel\V1\Models\RelativityObjectModelV1SharedModelsModifierKey.ps1",
        "$PSScriptRoot\Classes\ObjectModel\V1\Models\RelativityObjectModelV1SharedModelsShortcut.ps1",

        "$PSScriptRoot\Classes\ObjectModel\V1\Models\RelativityObjectModelV1ChoiceModelsResponse.ps1",
        "$PSScriptRoot\Classes\ObjectModel\V1\Models\RelativityObjectModelV1FieldModelsResponse.ps1",
        "$PSScriptRoot\Classes\ObjectModel\V1\Models\RelativityObjectModelV1ObjectTypeModelsResponse.ps1",

        "$PSScriptRoot\Public\ObjectModel\Get-RelativityChoice.ps1",
        "$PSScriptRoot\Public\ObjectModel\Get-RelativityField.ps1",
        "$PSScriptRoot\Public\ObjectModel\Get-RelativityParentObjectType.ps1"        
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

        ### Environment API
        "Get-RelativityMatter",

        ### Identity API
        "Get-RelativityClient",
        "Get-RelativityUser",
        "Get-RelativityUserAvailableTypes",

        ### Infrastructure
        "Add-RelativityResourcePoolResource",
        "Get-RelativityAnalyticsServer",
        "Get-RelativityCacheLocation",
        "Get-RelativityFileRepository",
        "Get-RelativityResourcePool",
        "Get-RelativityResourcePoolResource",
        "Get-RelativityResourceServerType",
        "New-RelativityResourcePool",

        ### ObjectManager API
        "Get-RelativityObject",
        "New-RelativityObjectQueryCondition", <#,
        "New-RelativityObjectQuerySampleParameterSet",
        "New-RelativityObjectQuerySearchProviderCondition"#>

        ### ObjectModel API
        "Get-RelativityChoice",
        "Get-RelativityParentObjectType",
        "Get-RelativityField"
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

