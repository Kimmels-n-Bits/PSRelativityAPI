function New-RelativityArmArchiveJob 
{
    [CmdletBinding(SupportsShouldProcess)]
    Param 
    (
        [Parameter(Mandatory = $true)]
        [Int32] $WorkspaceId,
        [Parameter(Mandatory = $false)]
        [String] $JobPriority = "Medium",
        [Parameter(Mandatory = $false)]
        [String] $ArchiveDirectory,
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            $date = "1970-01-01"
            [DateTime]::TryParse($_, [ref]$date)
            if($_ -eq "") { return $true }
            elseif ($date -eq [DateTime]::MinValue) { throw "Invalid DateTime for ScheduledStartTime: $($_)."}
            $true
        })]
        [String] $ScheduledStartTime,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeDatabaseBackup,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeDtSearch,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeConceptualAnalytics,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeStructuredAnalytics,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeDataGrid,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeRepositoryFiles,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeLinkedFiles,
        [Parameter(Mandatory = $false)]
        [String] $MissingFileBehavior = "SkipFile",
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeProcessing,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeProcessingFiles,
        [Parameter(Mandatory = $false)]
        [String] $ProcessingMissingFileBehavior = "SkipFile",
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeExtendedWorkspaceData,
        [Parameter(Mandatory = $false)]
        [String] $ApplicationErrorExportBehavior = "SkipApplication",
        [Parameter(Mandatory = $false)]
        [Switch] $NotifyJobCreator,
        [Parameter(Mandatory = $false)]
        [Switch] $NotifyJobExecutor,
        [Parameter(Mandatory = $false)]
        [Switch] $UiJobActionsLocked,
        [Parameter(Mandatory = $false)]
        [Switch] $UseDefaultArchiveDirectory
    )

    $MigratorOptions = [RelativityArmArchiveJobMigratorOptions]::New($IncludeDatabaseBackup, $IncludeDtSearch, $IncludeConceptualAnalytics, $IncludeStructuredAnalytics, $IncludeDataGrid)
    $FileOptions = [RelativityArmArchiveJobFileOptions]::New($IncludeRepositoryFiles, $IncludeLinkedFiles, $MissingFileBehavior)
    $ProcessingOptions = [RelativityArmArchiveJobProcessingOptions]::New($IncludeProcessing, $IncludeProcessingFiles, $ProcessingMissingFileBehavior)
    $ExtendedWorkspaceDataOptions = [RelativityArmArchiveJobExtendedWorkspaceDataOptions]::New($IncludeExtendedWorkspaceData, $ApplicationErrorExportBehavior)
    $NotificationOptions = [RelativityArmArchiveJobNotificationOptions]::New($NotifyJobCreator, $NotifyJobExecutor)

    $RelativityArmArchiveJobCreateRequest = [RelativityArmArchiveJobCreateRequest]::New($WorkspaceId, $JobPriority, $ArchiveDirectory, $ScheduledStartTime, $MigratorOptions, $FileOptions, $ProcessingOptions, $ExtendedWorkspaceDataOptions, $NotificationOptions, $UiJobActionsLocked, $UseDefaultArchiveDirectory)

    $RelativityApiRequestBody =
    @{
        request = $RelativityArmArchiveJobCreateRequest.ToHashTable()
    }

    $RelativityApiEndpointExtended = "archive-jobs"

    Invoke-RelativityApiRequest -RelativityBusinessDomain "ARM" -RelativityApiEndpointExtended $RelativityApiEndpointExtended -RelativityApiHttpMethod "Post" -RelativityApiRequestBody $RelativityApiRequestBody
}