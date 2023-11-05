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

<# Used by ARM Archive jobs#>
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

class RelativityArmArchiveJobOptions : RelativityArmArchiveJobBase
{
    [String] $ArchiveDirectory
    [String] $JobPriority
    [Boolean] $UseDefaultArchiveDirectory

    RelativityArmArchiveJobOptions(
        [Int32] $workspaceID,
        [String] $jobPriority,
        [String] $archiveDirectory,
        [String] $scheduledStartTime,
        [RelativityArmArchiveJobMigratorOptions] $migratorOptions,
        [RelativityArmArchiveJobFileOptions] $fileOptions,
        [RelativityArmArchiveJobProcessingOptions] $processingOptions,
        [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions,
        [RelativityArmJobNotificationOptions] $notificationOptions,
        [Boolean] $uiJobActionsLocked,
        [Boolean] $useDefaultArchiveDirectory
    ) : base(
        $workspaceID,
        $scheduledStartTime,
        $migratorOptions,
        $fileOptions,
        $processingOptions,
        $extendedWorkspaceDataOptions,
        $notificationOptions,
        $uiJobActionsLocked
    )
    {
        $this.JobPriority = $jobPriority
        $this.ArchiveDirectory = $archiveDirectory
        $this.UseDefaultArchiveDirectory = $useDefaultArchiveDirectory
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = ([RelativityArmArchiveJobBase] $this).ToHashTable()

        $ReturnValue.Add("ArchiveDirectory", $this.ArchiveDirectory)
        $ReturnValue.Add("JobPriority", $this.JobPriority)
        $ReturnValue.Add("UseDefaultArchiveDirectory", $this.UseDefaultArchiveDirectory)

        return $ReturnValue
    }
}

class RelativityArmArchiveJobReadResponse : RelativityArmArchiveJobBase
{
    [Int32] $JobID
    [String] $JobName
    [Int32] $JobExecutionID
    [Guid] $JobExecutionGuid
    [String] $ArchivePath
    [RelativityArmJobDetails] $JobDetails

    RelativityArmArchiveJobReadResponse([PSCustomObject] $apiResponse) : base($apiResponse)
    {
        $this.JobID = $apiResponse.jobID
        $this.JobName = $apiResponse.jobName
        $this.JobExecutionID = $apiResponse.jobExecutionID
        $this.JobExecutionGuid = $apiResponse.jobExecutionGuid
        $this.ArchivePath = $apiResponse.archivePath

        $ActionsHistoryValue = New-Object "System.Collections.Generic.List[RelativityArmJobActionHistory]"

        $apiResponse.JobDetails.ActionsHistory | ForEach-Object {
            $ActionsHistoryValue.Add([RelativityArmJobActionHistory]::New(
                $_.Date,
                $_.Type,
                $_.UserName))
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

class RelativityArmArchiveJobCreateOrUpdateRequest
{
    [RelativityArmArchiveJobOptions] $Request

    RelativityArmArchiveJobCreateOrUpdateRequest(
        [RelativityArmArchiveJobOptions] $request
    )
    {
        $this.Request = $request
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}
        
        $ReturnValue.Add("Request", $this.Request.ToHashTable())

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

class RelativityArmRestoreJobUserMappingOption
{
    [Boolean] $AutoMapUsers
    [RelativityArmRestoreJobUserMapping[]] $UserMappings

    RelativityArmRestoreJobUserMappingOption(
        [Boolean] $autoMapUsers,
        [RelativityArmRestoreJobUserMapping[]] $userMappings
    )
    {
        $this.AutoMapUsers = $autoMapUsers
        $this.UserMappings = $userMappings
    }

    RelativityArmRestoreJobUserMappingOption(
        [Boolean] $autoMapUsers,
        [Hashtable[]] $userMappings
    )
    {
        $this.AutoMapUsers = $autoMapUsers
        
        $UserMappingsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobUserMapping]"

        $userMappings | ForEach-Object {
            $UserMappingsValue.Add([RelativityArmRestoreJobUserMapping]::New(
                $_.ArchiveUserID,
                $_.InstanceUserID
            ))
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

class RelativityArmRestoreJobGroupMappingOption
{
    [Boolean] $AutoMapGroups
    [RelativityArmRestoreJobGroupMapping[]] $GroupMappings

    RelativityArmRestoreJobGroupMappingOption(
        [Boolean] $autoMapGroups,
        [RelativityArmRestoreJobGroupMapping[]] $groupMappings
    )
    {
        $this.AutoMapGroups = $autoMapGroups
        $this.GroupMappings = $groupMappings
    }

    RelativityArmRestoreJobGroupMappingOption(
        [Boolean] $autoMapGroups,
        [Hashtable[]] $groupMappings
    )
    {
        $this.AutoMapGroups = $autoMapGroups
        
        $GroupMappingsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobGroupMapping]"

        $groupMappings | ForEach-Object {
            $GroupMappingsValue.Add([RelativityArmRestoreJobGroupMapping]::New(
                $_.ArchiveGroupID,
                $_.InstanceGroupID
            ))
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

class RelativityArmRestoreJobOptions : RelativityArmRestoreJobBase
{
    [String] $JobPriority
    [RelativityArmRestoreJobUserMappingOption] $UserMapping
    [RelativityArmRestoreJobGroupMappingOption] $GroupMapping

    RelativityArmRestoreJobOptions(
        [String] $archivePath,
        [String] $jobPriority,
        [String] $scheduledStartTime,
        [String] $existingTargetDatabase,
        [RelativityArmRestoreJobDestinationOptions] $destinationOptions,
        [RelativityArmRestoreJobMigratorsDestinationOptions] $migratorsDestinationOptions,
        [RelativityArmRestoreJobAdvancedFileOptions] $advancedFileOptions,
        [RelativityArmRestoreJobUserMappingOption] $userMapping,
        [RelativityArmRestoreJobGroupMappingOption] $groupMapping,
        [RelativityArmRestoreJobApplication[]] $applications,
        [RelativityArmJobNotificationOptions] $notificationOptions,
        [Boolean] $uiJobActionsLocked
    ): base(
        $archivePath,
        $scheduledStartTime,
        $existingTargetDatabase,
        $destinationOptions,
        $migratorsDestinationOptions,
        $advancedFileOptions,
        $applications,
        $notificationOptions,
        $uiJobActionsLocked
    )
    {
        $this.JobPriority = $jobPriority
        $this.UserMapping = $userMapping
        $this.GroupMapping = $groupMapping
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = ([RelativityArmRestoreJobBase] $this).ToHashTable()

        $ReturnValue.Add("JobPriority", $this.JobPriority)
        $ReturnValue.Add("UserMapping", $this.UserMapping)
        $ReturnValue.Add("GroupMapping", $this.GroupMapping)

        return $ReturnValue
    }
}

class RelativityArmRestoreJobReadResponse : RelativityArmRestoreJobBase
{
    [Int32] $JobID
    [String] $JobName
    [Int32] $JobExecutionID
    [Guid] $JobExecutionGuid
    [String] $SourceWorkspace
    [Int32] $DestinationWorkspaceID
    [RelativityArmJobDetails] $JobDetails
    [RelativityArmRestoreJobUserMapping[]] $UserMappings
    [RelativityArmRestoreJobGroupMapping[]] $GroupMappings

    RelativityArmRestoreJobReadResponse([PSCustomObject] $apiResponse) : base($apiResponse)
    {
        $this.JobID = $apiResponse.JobID
        $this.JobName = $apiResponse.JobName
        $this.JobExecutionID = $apiResponse.JobExecutionID
        $this.JobExecutionGuid = $apiResponse.JobExecutionGuid
        $this.SourceWorkspace = $apiResponse.SourceWorkspace
        $this.DestinationWorkspaceID = $apiResponse.DestinationWorkspaceID

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

        $UserMappingsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobUserMapping]"

        $apiResponse.UserMappings | ForEach-Object {
            $UserMappingsValue.Add([RelativityArmRestoreJobUserMapping]::New(
                $_.ArchiveUserID,
                $_.InstanceUserID
            ))
        }

        $this.UserMappings = $UserMappingsValue.ToArray()

        $GroupMappingsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobGroupMapping]"

        $apiResponse.GroupMappings | ForEach-Object {
            $GroupMappingsValue.Add([RelativityArmRestoreJobGroupMapping]::New(
                $_.ArchiveGroupID,
                $_.InstanceGroupID
            ))
        }

        $this.GroupMappings = $GroupMappingsValue.ToArray()
    }
}

class RelativityArmRestoreJobCreateOrUpdateRequest
{
    [RelativityArmRestoreJobOptions] $Request

    RelativityArmRestoreJobCreateOrUpdateRequest(
        [RelativityArmRestoreJobOptions] $request
    )
    {
        $this.Request = $request
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}
        
        $ReturnValue.Add("Request", $this.Request.ToHashTable())

        return $ReturnValue
    }
}