class RelativityArmDatabaseRestoreJobOptions : RelativityArmJobOptionsBase
{
    [String] $SourceDatabase
    [RelativityArmRestoreJobDestinationOptions] $DestinationOptions
    [RelativityArmRestoreJobUserMappingOption] $UserMapping
    [RelativityArmRestoreJobGroupMappingOption] $GroupMapping

    RelativityArmDatabaseRestoreJobOptions(
        [String] $sourceDatabase,
        [String] $jobPriority,
        [String] $scheduledStartTime,
        [RelativityArmRestoreJobDestinationOptions] $destinationOptions,
        [RelativityArmRestoreJobUserMappingOption] $userMapping,
        [RelativityArmRestoreJobGroupMappingOption] $groupMapping,
        [RelativityArmJobNotificationOptions] $notificationOptions,
        [Boolean] $uiJobActionsLocked
    ) : base(
        $jobPriority,
        $scheduledStartTime,
        $notificationOptions,
        $uiJobActionsLocked
    )
    {
        $this.SourceDatabase = $sourceDatabase
        $this.DestinationOptions = $destinationOptions
        $this.UserMapping = $userMapping
        $this.GroupMapping = $groupMapping
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = ([RelativityArmJobOptionsBase] $this).ToHashTable()

        $ReturnValue.Add("SourceDatabase", $this.SourceDatabase)
        $ReturnValue.Add("DestinationOptions", $this.DestinationOptions.ToHashTable())
        $ReturnValue.Add("UserMapping", $this.UserMapping.ToHashTable())
        $ReturnValue.Add("GroupMapping", $this.GroupMapping.ToHashTable())

        return $ReturnValue
    }
}

class RelativityArmDatabaseRestoreJobCreateOrUpdateRequest
{
    [RelativityArmDatabaseRestoreJobOptions] $Request

    RelativityArmDatabaseRestoreJobCreateOrUpdateRequest(
        [RelativityArmDatabaseRestoreJobOptions] $request
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