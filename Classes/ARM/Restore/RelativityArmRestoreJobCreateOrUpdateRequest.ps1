class RelativityArmRestoreJobUserMappingOption
{
    [Boolean] $AutoMapUsers
    [RelativityArmRestoreJobUserMapping[]] $UserMappings

    RelativityArmRestoreJobUserMappingOption(
        [Boolean] $autoMapUsers,
        [RelativityArmRestoreJobUserMapping[]] $userMappings
    )
    {
        $this.AutoMapUsers = $autoMapUsers
        $this.UserMappings = $userMappings
    }

    RelativityArmRestoreJobUserMappingOption(
        [Boolean] $autoMapUsers,
        [Hashtable[]] $userMappings
    )
    {
        $this.AutoMapUsers = $autoMapUsers
        
        $UserMappingsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobUserMapping]"
        if ($null -ne $UserMappings)
        {
            $UserMappings | ForEach-Object {
                if (-not $_.ContainsKey("ArchiveUserID") -or -not $_.ContainsKey("InstanceUserID"))
                {
                    throw "UserMappings hashtable array has at least one item missing a required key. Ensure all hashtables in the array contains both 'ArchiveUserID' and 'InstanceUserID'."
                }
                else
                {
                    $UserMappingsValue.Add([RelativityArmRestoreJobUserMapping]::New(
                        $_.ArchiveUserID,
                        $_.InstanceUserID
                    ))
                }
            }
        }

        $this.UserMappings = $UserMappingsValue.ToArray()
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("AutoMapUsers", $this.AutoMapUsers)
        $ReturnValue.Add("UserMappings", ($this.UserMappings | ForEach-Object { $_.ToHashTable }))

        return $ReturnValue
    }
}

class RelativityArmRestoreJobGroupMappingOption
{
    [Boolean] $AutoMapGroups
    [RelativityArmRestoreJobGroupMapping[]] $GroupMappings

    RelativityArmRestoreJobGroupMappingOption(
        [Boolean] $autoMapGroups,
        [RelativityArmRestoreJobGroupMapping[]] $groupMappings
    )
    {
        $this.AutoMapGroups = $autoMapGroups
        $this.GroupMappings = $groupMappings
    }

    RelativityArmRestoreJobGroupMappingOption(
        [Boolean] $autoMapGroups,
        [Hashtable[]] $groupMappings
    )
    {
        $this.AutoMapGroups = $autoMapGroups
        
        $GroupMappingsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobGroupMapping]"
        if ($null -ne $GroupMappings)
        {
            $GroupMappings | ForEach-Object {
                if (-not $_.ContainsKey("ArchiveGroupID") -or -not $_.ContainsKey("InstanceGroupID"))
                {
                    throw "GroupMappings hashtable array has at least one item missing a required key. Ensure all hashtables in the array contains both 'ArchiveGroupID' and 'InstanceGroupID'."
                }
                else
                {
                    $GroupMappingsValue.Add([RelativityArmRestoreJobGroupMapping]::New(
                        $_.ArchiveGroupID,
                        $_.InstanceGroupID
                    ))
                }
            }
        }
        
        $this.GroupMappings = $GroupMappingsValue.ToArray()
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("AutoMapGroups", $this.AutoMapGroups)
        $ReturnValue.Add("GroupMappings", ($this.GroupMappings | ForEach-Object { $_.ToHashTable }))

        return $ReturnValue
    }
}

class RelativityArmRestoreJobOptions : RelativityArmRestoreJobBase
{
    [String] $JobPriority
    [RelativityArmRestoreJobUserMappingOption] $UserMapping
    [RelativityArmRestoreJobGroupMappingOption] $GroupMapping

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
    ): base(
        $archivePath,
        $scheduledStartTime,
        $existingTargetDatabase,
        $destinationOptions,
        $migratorsDestinationOptions,
        $advancedFileOptions,
        $applications,
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
        $ReturnValue = ([RelativityArmRestoreJobBase] $this).ToHashTable()

        $ReturnValue.Add("JobPriority", $this.JobPriority)
        $ReturnValue.Add("UserMapping", $this.UserMapping)
        $ReturnValue.Add("GroupMapping", $this.GroupMapping)

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