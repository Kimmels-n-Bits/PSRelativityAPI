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
}

class RelativityArmArchiveJob
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

    RelativityArmArchiveJob([Int32] $workspaceId, [String] $jobPriority, [String] $archiveDirectory, [String] $scheduledStartTime, [RelativityArmArchiveJobMigratorOptions] $migratorOptions, [RelativityArmArchiveJobFileOptions] $fileOptions, [RelativityArmArchiveJobProcessingOptions] $processingOptions, [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions, [RelativityArmArchiveJobNotificationOptions] $notificationOptions, [Boolean] $uiJobActionsLocked, [Boolean] $useDefaultArchiveDirectory)
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
}