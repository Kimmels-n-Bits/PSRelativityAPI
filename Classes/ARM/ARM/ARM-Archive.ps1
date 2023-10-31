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
    [ValidateSet("", "SkipFile", "StopJob")]
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
    [ValidateSet("", "SkipFile", "StopJob")]
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
    [ValidateSet("", "SkipApplication", "StopJob")]
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

class RelativityArmArchiveJobActionHistory
{
    [ValidateNotNull()]
    [DateTime] $Date
    [ValidateNotNullOrEmpty()]
    [String] $Type
    [ValidateNotNullOrEmpty()]
    [String] $UserName

    RelativityArmArchiveJobActionHistory([DateTime] $date, [String] $type, [String] $userName)
    {
        $this.Date = $date
        $this.Type = $type
        $this.UserName = $userName
    }
}

class RelativityArmArchiveJobDetails
{
    [ValidateNotNull()]
    [DateTime] $CreatedOn
    [ValidateNotNull()]
    [DateTime] $ModifiedTime
    [ValidateNotNullOrEmpty()]
    [String] $SubmittedBy
    [ValidateNotNullOrEmpty()]
    [String] $State
    [ValidateNotNullOrEmpty()]
    [String] $Priority
    [ValidateNotNull()]
    [RelativityArmArchiveJobActionHistory[]] $ActionsHistory

    RelativityArmArchiveJobDetails([DateTime] $createdOn, [DateTime] $modifiedOn, [String] $submittedBy, [String] $state, [String] $priority, [RelativityArmArchiveJobActionHistory[]] $actionsHistory)
    {
        $this.CreatedOn = $createdOn
        $this.ModifiedTime = $modifiedOn
        $this.SubmittedBy = $submittedBy
        $this.State = $state
        $this.Priority = $priority
        $this.ActionsHistory = $actionsHistory
    }
}

class RelativityArmArchiveJobRequestBase
{
    [ValidateNotNull()]
    [Int32] $WorkspaceID
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

    RelativityArmArchiveJobRequestBase([Int32] $workspaceID, [String] $jobPriority, [String] $archiveDirectory, [String] $scheduledStartTime, [RelativityArmArchiveJobMigratorOptions] $migratorOptions, [RelativityArmArchiveJobFileOptions] $fileOptions, [RelativityArmArchiveJobProcessingOptions] $processingOptions, [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions, [RelativityArmArchiveJobNotificationOptions] $notificationOptions, [Boolean] $uiJobActionsLocked, [Boolean] $useDefaultArchiveDirectory)
    {
        $this.WorkspaceID = $workspaceID
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
            WorkspaceID = $this.WorkspaceID
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

class RelativityArmArchiveJobCreateRequest : RelativityArmArchiveJobRequestBase
{
    RelativityArmArchiveJobCreateRequest([Int32] $workspaceID, [String] $jobPriority, [String] $archiveDirectory, [String] $scheduledStartTime, [RelativityArmArchiveJobMigratorOptions] $migratorOptions, [RelativityArmArchiveJobFileOptions] $fileOptions, [RelativityArmArchiveJobProcessingOptions] $processingOptions, [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions, [RelativityArmArchiveJobNotificationOptions] $notificationOptions, [Boolean] $uiJobActionsLocked, [Boolean] $useDefaultArchiveDirectory) : base([Int32] $workspaceID, [String] $jobPriority, [String] $archiveDirectory, [String] $scheduledStartTime, [RelativityArmArchiveJobMigratorOptions] $migratorOptions, [RelativityArmArchiveJobFileOptions] $fileOptions, [RelativityArmArchiveJobProcessingOptions] $processingOptions, [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions, [RelativityArmArchiveJobNotificationOptions] $notificationOptions, [Boolean] $uiJobActionsLocked, [Boolean] $useDefaultArchiveDirectory)
    {

    }
}

class RelativityArmArchiveJobCreateResponse
{
    [ValidateNotNull()]
    [Int32] $JobID

    RelativityArmArchiveJobCreateResponse([Int32] $jobID)
    {
        $this.JobID = $jobID
    }
}

class RelativityArmArchiveJobReadResponse
{
    [ValidateNotNull()]
    [Int32] $JobID
    [ValidateNotNullOrEmpty()]
    [String] $JobName
    [ValidateNotNull()]
    [Int32] $JobExecutionID
    [ValidateNotNull()]
    [Guid] $JobExecutionGuid
    [ValidateNotNullOrEmpty()]
    [String] $ArchivePath
    [ValidateNotNull()]
    [Int32] $WorkspaceID
    [ValidateNotNull()]
    [String] $ScheduledStartTime
    [ValidateNotNull()]
    [RelativityArmArchiveJobDetails] $JobDetails
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

    RelativityArmArchiveJobReadResponse([Int32] $jobID, [String] $jobName, [Int32] $jobExecutionID, [Guid] $jobExecutionGuid, [String] $archivePath, [Int32] $workspaceID, [String] $scheduledStartTime, [RelativityArmArchiveJobDetails] $jobDetails, [RelativityArmArchiveJobMigratorOptions] $migratorOptions, [RelativityArmArchiveJobFileOptions] $fileOptions, [RelativityArmArchiveJobProcessingOptions] $processingOptions, [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions, [RelativityArmArchiveJobNotificationOptions] $notificationOptions, [Boolean] $uiJobActionsLocked)
    {
        $this.JobID = $jobID
        $this.JobName = $jobName
        $this.JobExecutionID = $jobExecutionID
        $this.JobExecutionGuid = $jobExecutionGuid
        $this.ArchivePath = $archivePath
        $this.WorkspaceID = $workspaceID
        $this.ScheduledStartTime = $scheduledStartTime
        $this.JobDetails = $jobDetails
        $this.MigratorOptions = $migratorOptions
        $this.FileOptions = $fileOptions
        $this.ProcessingOptions = $processingOptions
        $this.ExtendedWorkspaceDataOptions = $extendedWorkspaceDataOptions
        $this.NotificationOptions = $notificationOptions
        $this.UiJobActionsLocked = $uiJobActionsLocked
    }
}

class RelativityArmArchiveJobUpdateRequest : RelativityArmArchiveJobRequestBase
{
    RelativityArmArchiveJobUpdateRequest([Int32] $workspaceID, [String] $jobPriority, [String] $archiveDirectory, [String] $scheduledStartTime, [RelativityArmArchiveJobMigratorOptions] $migratorOptions, [RelativityArmArchiveJobFileOptions] $fileOptions, [RelativityArmArchiveJobProcessingOptions] $processingOptions, [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions, [RelativityArmArchiveJobNotificationOptions] $notificationOptions, [Boolean] $uiJobActionsLocked, [Boolean] $useDefaultArchiveDirectory) : base([Int32] $workspaceID, [String] $jobPriority, [String] $archiveDirectory, [String] $scheduledStartTime, [RelativityArmArchiveJobMigratorOptions] $migratorOptions, [RelativityArmArchiveJobFileOptions] $fileOptions, [RelativityArmArchiveJobProcessingOptions] $processingOptions, [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions, [RelativityArmArchiveJobNotificationOptions] $notificationOptions, [Boolean] $uiJobActionsLocked, [Boolean] $useDefaultArchiveDirectory)
    {
        
    }
}