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
        $ReturnValue.Add("Applications", ($this.Applications | ForEach-Object { $_.ToHashTable() }))
        $ReturnValue.Add("NotificationOptions", $this.NotificationOptions.ToHashTable())
        $ReturnValue.Add("UiJobActionsLocked", $this.UiJobActionsLocked)

        return $ReturnValue
    }
}