class RelativityArmDatabaseRestoreJobOptions : RelativityArmDatabaseRestoreJobBase
{
    [String] $JobPriority
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
    ): base(
        $sourceDatabase,
        $scheduledStartTime,
        $destinationOptions,
        $notificationOptions,
        $uiJobActionsLocked
    )
    {
        $this.JobPriority = $jobPriority
        $this.UserMapping = $userMapping
        $this.GroupMapping = $groupMapping
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = ([RelativityArmDatabaseRestoreJobBase] $this).ToHashTable()

        $ReturnValue.Add("JobPriority", $this.JobPriority)
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