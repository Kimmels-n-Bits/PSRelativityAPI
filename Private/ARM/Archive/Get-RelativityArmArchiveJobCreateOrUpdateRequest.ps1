function Get-RelativityArmArchiveJobCreateOrUpdateRequest
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $ArtifactID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String] $JobPriority,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String] $ArchiveDirectory,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $ScheduledStartTime,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $IncludeDatabaseBackup,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $IncludeDtSearch,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $IncludeConceptualAnalytics,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $IncludeStructuredAnalytics,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $IncludeDataGrid,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $IncludeRepositoryFiles,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $IncludeLinkedFiles,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String] $MissingFileBehavior,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $IncludeProcessing,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $IncludeProcessingFiles,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String] $ProcessingMissingFileBehavior,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $IncludeExtendedWorkspaceData,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String] $ApplicationErrorExportBehavior,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $NotifyJobCreator,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $NotifyJobExecutor,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $UiJobActionsLocked,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $UseDefaultArchiveDirectory
    )

    Begin
    {
        Write-Verbose "Starting Get-RelativityArmArchiveJobCreateOrUpdateRequest"
    }
    Process
    {
        $MigratorOptions = [RelativityArmArchiveJobMigratorOptions]::New(
            $IncludeDatabaseBackup,
            $IncludeDtSearch,
            $IncludeConceptualAnalytics,
            $IncludeStructuredAnalytics,
            $IncludeDataGrid
        )

        $FileOptions = [RelativityArmArchiveJobFileOptions]::New(
            $IncludeRepositoryFiles,
            $IncludeLinkedFiles,
            $MissingFileBehavior
        
            )
        $ProcessingOptions = [RelativityArmArchiveJobProcessingOptions]::New(
            $IncludeProcessing,
            $IncludeProcessingFiles,
            $ProcessingMissingFileBehavior
        )

        $ExtendedWorkspaceDataOptions = [RelativityArmArchiveJobExtendedWorkspaceDataOptions]::New(
            $IncludeExtendedWorkspaceData,
            $ApplicationErrorExportBehavior
        )

        $NotificationOptions = [RelativityArmJobNotificationOptions]::New(
            $NotifyJobCreator,
            $NotifyJobExecutor
        )

        $JobOptions = [RelativityArmArchiveJobOptions]::New(
            $ArtifactID,
            $JobPriority,
            $ArchiveDirectory,
            $ScheduledStartTime,
            $MigratorOptions,
            $FileOptions,
            $ProcessingOptions,
            $ExtendedWorkspaceDataOptions,
            $NotificationOptions,
            $UiJobActionsLocked,
            $UseDefaultArchiveDirectory
        )

        $Request = [RelativityArmArchiveJobCreateOrUpdateRequest]::New(
            $JobOptions
        )

        return $Request
    }
    End
    {
        Write-Verbose "Completed Get-RelativityArmArchiveJobCreateOrUpdateRequest"
    }
}