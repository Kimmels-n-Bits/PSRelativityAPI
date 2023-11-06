class RelativityArmJobNotificationOptions
{
    [Boolean] $NotifyJobCreator
    [Boolean] $NotifyJobExecutor

    RelativityArmJobNotificationOptions(
        [Boolean] $notifyJobCreator,
        [Boolean] $notifyJobExecutor
    )
    {
        $this.NotifyJobCreator = $notifyJobCreator
        $this.NotifyJobExecutor = $notifyJobExecutor
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("NotifyJobCreator", $this.NotifyJobCreator)
        $ReturnValue.Add("NotifyJobExecutor", $this.NotifyJobExecutor)

        return $ReturnValue
    }
}

<# Used by the Move job type directly and the Restore and DatabaseRestore job types through inheritance #>
class RelativityArmJobDestinationOptions
{
    [Int32] $DatabaseServerID
    [Int32] $ResourcePoolID
    [Int32] $CacheLocationID
    [Int32] $FileRepositoryID

    RelativityArmJobDestinationOptions(
        [Int32] $databaseServerID,
        [Int32] $resourcePoolID,
        [Int32] $cacheLocationID,
        [Int32] $fileRepositoryID
    )
    {
        $this.DatabaseServerID = $databaseServerID
        $this.ResourcePoolID = $resourcePoolID
        $this.CacheLocationID = $cacheLocationID
        $this.FileRepositoryID = $fileRepositoryID
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("DatabaseServerID", $this.DatabaseServerID)
        $ReturnValue.Add("ResourcePoolID", $this.ResourcePoolID)
        $ReturnValue.Add("CacheLocationID", $this.CacheLocationID)
        $ReturnValue.Add("FileRepositoryID", $this.FileRepositoryID)

        return $ReturnValue
    }
}

class RelativityArmJobActionHistory
{
    [DateTime] $Date
    [String] $Type
    [String] $UserName

    RelativityArmJobActionHistory(
        [DateTime] $date,
        [String] $type,
        [String] $userName
    )
    {
        $this.Date = $date
        $this.Type = $type
        $this.UserName = $userName
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("Date", $this.Date)
        $ReturnValue.Add("Type", $this.Type)
        $ReturnValue.Add("UserName", $this.UserName)

        return $ReturnValue
    }
}

class RelativityArmJobDetails
{
    [DateTime] $CreatedOn
    [DateTime] $ModifiedTime
    [String] $SubmittedBy
    [String] $State
    [String] $Priority
    [RelativityArmJobActionHistory[]] $ActionsHistory

    RelativityArmJobDetails(
        [DateTime] $createdOn,
        [DateTime] $modifiedTime,
        [String] $submittedBy,
        [String] $state,
        [String] $priority,
        [RelativityArmJobActionHistory[]] $actionsHistory
    )
    {
        $this.CreatedOn = $createdOn
        $this.ModifiedTime = $modifiedTime
        $this.SubmittedBy = $submittedBy
        $this.State = $state
        $this.Priority = $priority
        $this.ActionsHistory = $actionsHistory
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("CreatedOn", $this.CreatedOn)
        $ReturnValue.Add("ModifiedTime", $this.ModifiedTime)
        $ReturnValue.Add("SubmittedBy", $this.SubmittedBy)
        $ReturnValue.Add("State", $this.State)
        $ReturnValue.Add("Priority", $this.Priority)
        $ReturnValue.Add("ActionsHistory", ($this.ActionsHistory | ForEach-Object { $_.ToHashtable() }))

        return $ReturnValue
    }
}

class RelativityArmJobCreateResponse
{
    [Int32] $JobID

    RelativityArmJobCreateResponse(
        [Int32] $jobID
    )
    {
        $this.JobID = $jobID
    }
}

<# This class is used by both "Restore" and "DatabaseRestore" jobs #>
class RelativityArmRestoreJobDestinationOptions : RelativityArmJobDestinationOptions
{
    [Int32] $MatterID

    RelativityArmRestoreJobDestinationOptions(
        [Int32] $databaseServerID,
        [Int32] $resourcePoolID,
        [Int32] $matterID,
        [Int32] $cacheLocationID,
        [Int32] $fileRepositoryID
    ) : base (
        $databaseServerID,
        $resourcePoolID,
        $cacheLocationID,
        $fileRepositoryID
    )
    {
        $this.MatterID = $matterID
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = ([RelativityArmJobDestinationOptions] $this).ToHashTable()

        $ReturnValue.Add("MatterID", $this.MatterID)

        return $ReturnValue
    }
}

class RelativityArmJobBase
{
    [String] $ScheduledStartTime
    [RelativityArmJobNotificationOptions] $NotificationOptions
    [Boolean] $UiJobActionsLocked

    RelativityArmJobBase(
        [String] $scheduledStartTime,
        [RelativityArmJobNotificationOptions] $notificationOptions,
        [Boolean] $uiJobActionsLocked
    )
    {
        $this.ScheduledStartTime = $scheduledStartTime
        $this.NotificationOptions = $notificationOptions
        $this.UiJobActionsLocked = $uiJobActionsLocked
    }

    RelativityArmJobBase(
        [PSCustomObject] $apiResponse
    )
    {
        $this.ScheduledStartTime = $apiResponse.ScheduledStartTime
        
        $this.NotificationOptions = [RelativityArmJobNotificationOptions]::New(
            $apiResponse.NotificationOptions.NotifyJobCreator,
            $apiResponse.NotificationOptions.NotifyJobExecutor
        )

        $this.UiJobActionsLocked = $apiResponse.UiJobActionsLocked
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("ScheduledStartTime", $this.ScheduledStartTime)
        $ReturnValue.Add("NotificationOptions", $this.NotificationOptions.ToHashTable())
        $ReturnValue.Add("UiJobActionsLocked", $this.UiJobActionsLocked)

        return $ReturnValue
    }
}

class RelativityArmJobOptionsBase : RelativityArmJobBase
{
    [String] $JobPriority

    RelativityArmJobOptionsBase(
        [String] $jobPriority,
        [String] $scheduledStartTime,
        [RelativityArmJobNotificationOptions] $notificationOptions,
        [Boolean] $uiJobActionsLocked
    ) : base(
        $scheduledStartTime,
        $notificationOptions,
        $uiJobActionsLocked
    )
    {
        $this.JobPriority = $jobPriority
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = ([RelativityArmJobBase] $this).ToHashTable()

        $ReturnValue.Add("JobPriority", $this.JobPriority)

        return $ReturnValue
    }
}

class RelativityArmJobReadResponseBase : RelativityArmJobBase
{
    [Int32] $JobID
    [String] $JobName
    [Int32] $JobExecutionID
    [Guid] $JobExecutionGuid
    [RelativityArmJobDetails] $JobDetails

    RelativityArmJobReadResponseBase(
        [PSCustomObject] $apiResponse
    ) : base(
        [PSCustomObject] $apiResponse
    )
    {
        $this.JobID = $apiResponse.JobID
        $this.JobName = $apiResponse.JobName
        $this.JobExecutionID = $apiResponse.JobExecutionID
        $this.JobExecutionGuid = $apiResponse.JobExecutionGuid

        $ActionsHistoryValue = New-Object "System.Collections.Generic.List[RelativityArmJobActionHistory]"

        $apiResponse.JobDetails.ActionsHistory | Foreach-Object {
            $ActionsHistoryValue.Add([RelativityArmJobActionHistory]::New(
                $_.Date,
                $_.Type,
                $_.UserName
            ))
        }

        $JobDetailsValue = [RelativityArmJobDetails]::New(
            $apiResponse.JobDetails.CreatedOn,
            $apiResponse.JobDetails.ModifiedTime,
            $apiResponse.JobDetails.SubmittedBy,
            $apiResponse.JobDetails.State,
            $apiResponse.JobDetails.Priority,
            $ActionsHistoryValue.ToArray()
        )

        $this.JobDetails = $JobDetailsValue
    }
}

<# This class is used by both "Restore" and "DatabaseRestore" jobs #>
class RelativityArmRestoreJobUserMapping
{
    [Int32] $ArchiveUserID
    [Int32] $InstanceUserID

    RelativityArmRestoreJobUserMapping(
        [Int32] $archiveUserID,
        [Int32] $instanceUserID
    )
    {
        $this.ArchiveUserID = $archiveUserID
        $this.InstanceUserID = $instanceUserID
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("ArchiveUserID", $this.ArchiveUserID)
        $ReturnValue.Add("InstanceUserID", $this.InstanceUserID)

        return $ReturnValue
    }
}

<# This class is used by both "Restore" and "DatabaseRestore" jobs #>
class RelativityArmRestoreJobGroupMapping
{
    [Int32] $ArchiveGroupID
    [Int32] $InstanceGroupID

    RelativityArmRestoreJobGroupMapping(
        [Int32] $archiveGroupID,
        [Int32] $instanceGroupID
    )
    {
        $this.ArchiveGroupID = $archiveGroupID
        $this.InstanceGroupID = $instanceGroupID
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("ArchiveGroupID", $this.ArchiveGroupID)
        $ReturnValue.Add("InstanceGroupID", $this.InstanceGroupID)

        return $ReturnValue
    }
}

<# This class is used by both "Restore" and "DatabaseRestore" jobs #>
class RelativityArmRestoreJobUserMappingOption
{
    [Boolean] $AutoMapUsers
    [RelativityArmRestoreJobUserMapping[]] $UserMappings

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

<# This class is used by both "Restore" and "DatabaseRestore" jobs #>
class RelativityArmRestoreJobGroupMappingOption
{
    [Boolean] $AutoMapGroups
    [RelativityArmRestoreJobGroupMapping[]] $GroupMappings

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