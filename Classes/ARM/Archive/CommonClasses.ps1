class RelativityArmArchiveJobMigratorOptions
{
    [Boolean] $IncludeDatabaseBackup
    [Boolean] $IncludeDtSearch
    [Boolean] $IncludeConceptualAnalytics
    [Boolean] $IncludeStructuredAnalytics
    [Boolean] $IncludeDataGrid

    RelativityArmArchiveJobMigratorOptions(
        [Boolean] $includeDatabaseBackup,
        [Boolean] $includeDtSearch,
        [Boolean] $includeConceptualAnalytics,
        [Boolean] $includeStructuredAnalytics,
        [Boolean] $includeDataGrid
    )
    {
        $this.IncludeDatabaseBackup = $includeDatabaseBackup
        $this.IncludeDtSearch = $includeDtSearch
        $this.IncludeConceptualAnalytics = $includeConceptualAnalytics
        $this.IncludeStructuredAnalytics = $includeStructuredAnalytics
        $this.IncludeDataGrid = $includeDataGrid
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("IncludeDatabaseBackup", $this.IncludeDatabaseBackup)
        $ReturnValue.Add("IncludeDtSearch", $this.IncludeDtSearch)
        $ReturnValue.Add("IncludeConceptualAnalytics", $this.IncludeConceptualAnalytics)
        $ReturnValue.Add("IncludeStructuredAnalytics", $this.IncludeStructuredAnalytics)
        $ReturnValue.Add("IncludeDataGrid", $this.IncludeDataGrid)

        return $ReturnValue
    }
}

class RelativityArmArchiveJobFileOptions
{
    [Boolean] $IncludeRepositoryFiles
    [Boolean] $IncludeLinkedFiles
    [String] $MissingFileBehavior

    RelativityArmArchiveJobFileOptions(
        [Boolean] $includeRepositoryFiles,
        [Boolean] $includeLinkedFiles,
        [String] $missingFileBehavior
    )
    {
        $this.IncludeRepositoryFiles = $includeRepositoryFiles
        $this.IncludeLinkedFiles = $includeLinkedFiles
        $this.MissingFileBehavior = $missingFileBehavior
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("IncludeRepositoryFiles", $this.IncludeRepositoryFiles)
        $ReturnValue.Add("IncludeLinkedFiles", $this.IncludeLinkedFiles)
        $ReturnValue.Add("MissingFileBehavior", $this.MissingFileBehavior)

        return $ReturnValue
    }
}

class RelativityArmArchiveJobProcessingOptions
{
    [Boolean] $IncludeProcessing
    [Boolean] $IncludeProcessingFiles
    [String] $ProcessingMissingFileBehavior

    RelativityArmArchiveJobProcessingOptions(
        [Boolean] $includeProcessing,
        [Boolean] $includeProcessingFiles,
        [String] $processingMissingFileBehavior
    )
    {
        $this.IncludeProcessing = $includeProcessing
        $this.IncludeProcessingFiles = $includeProcessingFiles
        $this.ProcessingMissingFileBehavior = $processingMissingFileBehavior
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("IncludeProcessing", $this.IncludeProcessing)
        $ReturnValue.Add("IncludeProcessingFiles", $this.IncludeProcessingFiles)
        $ReturnValue.Add("ProcessingMissingFileBehavior", $this.ProcessingMissingFileBehavior)

        return $ReturnValue
    }
}

class RelativityArmArchiveJobExtendedWorkspaceDataOptions
{
    [Boolean] $IncludeExtendedWorkspaceData
    [String] $ApplicationErrorExportBehavior

    RelativityArmArchiveJobExtendedWorkspaceDataOptions(
        [Boolean] $includeExtendedWorkspaceData,
        [String] $applicationErrorExportBehavior
    )
    {
        $this.IncludeExtendedWorkspaceData = $includeExtendedWorkspaceData
        $this.ApplicationErrorExportBehavior = $applicationErrorExportBehavior
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("IncludeExtendedWorkspaceData", $this.IncludeExtendedWorkspaceData)
        $ReturnValue.Add("ApplicationErrorExportBehavior", $this.ApplicationErrorExportBehavior)

        return $ReturnValue
    }
}

class RelativityArmArchiveJobBase
{
    [Int32] $WorkspaceID
    [String] $ScheduledStartTime
    [RelativityArmArchiveJobMigratorOptions] $MigratorOptions
    [RelativityArmArchiveJobFileOptions] $FileOptions
    [RelativityArmArchiveJobProcessingOptions] $ProcessingOptions
    [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $ExtendedWorkspaceDataOptions
    [RelativityArmJobNotificationOptions] $NotificationOptions
    [Boolean] $UiJobActionsLocked

    RelativityArmArchiveJobBase(
        [Int32] $workspaceID,
        [String] $scheduledStartTime,
        [RelativityArmArchiveJobMigratorOptions] $migratorOptions,
        [RelativityArmArchiveJobFileOptions] $fileOptions,
        [RelativityArmArchiveJobProcessingOptions] $processingOptions,
        [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions,
        [RelativityArmJobNotificationOptions] $notificationOptions,
        [Boolean] $uiJobActionsLocked
    )
    {
        $this.WorkspaceID = $workspaceID
        $this.ScheduledStartTime = $scheduledStartTime
        $this.MigratorOptions = $migratorOptions
        $this.FileOptions = $fileOptions
        $this.ProcessingOptions = $processingOptions
        $this.ExtendedWorkspaceDataOptions = $extendedWorkspaceDataOptions
        $this.NotificationOptions = $notificationOptions
        $this.UiJobActionsLocked = $uiJobActionsLocked
    }

    RelativityArmArchiveJobBase([PSCustomObject] $apiResponse)
    {
        $this.WorkspaceID = $apiResponse.WorkspaceID
        $this.ScheduledStartTime = $apiResponse.ScheduledStartTime

        $this.MigratorOptions = [RelativityArmArchiveJobMigratorOptions]::New(
            $apiResponse.MigratorOptions.IncludeDatabaseBackup,
            $apiResponse.MigratorOptions.IncludeDtSearch,
            $apiResponse.MigratorOptions.IncludeConceptualAnalytics,
            $apiResponse.MigratorOptions.IncludeStructuredAnalytics,
            $apiResponse.MigratorOptions.IncludeDataGrid
        )

        $this.FileOptions = [RelativityArmArchiveJobFileOptions]::New(
            $apiResponse.FileOptions.IncludeRepositoryFiles,
            $apiResponse.FileOptions.IncludeLinkedFiles,
            $apiResponse.FileOptions.MissingFileBehavior
        )

        $this.ProcessingOptions = [RelativityArmArchiveJobProcessingOptions]::New(
            $apiResponse.ProcessingOptions.IncludeProcessing,
            $apiResponse.ProcessingOptions.IncludeProcessingFiles,
            $apiResponse.ProcessingOptions.ProcessingMissingFileBehavior
        )

        $this.ExtendedWorkspaceDataOptions = [RelativityArmArchiveJobExtendedWorkspaceDataOptions]::New(
            $apiResponse.ExtendedWorkspaceDataOptions.IncludeExtendedWorkspaceData,
            $apiResponse.ExtendedWorkspaceDataOptions.ApplicationErrorExportBehavior
        )

        $this.NotificationOptions = [RelativityArmJobNotificationOptions]::New(
            $apiResponse.NotificationOptions.NotifyJobCreator,
            $apiResponse.NotificationOptions.NotifyJobExecutor
        )

        $this.UiJobActionsLocked = $apiResponse.uiJobActionsLocked
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("WorkspaceID", $this.WorkspaceID)
        $ReturnValue.Add("ScheduledStartTime", $this.ScheduledStartTime)
        $ReturnValue.Add("MigratorOptions", $this.MigratorOptions.ToHashTable())
        $ReturnValue.Add("FileOptions", $this.FileOptions.ToHashTable())
        $ReturnValue.Add("ProcessingOptions", $this.ProcessingOptions.ToHashTable())
        $ReturnValue.Add("ExtendedWorkspaceDataOptions", $this.ExtendedWorkspaceDataOptions.ToHashTable())
        $ReturnValue.Add("NotificationOptions", $this.NotificationOptions.ToHashTable())
        $ReturnValue.Add("UIJobActionsLocked", $this.UiJobActionsLocked)

        return $ReturnValue
    }
}