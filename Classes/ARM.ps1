class RelativityArmArchiveJobMigratorOptions
{
    [Boolean] $IncludeDatabaseBackup
    [Boolean] $IncludeDtSearch
    [Boolean] $IncludeConceptualAnalytics
    [Boolean] $IncludeStructuredAnalytics
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
    [Boolean] $IncludeRepositoryFiles
    [Boolean] $IncludeLinkedFiles
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
    [Boolean] $IncludeProcessing
    [Boolean] $IncludeProcessingFiles
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
    [Boolean] $IncludeExtendedWorkspaceData
    [String] $ApplicationErrorExportBehavior

    RelativityArmArchiveJobExtendedWorkspaceDataOptions([Boolean] $includeExtendedWorkspaceData, [String] $applicationErrorExportBehavior)
    {
        $this.IncludeExtendedWorkspaceData = $includeExtendedWorkspaceData
        $this.ApplicationErrorExportBehavior = $applicationErrorExportBehavior
    }
}

class RelativityArmArchiveJobNotificationOptions
{
    [Boolean] $NotifyJobCreator
    [Boolean] $NotifyJobExecutor

    RelativityArmArchiveJobNotificationOptions([Boolean] $notifyJobCreator, [Boolean] $notifyJobExecutor)
    {
        $this.NotifyJobCreator = $notifyJobCreator
        $this.NotifyJobExecutor = $notifyJobExecutor
    }
}

class RelativityArmArchiveJob
{
    [Int32] $WorkspaceId
    [String] $JobPriority
    [String] $ArchiveDirectory
    [String] $ScheduledStartTime
    [RelativityArmArchiveJobMigratorOptions] $MigratorOptions
    [RelativityArmArchiveJobFileOptions] $FileOptions
    [RelativityArmArchiveJobProcessingOptions] $ProcessingOptions
    [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $ExtendedWorkspaceDataOptions
    [RelativityArmArchiveJobNotificationOptions] $NotificationOptions
    [Boolean] $UiJobActionsLocked
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