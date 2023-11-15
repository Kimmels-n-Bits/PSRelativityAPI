function Get-RelativityArmMoveJobCreateOrUpdateRequest
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $SourceWorkspaceID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String] $JobPriority,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $ScheduledStartTime,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $LinkToExistingDocuments,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String] $MissingFileBehavior,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String] $LinkedFileBehavior,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $IncludeDatabaseBackup,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $CustomDatabasePath,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $ResourcePoolID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $DatabaseServerID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $CacheLocationID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $FileRepositoryID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $NotifyJobCreator,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $NotifyJobExecutor,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $UiJobActionsLocked
    )
    
    Begin
    {
        Write-Verbose "Starting Get-RelativityArmMoveJobCreateOrUpdateRequest"
    }
    Process
    {
        $FileOptions = [RelativityArmMoveJobFileOptions]::New(
            $LinkToExistingDocuments,
            $MissingFileBehavior,
            $LinkedFileBehavior
        )

        $DatabaseOptions = [RelativityArmMoveJobDatabaseOptions]::New(
            $IncludeDatabaseBackup,
            $CustomDatabasePath
        )

        $DestinationOptions = [RelativityArmJobDestinationOptions]::New(
            $DatabaseServerID,
            $ResourcePoolID,
            $CacheLocationID,
            $FileRepositoryID
        )

        $NotificationOptions = [RelativityArmJobNotificationOptions]::New(
            $NotifyJobCreator,
            $NotifyJobExecutor
        )

        $JobOptions = [RelativityArmMoveJobOptions]::New(
            $SourceWorkspaceID,
            $JobPriority,
            $ScheduledStartTime,
            $FileOptions,
            $DatabaseOptions,
            $DestinationOptions,
            $NotificationOptions,
            $UiJobActionsLocked
        )

        $Request = [RelativityArmMoveJobCreateOrUpdateRequest]::New(
            $JobOptions
        )

        return $Request
    }
    End
    {
        Write-Verbose "Completed Get-RelativityArmMoveJobCreateOrUpdateRequest"
    }
}