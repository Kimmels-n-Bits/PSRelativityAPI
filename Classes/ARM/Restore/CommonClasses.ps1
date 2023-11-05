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

class RelativityArmRestoreJobMigratorsDestinationOptions
{
    [Int32] $StructuredAnalyticsServerID
    [Int32] $ConceptualAnalyticsServerID
    [Int32] $DtSearchLocationID

    RelativityArmRestoreJobMigratorsDestinationOptions(
        [Int32] $structuredAnalyticsServerID,
        [Int32] $conceptualAnalyticsServerID,
        [Int32] $dtSearchLocationID
    )
    {
        $this.StructuredAnalyticsServerID = $structuredAnalyticsServerID
        $this.ConceptualAnalyticsServerID = $conceptualAnalyticsServerID
        $this.DtSearchLocationID = $dtSearchLocationID
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("StructuredAnalyticsServerID", $this.StructuredAnalyticsServerID)
        $ReturnValue.Add("ConceptualAnalyticsServerID", $this.ConceptualAnalyticsServerID)
        $ReturnValue.Add("DtSearchLocationID", $this.DtSearchLocationID)

        return $ReturnValue
    }
}

class RelativityArmRestoreJobAdvancedFileOptions
{
    [Boolean] $ReferenceFilesAsArchiveLinks
    [Boolean] $UpdateRepositoryFilePaths
    [Boolean] $UpdateLinkedFilePaths

    RelativityArmRestoreJobAdvancedFileOptions(
        [Boolean] $referenceFilesAsArchiveLinks,
        [Boolean] $updateRepositoryFilePaths,
        [Boolean] $updateLinkedFilePaths
    )
    {
        $this.ReferenceFilesAsArchiveLinks = $referenceFilesAsArchiveLinks
        $this.UpdateRepositoryFilePaths = $updateRepositoryFilePaths
        $this.UpdateLinkedFilePaths = $updateLinkedFilePaths
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("ReferenceFilesAsArchiveLinks", $this.ReferenceFilesAsArchiveLinks)
        $ReturnValue.Add("UpdateRepositoryFilePaths", $this.UpdateRepositoryFilePaths)
        $ReturnValue.Add("UpdateLinkedFilePaths", $this.UpdateLinkedFilePaths)

        return $ReturnValue
    }
}

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

class RelativityArmRestoreJobApplication
{
    [String] $Name
    [Guid] $Guid
    [Boolean] $ShouldRestore

    RelativityArmRestoreJobApplication(
        [String] $name,
        [Guid] $guid,
        [Boolean] $shouldRestore
    )
    {
        $this.Name = $name
        $this.Guid = $guid
        $this.ShouldRestore = $shouldRestore
    }

    RelativtyArmRestoreJobApplication(
        [Guid] $guid,
        [Boolean] $shouldRestore
    )
    {
        $this.Guid = $guid
        $this.ShouldRestore = $shouldRestore
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        if ($null -ne $this.Name)
        {
            $ReturnValue.Add("Name", $this.Name)
        }

        $ReturnValue.Add("Guid", $this.Guid)
        $ReturnValue.Add("ShouldRestore", $this.ShouldRestore)

        return $ReturnValue
    }
}

class RelativityArmRestoreJobBase
{
    [String] $ArchivePath
    [String] $ScheduledStartTime
    [String] $ExistingTargetDatabase
    [RelativityArmRestoreJobDestinationOptions] $DestinationOptions
    [RelativityArmRestoreJobMigratorsDestinationOptions] $MigratorsDestinationOptions
    [RelativityArmRestoreJobAdvancedFileOptions] $AdvancedFileOptions
    [RelativityArmRestoreJobApplication[]] $Applications
    [RelativityArmJobNotificationOptions] $NotificationOptions
    [Boolean] $UiJobActionsLocked

    RelativityArmRestoreJobBase(
        [String] $archivePath,
        [String] $scheduledStartTime,
        [String] $existingTargetDatabase,
        [RelativityArmRestoreJobDestinationOptions] $destinationOptions,
        [RelativityArmRestoreJobMigratorsDestinationOptions] $migratorsDestinationOptions,
        [RelativityArmRestoreJobAdvancedFileOptions] $advancedFileOptions,
        [RelativityArmRestoreJobApplication[]] $applications,
        [RelativityArmJobNotificationOptions] $notificationOptions,
        [Boolean] $uiJobActionsLocked
    )
    {
        $this.ArchivePath = $archivePath
        $this.ScheduledStartTime = $scheduledStartTime
        $this.ExistingTargetDatabase = $existingTargetDatabase
        $this.DestinationOptions = $destinationOptions
        $this.MigratorsDestinationOptions = $migratorsDestinationOptions
        $this.AdvancedFileOptions = $advancedFileOptions
        $this.Applications = $applications
        $this.NotificationOptions = $notificationOptions
        $this.UiJobActionsLocked = $uiJobActionsLocked
    }

    RelativityArmRestoreJobBase([PSCustomObject] $apiResponse)
    {
        $this.ArchivePath = $apiResponse.ArchivePath
        $this.ScheduledStartTime = $apiResponse.ScheduledStartTime
        $this.ExistingTargetDatabase = $apiResponse.ExistingTargetDatabase
        
        $this.DestinationOptions = [RelativityArmRestoreJobDestinationOptions]::New(
            $apiResponse.DestinationOptions.DatabaseServerID,
            $apiResponse.DestinationOptions.ResourcePoolID,
            $apiResponse.DestinationOptions.MatterID,
            $apiResponse.DestinationOptions.CacheLocationID,
            $apiResponse.DestinationOptions.FileRepositoryID
        )

        $this.MigratorsDestinationOptions = [RelativityArmRestoreJobMigratorsDestinationOptions]::New(
            $apiResponse.MigratorsDestinationOptions.StructuredAnalyticsServerID,
            $apiResponse.MigratorsDestinationOptions.ConceptualAnalyticsServerID,
            $apiResponse.MigratorsDestinationOptions.DtSearchLocationID
        )

        $this.AdvancedFileOptions = [RelativityArmRestoreJobAdvancedFileOptions]::New(
            $apiResponse.AdvancedFileOptions.ReferenceFilesAsArchiveLinks,
            $apiResponse.AdvancedFileOptions.UpdateRepositoryFilePaths,
            $apiResponse.AdvancedFileOptions.UpdateLinkedFilePaths
        )

        $ApplicationsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobApplication]"

        $apiResponse.Applications | ForEach-Object {
            $ApplicationsValue.Add([RelativityArmRestoreJobApplication]::New(
                $_.Name,
                $_.Guid,
                $_.ShouldRestore
            ))
        }

        $this.Applications = $ApplicationsValue.ToArray()

        $this.NotificationOptions = [RelativityArmJobNotificationOptions]::New(
            $apiResponse.NotificationOptions.NotifyJobCreator,
            $apiResponse.NotificationOptions.NotifyJobExecutor
        )

        $this.UiJobActionsLocked = $apiResponse.uiJobActionsLocked
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("ArchivePath", $this.ArchivePath)
        $ReturnValue.Add("ScheduledStartTime", $this.ScheduledStartTime)
        $ReturnValue.Add("ExistingTargetDatabase", $this.ExistingTargetDatabase)
        $ReturnValue.Add("DestinationOptions", $this.DestinationOptions.ToHashTable())
        $ReturnValue.Add("MigratorsDestinationOptions", $this.MigratorsDestinationOptions.ToHashTable())
        $ReturnValue.Add("AdvancedFileOptions", $this.AdvancedFileOptions.ToHashTable())
        $ReturnValue.Add("Applications", ($this.Applications | ForEach-Object { $_.ToHashTable() }))
        $ReturnValue.Add("NotificationOptions", $this.NotificationOptions.ToHashTable())
        $ReturnValue.Add("UiJobActionsLocked", $this.UiJobActionsLocked)

        return $ReturnValue
    }
}