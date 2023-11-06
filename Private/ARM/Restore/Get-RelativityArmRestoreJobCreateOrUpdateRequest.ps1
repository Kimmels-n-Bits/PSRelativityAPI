function Get-RelativityArmRestoreJobCreateOrUpdateRequest
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String] $ArchivePath,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String] $JobPriority,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $ScheduledStartTime,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $ExistingTargetDatabase,
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
        [Int32] $StructuredAnalyticsServerID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $ConceptualAnalyticsServerID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $DtSearchLocationID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $ReferenceFilesAsArchiveLinks,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $UpdateRepositoryFilePaths,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $UpdateLinkedFilePaths,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $AutoMapUsers,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Hashtable[]] $UserMappings,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $AutoMapGroups,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Hashtable[]] $GroupMappings,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Hashtable[]] $Applications,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $NotifyJobCreator,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $NotifyJobExecutor,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Boolean] $UiJobActionsLocked
    )
    
    Begin
    {
        Write-Verbose "Starting Get-RelativityArmRestoreJobCreateOrUpdateRequest"
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

        $MigratorsDestinationOptions = [RelativityArmRestoreJobMigratorsDestinationOptions]::New(
            $StructuredAnalyticsServerID,
            $ConceptualAnalyticsServerID,
            $DtSearchLocationID
        )

        $AdvancedFileOptions = [RelativityArmRestoreJobAdvancedFileOptions]::New(
            $ReferenceFilesAsArchiveLinks,
            $UpdateRepositoryFilePaths,
            $UpdateLinkedFilePaths
        )
        
        $UserMapping = [RelativityArmRestoreJobUserMappingOption]::New(
            $AutoMapUsers,
            $UserMappings
        )

        $GroupMapping = [RelativityArmRestoreJobGroupMappingOption]::New(
            $AutoMapGroups,
            $GroupMappings
        )

        $ApplicationsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobApplication]"
        if ($null -ne $Applications)
        {
            $Applications | ForEach-Object {
                if (-not $_.ContainsKey("Guid") -or -not $_.ContainsKey("ShouldRestore"))
                {
                    throw "Applications hashtable array has at least one item missing a required key. Ensure all hashtables in the array contain both 'Guid' and 'ShouldRestore'."
                }
                else 
                {
                    $ApplicationsValue.Add([RelativityArmRestoreJobApplication]::New(
                        $_.Guid,
                        $_.ShouldRestore
                    ))
                }
            }
        }

        $NotificationOptions = [RelativityArmJobNotificationOptions]::New(
            $NotifyJobCreator,
            $NotifyJobExecutor
        )

        $JobOptions = [RelativityArmRestoreJobOptions]::New(
            $ArchivePath,
            $JobPriority,
            $ScheduledStartTime,
            $ExistingTargetDatabase,
            $DestinationOptions,
            $MigratorsDestinationOptions,
            $AdvancedFileOptions,
            $UserMapping,
            $GroupMapping,
            $ApplicationsValue.ToArray(),
            $NotificationOptions,
            $UiJobActionsLocked
        )

        $Request = [RelativityArmRestoreJobCreateOrUpdateRequest]::New(
            $JobOptions
        )

        return $Request
    }
    End
    {
        Write-Verbose "Completed Get-RelativityArmRestoreJobCreateOrUpdateRequest"
    }
}