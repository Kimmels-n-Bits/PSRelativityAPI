class RelativityArmArchiveJobMigratorOptions
{
    [ValidateNotNull()]
    [Boolean] $IncludeDatabaseBackup
    [ValidateNotNull()]
    [Boolean] $IncludeDtSearch
    [ValidateNotNull()]
    [Boolean] $IncludeConceptualAnalytics
    [ValidateNotNull()]
    [Boolean] $IncludeStructuredAnalytics
    [ValidateNotNull()]
    [Boolean] $IncludeDataGrid

    RelativityArmArchiveJobMigratorOptions([Boolean] $includeDatabaseBackup, [Boolean] $includeDtSearch, [Boolean] $includeConceptualAnalytics, [Boolean] $includeStructuredAnalytics, [Boolean] $includeDataGrid)
    {
        $this.IncludeDatabaseBackup = $includeDatabaseBackup
        $this.IncludeDtSearch = $includeDtSearch
        $this.IncludeConceptualAnalytics = $includeConceptualAnalytics
        $this.IncludeStructuredAnalytics = $includeStructuredAnalytics
        $this.IncludeDataGrid = $includeDataGrid
    }

    [Hashtable] ToHashTable()
    {
        return @{
            IncludeDatabaseBackup = $this.IncludeDatabaseBackup
            IncludeDtSearch = $this.IncludeDtSearch
            IncludeConceptualAnalytics = $this.IncludeConceptualAnalytics
            IncludeStructuredAnalytics = $this.IncludeStructuredAnalytics
            IncludeDataGrid = $this.IncludeDataGrid
        }
    }
}

class RelativityArmArchiveJobFileOptions
{
    [ValidateNotNull()]
    [Boolean] $IncludeRepositoryFiles
    [ValidateNotNull()]
    [Boolean] $IncludeLinkedFiles
    [ValidateSet("SkipFile", "StopJob")]
    [String] $MissingFileBehavior

    RelativityArmArchiveJobFileOptions([Boolean] $includeRepositoryFiles, [Boolean] $includeLinkedFiles, [String] $missingFileBehavior)
    {
        $this.IncludeRepositoryFiles = $includeRepositoryFiles
        $this.IncludeLinkedFiles = $includeLinkedFiles
        $this.MissingFileBehavior = $missingFileBehavior
    }

    [Hashtable] ToHashTable()
    {
        return @{
            IncludeRepositoryFiles = $this.IncludeRepositoryFiles
            IncludeLinkedFiles = $this.IncludeLinkedFiles
            MissingFileBehavior = $this.MissingFileBehavior
        }
    }
}

class RelativityArmArchiveJobProcessingOptions
{
    [ValidateNotNull()]
    [Boolean] $IncludeProcessing
    [ValidateNotNull()]
    [Boolean] $IncludeProcessingFiles
    [ValidateSet("SkipFile", "StopJob")]
    [String] $ProcessingMissingFileBehavior

    RelativityArmArchiveJobProcessingOptions([Boolean] $includeProcessing, [Boolean] $includeProcessingFiles, [String] $processingMissingFileBehavior)
    {
        $this.IncludeProcessing = $includeProcessing
        $this.IncludeProcessingFiles = $includeProcessingFiles
        $this.ProcessingMissingFileBehavior = $processingMissingFileBehavior
    }

    [Hashtable] ToHashTable()
    {
        return @{
            IncludeProcessing = $this.IncludeProcessing
            IncludeProcessingFiles = $this.IncludeProcessingFiles
            ProcessingMissingFileBehavior = $this.ProcessingMissingFileBehavior
        }
    }
}

class RelativityArmArchiveJobExtendedWorkspaceDataOptions
{
    [ValidateNotNull()]
    [Boolean] $IncludeExtendedWorkspaceData
    [ValidateSet("SkipApplication", "StopJob")]
    [String] $ApplicationErrorExportBehavior

    RelativityArmArchiveJobExtendedWorkspaceDataOptions([Boolean] $includeExtendedWorkspaceData, [String] $applicationErrorExportBehavior)
    {
        $this.IncludeExtendedWorkspaceData = $includeExtendedWorkspaceData
        $this.ApplicationErrorExportBehavior = $applicationErrorExportBehavior
    }

    [Hashtable] ToHashTable()
    {
        return @{
            IncludeExtendedWorkspaceData = $this.IncludeExtendedWorkspaceData
            ApplicationErrorExportBehavior = $this.ApplicationErrorExportBehavior
        }
    }
}

class RelativityArmArchiveJobNotificationOptions
{
    [ValidateNotNull()]
    [Boolean] $NotifyJobCreator
    [ValidateNotNull()]
    [Boolean] $NotifyJobExecutor

    RelativityArmArchiveJobNotificationOptions([Boolean] $notifyJobCreator, [Boolean] $notifyJobExecutor)
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

class RelativityArmArchiveJobCreateRequest
{
    [ValidateNotNull()]
    [Int32] $WorkspaceId
    [ValidateSet("Low", "Medium", "High")]
    [String] $JobPriority
    [ValidateNotNull()]
    [String] $ArchiveDirectory
    [ValidateNotNull()]
    [String] $ScheduledStartTime
    [ValidateNotNull()]
    [RelativityArmArchiveJobMigratorOptions] $MigratorOptions
    [ValidateNotNull()]
    [RelativityArmArchiveJobFileOptions] $FileOptions
    [ValidateNotNull()]
    [RelativityArmArchiveJobProcessingOptions] $ProcessingOptions
    [ValidateNotNull()]
    [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $ExtendedWorkspaceDataOptions
    [ValidateNotNull()]
    [RelativityArmArchiveJobNotificationOptions] $NotificationOptions
    [ValidateNotNull()]
    [Boolean] $UiJobActionsLocked
    [ValidateNotNull()]
    [Boolean] $UseDefaultArchiveDirectory

    RelativityArmArchiveJobCreateRequest([Int32] $workspaceId, [String] $jobPriority, [String] $archiveDirectory, [String] $scheduledStartTime, [RelativityArmArchiveJobMigratorOptions] $migratorOptions, [RelativityArmArchiveJobFileOptions] $fileOptions, [RelativityArmArchiveJobProcessingOptions] $processingOptions, [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions, [RelativityArmArchiveJobNotificationOptions] $notificationOptions, [Boolean] $uiJobActionsLocked, [Boolean] $useDefaultArchiveDirectory)
    {
        $this.WorkspaceId = $workspaceId
        $this.JobPriority = $jobPriority
        $this.ArchiveDirectory = $archiveDirectory
        $this.ScheduledStartTime = $scheduledStartTime
        $this.MigratorOptions = $migratorOptions
        $this.FileOptions = $fileOptions
        $this.ProcessingOptions = $processingOptions
        $this.ExtendedWorkspaceDataOptions = $extendedWorkspaceDataOptions
        $this.NotificationOptions = $notificationOptions
        $this.UiJobActionsLocked = $uiJobActionsLocked
        $this.UseDefaultArchiveDirectory = $useDefaultArchiveDirectory
    }

    [Hashtable] ToHashTable()
    {
        return @{
            WorkspaceID = $this.WorkspaceId
            ArchiveDirectory = $this.ArchiveDirectory
            JobPriority = $this.JobPriority
            ScheduledStartTime = $this.ScheduledStartTime
            MigratorOptions = $this.MigratorOptions.ToHashTable()
            FileOptions = $this.FileOptions.ToHashTable()
            ProcessingOptions = $this.ProcessingOptions.ToHashTable()
            ExtendedWorkspaceDataOptions = $this.ExtendedWorkspaceDataOptions.ToHashTable()
            NotificationOptions = $this.NotificationOptions.ToHashTable()
            UIJobActionsLocked = $this.UiJobActionsLocked
            UseDefaultArchiveDirectory = $this.UseDefaultArchiveDirectory
        }
    }
}

class RelativityArmArchiveJobCreateResponse
{
    [ValidateNotNull()]
    [Int32] $JobId

    RelativityArmArchiveJobCreateResponse([Int32] $jobId)
    {
        $this.JobId = $jobId
    }
}