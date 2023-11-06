class RelativityArmDatabaseRestoreJobBase
{
    [String] $SourceDatabase
    [String] $ScheduledStartTime
    [RelativityArmRestoreJobDestinationOptions] $DestinationOptions
    [RelativityArmRestoreJobMigratorsDestinationOptions] $MigratorsDestinationOptions
    [RelativityArmRestoreJobAdvancedFileOptions] $AdvancedFileOptions
    [RelativityArmRestoreJobApplication[]] $Applications
    [RelativityArmJobNotificationOptions] $NotificationOptions
    [Boolean] $UiJobActionsLocked

    RelativityArmRestoreJobBase(
        [String] $sourceDatabase,
        [String] $scheduledStartTime,
        [RelativityArmRestoreJobDestinationOptions] $destinationOptions,
        [RelativityArmJobNotificationOptions] $notificationOptions,
        [Boolean] $uiJobActionsLocked
    )
    {
        $this.SourceDatabase = $sourceDatabase
        $this.ScheduledStartTime = $scheduledStartTime
        $this.DestinationOptions = $destinationOptions
        $this.NotificationOptions = $notificationOptions
        $this.UiJobActionsLocked = $uiJobActionsLocked
    }

    RelativityArmRestoreJobBase([PSCustomObject] $apiResponse)
    {
        $this.SourceDatabase = $apiResponse.SourceDatabase
        $this.ScheduledStartTime = $apiResponse.ScheduledStartTime
        
        $this.DestinationOptions = [RelativityArmRestoreJobDestinationOptions]::New(
            $apiResponse.DestinationOptions.DatabaseServerID,
            $apiResponse.DestinationOptions.ResourcePoolID,
            $apiResponse.DestinationOptions.MatterID,
            $apiResponse.DestinationOptions.CacheLocationID,
            $apiResponse.DestinationOptions.FileRepositoryID
        )

        $this.NotificationOptions = [RelativityArmJobNotificationOptions]::New(
            $apiResponse.NotificationOptions.NotifyJobCreator,
            $apiResponse.NotificationOptions.NotifyJobExecutor
        )

        $this.UiJobActionsLocked = $apiResponse.uiJobActionsLocked
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("SourceDatabase", $this.SourceDatabase)
        $ReturnValue.Add("ScheduledStartTime", $this.ScheduledStartTime)
        $ReturnValue.Add("DestinationOptions", $this.DestinationOptions.ToHashTable())
        $ReturnValue.Add("NotificationOptions", $this.NotificationOptions.ToHashTable())
        $ReturnValue.Add("UiJobActionsLocked", $this.UiJobActionsLocked)

        return $ReturnValue
    }
}