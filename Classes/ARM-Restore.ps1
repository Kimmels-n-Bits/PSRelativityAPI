class RelativityArmRestoreJobDestinationOptions
{
    [ValidateNotNull()]
    [Int32] $DatabaseServerID
    [ValidateNotNull()]
    [Int32] $ResourcePoolID
    [ValidateNotNull()]
    [Int32] $MatterID
    [ValidateNotNull()]
    [Int32] $CacheLocationID
    [ValidateNotNull()]
    [Int32] $FileRepositoryID

    RelativityArmRestoreJobDestinationOptions([Int32] $databaseServerID, [Int32] $resourcePoolID, [Int32] $matterID, [Int32] $cacheLocationID, [Int32] $fileRepositoryID)
    {
        $this.DatabaseServerID = $databaseServerID
        $this.ResourcePoolID = $resourcePoolID
        $this.MatterID = $matterID
        $this.CacheLocationID = $cacheLocationID
        $this.FileRepositoryID = $fileRepositoryID
    }

    [Hashtable] ToHashTable()
    {
        return @{
            DatabaseServerID = $this.DatabaseServerID
            ResourcePoolID = $this.ResourcePoolID
            MatterID = $this.MatterID
            CacheLocationID = $this.CacheLocationID
            FileRepositoryID = $this.FileRepositoryID
        }
    }
}

class RelativityArmRestoreJobMigratorsDestinationOptions
{
    [Int32] $StructuredAnalyticsServerID
    [Int32] $ConceptualAnalyticsServerID
    [Int32] $DtSearchLocationID

    RelativityArmRestoreJobMigratorsDestinationOptions([Int32] $structuredAnalyticsServerID, [Int32] $conceptualAnalyticsServerID, [Int32] $dtSearchLocationID)
    {
        $this.StructuredAnalyticsServerID = $structuredAnalyticsServerID
        $this.ConceptualAnalyticsServerID = $conceptualAnalyticsServerID
        $this.DtSearchLocationID = $dtSearchLocationID
    }

    [Hashtable] ToHashTable()
    {
        return @{
            StructuredAnalyticsServerID = $this.StructuredAnalyticsServerID
            ConceptualAnalyticsServerID = $this.ConceptualAnalyticsServerID
            DtSearchLocationID = $this.DtSearchLocationID
        }
    }
}

class RelativityArmRestoreJobAdvancedFileOptions
{
    [ValidateNotNull()]
    [Boolean] $ReferenceFilesAsArchiveLinks
    [ValidateNotNull()]
    [Boolean] $UpdateRepositoryFilePaths
    [ValidateNotNull()]
    [Boolean] $UpdateLinkedFilePaths

    RelativityArmRestoreJobAdvancedFileOptions([Boolean] $referenceFilesAsArchiveLinks, [Boolean] $updateRepositoryFilePaths, [Boolean] $updateLinkedFilePaths)
    {
        $this.ReferenceFilesAsArchiveLinks = $referenceFilesAsArchiveLinks
        $this.UpdateRepositoryFilePaths = $updateRepositoryFilePaths
        $this.UpdateLinkedFilePaths = $updateLinkedFilePaths
    }

    [Hashtable] ToHashTable()
    {
        return @{
            ReferenceFilesAsArchiveLinks = $this.ReferenceFilesAsArchiveLinks
            UpdateRepositoryFilePaths = $this.UpdateRepositoryFilePaths
            UpdateLinkedFilePaths = $this.UpdateLinkedFilePaths
        }
    }
}

class RelativityArmRestoreJobUserMappingItem
{
    [ValidateNotNull()]
    [Int32] $ArchiveUserID
    [ValidateNotNull()]
    [Int32] $InstanceUserID

    RelativityArmRestoreJobUserMappingItem([Int32] $archiveUserID, [Int32] $instanceUserID)
    {
        $this.ArchiveUserID = $archiveUserID
        $this.InstanceUserID = $instanceUserID
    }

    [Hashtable] ToHashTable()
    {
        return @{
            ArchiveUserID = $this.ArchiveUserID
            InstanceUserID = $this.InstanceUserID
        }
    }
}

class RelativityArmRestoreJobUserMapping
{
    [ValidateNotNull()]
    [Boolean] $AutoMapUsers
    [ValidateNotNull()]
    [Hashtable[]] $UserMappings

    RelativityArmRestoreJobUserMapping([Boolean] $autoMapUsers, [Hashtable[]] $userMappings)
    {
        $this.AutoMapUsers = $autoMapUsers
        $this.UserMappings = $userMappings
    }

    [Hashtable] ToHashTable()
    {
        return @{
            AutoMapUsers = $this.AutoMapUsers
            UserMappings = $this.UserMappings
        }
    }
}

class RelativityArmRestoreJobGroupMapping
{
    [ValidateNotNull()]
    [Boolean] $AutoMapGroups
    [ValidateNotNull()]
    [Hashtable[]] $GroupMappings

    RelativityArmRestoreJobGroupMapping([Boolean] $autoMapGroups, [Hashtable[]] $groupMappings)
    {
        $this.AutoMapGroups = $autoMapGroups
        $this.GroupMappings = $groupMappings
    }

    [Hashtable] ToHashTable()
    {
        return @{
            AutoMapGroups = $this.AutoMapGroups
            GroupMappings = $this.GroupMappings
        }
    }
}

class RelativityArmRestoreJobApplication
{
    [ValidateNotNull()]
    [Guid] $Guid
    [ValidateNotNull()]
    [Boolean] $ShouldRestore

    RelativityArmRestoreJobApplication([Guid] $guid, [Boolean] $shouldRestore)
    {
        $this.Guid = $guid
        $this.ShouldRestore = $shouldRestore
    }

    [Hashtable] ToHashTable()
    {
        return @{
            Guid = $this.Guid
            ShouldRestore = $this.ShouldRestore
        }
    }
}

class RelativityArmRestoreJobNotificationOptions
{
    [ValidateNotNull()]
    [Boolean] $NotifyJobCreator
    [ValidateNotNull()]
    [Boolean] $NotifyJobExecutor

    RelativityArmRestoreJobNotificationOptions([Boolean] $notifyJobCreator, [Boolean] $notifyJobExecutor)
    {
        $this.NotifyJobCreator = $notifyJobCreator
        $this.NotifyJobExecutor = $notifyJobExecutor
    }

    [Hashtable] ToHashTable()
    {
        return @{
            NotifyJobCreator = $this.NotifyJobCreator
            NotifyJobExecutor = $this.NotifyJobExecutor
        }
    }
}

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