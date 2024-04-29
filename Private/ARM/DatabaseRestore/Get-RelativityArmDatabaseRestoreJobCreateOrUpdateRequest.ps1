function Get-RelativityArmDatabaseRestoreJobCreateOrUpdateRequest
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String] $SourceDatabase,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String] $JobPriority,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $ScheduledStartTime,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $DatabaseServerID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $ResourcePoolID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $MatterID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $CacheLocationID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $FileRepositoryID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $AutoMapUsers,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Hashtable[]] $UserMappings,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $AutoMapGroups,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Hashtable[]] $GroupMappings,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $NotifyJobCreator,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $NotifyJobExecutor,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $UiJobActionsLocked
    )

    Begin
    {
        Write-Verbose "Starting Get-RelativityArmDatabaseRestoreJobCreateOrUpdateRequest"
    }
    Process
    {
        $DestinationOptions = [RelativityArmRestoreJobDestinationOptions]::New(
            $DatabaseServerID,
            $ResourcePoolID,
            $MatterID,
            $CacheLocationID,
            $FileRepositoryID
        )

        $UserMapping = [RelativityArmRestoreJobUserMappingOption]::New(
            $AutoMapUsers,
            $UserMappings
        )

        $GroupMapping = [RelativityArmRestoreJobGroupMappingOption]::New(
            $AutoMapGroups,
            $GroupMappings
        )

        $NotificationOptions = [RelativityArmJobNotificationOptions]::New(
            $NotifyJobCreator,
            $NotifyJobExecutor
        )

        $JobOptions = [RelativityArmDatabaseRestoreJobOptions]::New(
            $SourceDatabase,
            $JobPriority,
            $ScheduledStartTime,
            $DestinationOptions,
            $UserMapping,
            $GroupMapping,
            $NotificationOptions,
            $UiJobActionsLocked
        )

        $Request = [RelativityArmDatabaseRestoreJobCreateOrUpdateRequest]::New(
            $JobOptions
        )

        return $Request
    }
    End
    {
        Write-Verbose "Completed Get-RelativityArmDatabaseRestoreJobCreateOrUpdateRequest"
    }
}