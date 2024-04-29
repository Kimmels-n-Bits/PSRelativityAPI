class RelativityArmRestoreJobOptions : RelativityArmJobOptionsBase
{
    [String] $ArchivePath
    [String] $ExistingTargetDatabase
    [RelativityArmRestoreJobDestinationOptions] $DestinationOptions
    [RelativityArmRestoreJobMigratorsDestinationOptions] $MigratorsDestinationOptions
    [RelativityArmRestoreJobAdvancedFileOptions] $AdvancedFileOptions
    [RelativityArmRestoreJobUserMappingOption] $UserMapping
    [RelativityArmRestoreJobGroupMappingOption] $GroupMapping
    [RelativityArmRestoreJobApplication[]] $Applications

    RelativityArmRestoreJobOptions(
        [String] $archivePath,
        [String] $jobPriority,
        [String] $scheduledStartTime,
        [String] $existingTargetDatabase,
        [RelativityArmRestoreJobDestinationOptions] $destinationOptions,
        [RelativityArmRestoreJobMigratorsDestinationOptions] $migratorsDestinationOptions,
        [RelativityArmRestoreJobAdvancedFileOptions] $advancedFileOptions,
        [RelativityArmRestoreJobUserMappingOption] $userMapping,
        [RelativityArmRestoreJobGroupMappingOption] $groupMapping,
        [RelativityArmRestoreJobApplication[]] $applications,
        [RelativityArmJobNotificationOptions] $notificationOptions,
        [Boolean] $uiJobActionsLocked
    ) : base(
        $jobPriority,
        $scheduledStartTime,
        $notificationOptions,
        $uiJobActionsLocked
    )
    {
        $this.ArchivePath = $archivePath
        $this.ExistingTargetDatabase = $existingTargetDatabase
        $this.DestinationOptions = $destinationOptions
        $this.MigratorsDestinationOptions = $migratorsDestinationOptions
        $this.AdvancedFileOptions = $advancedFileOptions
        $this.UserMapping = $userMapping
        $this.GroupMapping = $groupMapping
        $this.Applications = $applications
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = ([RelativityArmJobOptionsBase] $this).ToHashTable()

        $ReturnValue.Add("ArchivePath", $this.ArchivePath)

        if ([String]::IsNullOrEmpty($this.ExistingTargetDatabase))
        {
            $ReturnValue.Add("ExistingTargetDatabase", $null)
        }
        else
        {
            $ReturnValue.Add("ExistingTargetDatabase", $this.ExistingTargetDatabase)
        }

        $ReturnValue.Add("DestinationOptions", $this.DestinationOptions.ToHashTable())
        $ReturnValue.Add("MigratorsDestinationOptions", $this.MigratorsDestinationOptions.ToHashTable())
        $ReturnValue.Add("AdvancedFileOptions", $this.AdvancedFileOptions.ToHashTable())
        $ReturnValue.Add("UserMapping", $this.UserMapping.ToHashTable())
        $ReturnValue.Add("GroupMapping", $this.GroupMapping.ToHashTable())
        $ReturnValue.Add("Applications", ($this.Applications | ForEach-Object { $_.ToHashTable() }))

        return $ReturnValue
    }
}

class RelativityArmRestoreJobCreateOrUpdateRequest
{
    [RelativityArmRestoreJobOptions] $Request

    RelativityArmRestoreJobCreateOrUpdateRequest(
        [RelativityArmRestoreJobOptions] $request
    )
    {
        $this.Request = $request
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("Request", $this.Request.ToHashTable())

        return $ReturnValue
    }
}