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