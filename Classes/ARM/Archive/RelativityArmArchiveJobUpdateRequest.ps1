<#
.SYNOPSIS
This class represents a request to update an ARM Archive Job in Relativity.

.DESCRIPTION
The RelativityArmArchiveJobUpdateRequest class encapsulates all the parameters required to create an ARM Archive Job request. 
This includes details about the workspace to be archived, job execution priority, archive directory configuration, 
scheduled start time for the job, various options for what data to include in the archive, 
and notification settings for job creators and executors.

.PARAMETER WorkspaceID
Specifies the artifact ID of the workspace to be archived. 
The specified workspace must not be in the process of upgrading or currently in use by another ARM job.

.PARAMETER JobPriority
Specifies the priority of execution for the job. Possible values include "Low", "Medium", and "High".

.PARAMETER ArchiveDirectory
Specifies the file path of the configured archive directory where the archive will be saved. 
When this parameter is set, UseDefaultArchiveDirectory must be set to false.

.PARAMETER ScheduledStartTime
Specifies the scheduled time when the job will be run.

.PARAMETER MigratorOptions
Specifies various options for what data to include in the archive related to database, dtSearch indices, 
Conceptual Analytics indices, Structured Analytics sets, and Data Grid application data.

.PARAMETER FileOptions
Specifies various file related options for what data to include in the archive, 
and behavior when missing files are detected during the archiving process.

.PARAMETER ProcessingOptions
Specifies various processing related options for what data to include in the archive, 
and behavior when missing Processing files are detected during the archiving process.

.PARAMETER ExtendedWorkspaceDataOptions
Specifies whether extended workspace information is included in the archive. 
This includes installed applications, linked relativity scripts, and non-application event handlers.

.PARAMETER NotificationOptions
Specifies the notification options for job creators and executors, including email notifications.

.PARAMETER UiJobActionsLocked
Specifies if job actions normally available on UI should be visible for the user. 
This behavior can be override by adding boolean instance setting OverrideUiJobActionsLock.

.PARAMETER UseDefaultArchiveDirectory
Specifies whether to use the default archive directory. 
When this option is set to true, leave ArchiveDirectory parameter empty. 
ARM will select the first valid one from configuration.

.EXAMPLE
$archiveJobRequest = [RelativityArmArchiveJobUpdateRequest]::new(
    12345,
    "High",
    "\\archive\directory\path",
    "2023-12-25T10:00:00",
    $migratorOptions,
    $fileOptions,
    $processingOptions,
    $extendedWorkspaceDataOptions,
    $notificationOptions,
    $false,
    $false
)

.NOTES
Make sure to provide valid values for all the parameters to ensure successful job update.
#>
class RelativityArmArchiveJobUpdateRequest : RelativityArmArchiveJobRequestBase
{
    RelativityArmArchiveJobUpdateRequest([Int32] $workspaceID, [String] $jobPriority, [String] $archiveDirectory, [String] $scheduledStartTime, [RelativityArmArchiveJobMigratorOptions] $migratorOptions, [RelativityArmArchiveJobFileOptions] $fileOptions, [RelativityArmArchiveJobProcessingOptions] $processingOptions, [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions, [RelativityArmArchiveJobNotificationOptions] $notificationOptions, [Boolean] $uiJobActionsLocked, [Boolean] $useDefaultArchiveDirectory) : base([Int32] $workspaceID, [String] $jobPriority, [String] $archiveDirectory, [String] $scheduledStartTime, [RelativityArmArchiveJobMigratorOptions] $migratorOptions, [RelativityArmArchiveJobFileOptions] $fileOptions, [RelativityArmArchiveJobProcessingOptions] $processingOptions, [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions, [RelativityArmArchiveJobNotificationOptions] $notificationOptions, [Boolean] $uiJobActionsLocked, [Boolean] $useDefaultArchiveDirectory)
    {
        
    }
}