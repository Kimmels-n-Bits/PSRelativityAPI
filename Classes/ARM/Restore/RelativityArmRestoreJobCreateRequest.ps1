class RelativityArmRestoreJobCreateRequest 
{
    [ValidateNotNull()]
    [String] $ArchivePath
    [ValidateSet("Low", "Medium", "High")]
    [String] $JobPriority
    [ValidateNotNull()]
    [String] $ScheduledStartTime
    [String] $ExistingTargetDatabase
    [ValidateNotNull()]
    [RelativityArmRestoreJobDestinationOptions] $DestinationOptions
    [ValidateNotNull()]
    [RelativityArmRestoreJobMigratorsDestinationOptions] $MigratorsDestinationOptions
    [ValidateNotNull()]
    [RelativityArmRestoreJobAdvancedFileOptions] $AdvancedFileOptions
    [ValidateNotNull()]
    [RelativityArmRestoreJobUserMapping] $UserMapping
    [ValidateNotNull()]
    [RelativityArmRestoreJobGroupMapping] $GroupMapping
    [ValidateNotNull()]
    [RelativityArmRestoreJobApplication[]] $Applications
    [ValidateNotNull()]
    [RelativityArmRestoreJobNotificationOptions] $NotificationOptions
    [ValidateNotNull()]
    [Boolean] $UiJobActionsLocked

    RelativityArmRestoreJobCreateRequest([String] $archivePath, [String] $jobPriority, [String] $scheduledStartTime, [String] $existingTargetDatabase, [RelativityArmRestoreJobDestinationOptions] $destinationOptions, [RelativityArmRestoreJobMigratorsDestinationOptions] $migratorsDestinationOptions, [RelativityArmRestoreJobAdvancedFileOptions] $advancedFileOptions, [RelativityArmRestoreJobUserMapping] $userMapping, [RelativityArmRestoreJobGroupMapping] $groupMapping, [RelativityArmRestoreJobApplication[]] $applications, [RelativityArmRestoreJobNotificationOptions] $notificationOptions, [Boolean] $uiJobActionsLocked)
    {
        $this.ArchivePath = $archivePath
        $this.JobPriority = $jobPriority
        $this.ScheduledStartTime = $scheduledStartTime
        $this.ExistingTargetDatabase = $existingTargetDatabase
        $this.DestinationOptions = $destinationOptions
        $this.MigratorsDestinationOptions = $migratorsDestinationOptions
        $this.AdvancedFileOptions = $advancedFileOptions
        $this.UserMapping = $userMapping
        $this.GroupMapping = $groupMapping
        $this.Applications = $applications
        $this.NotificationOptions = $notificationOptions
        $this.UiJobActionsLocked = $uiJobActionsLocked
    }

    [Hashtable] ToHashTable()
    {
        return @{
            ArchivePath = $this.ArchivePath
            JobPriority = $this.JobPriority
            ScheduledStartTime = $this.ScheduledStartTime
            ExistingTargetDatabase = if ($this.ExistingTargetDatabase -eq "") { $null } else { $this.ExistingTargetDatabase }
            DestinationOptions = $this.DestinationOptions.ToHashTable()
            MigratorsDestinationOptions = $this.MigratorsDestinationOptions.ToHashTable()
            AdvancedFileOptions = $this.AdvancedFileOptions.ToHashTable()
            UserMapping = $this.UserMapping.ToHashTable()
            GroupMapping = $this.GroupMapping.ToHashTable()
            Applications = $this.Applications
            NotificationOptions = $this.NotificationOptions.ToHashTable()
            UiJobActionsLocked = $this.UiJobActionsLocked
        }
    }
}

