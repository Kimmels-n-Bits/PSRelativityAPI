<#
.SYNOPSIS
This class represents the response received upon issuing a Get request for an ARM Archive Job in Relativity.

.DESCRIPTION
The RelativityArmArchiveJobReadResponse class encapsulates all the details related to a specific ARM Archive Job. This includes identifiers, execution details, archive path, workspace details, scheduled start time, job detailed information, migrator, file, processing, extended workspace data, notification options, and UI job actions lock status.

.PARAMETER JobID
Specifies the ID of the created Archive job.

.PARAMETER JobName
Specifies the name of the Archive job created.

.PARAMETER JobExecutionID
Specifies the ID of the execution of the created Archive Job.

.PARAMETER JobExecutionGuid
Specifies the execution GUID of the created Archive Job.

.PARAMETER ArchivePath
Specifies the path to the ARM archive. It is created using the ArchiveDirectory field from a Create/Update request and the archive folder name.

.PARAMETER WorkspaceID
Specifies the artifact ID of the workspace archived by the job.

.PARAMETER ScheduledStartTime
Specifies the scheduled time when the job will be run.

.PARAMETER JobDetails
Specifies detailed information of the job including creation and modification time, submitted by, state, priority, and actions history.

.PARAMETER MigratorOptions
Specifies various options for what data to include in the archive related to database, dtSearch indices, Conceptual Analytics indices, Structured Analytics sets, and Data Grid application data.

.PARAMETER FileOptions
Specifies various file related options for what data to include in the archive, and behavior when missing files are detected during the archiving process.

.PARAMETER ProcessingOptions
Specifies various processing related options for what data to include in the archive, and behavior when missing Processing files are detected during the archiving process.

.PARAMETER ExtendedWorkspaceDataOptions
Specifies whether extended workspace information is included in the archive. This includes installed applications, linked relativity scripts, and non-application event handlers.

.PARAMETER NotificationOptions
Specifies the notification options for job creators and executors, including email notifications.

.PARAMETER UiJobActionsLocked
Specifies if job actions normally available on UI should be visible for the user.

.EXAMPLE
$response = [RelativityArmArchiveJobReadResponse]::new(
    12345,
    "ArchiveJob1",
    67890,
    [Guid]::NewGuid(),
    "\\archive\directory\path\ArchiveJob1",
    98765,
    "2023-12-25T10:00:00",
    $jobDetails,
    $migratorOptions,
    $fileOptions,
    $processingOptions,
    $extendedWorkspaceDataOptions,
    $notificationOptions,
    $false
)
Write-Host "The Archive Job name is: $($response.JobName)"

.NOTES
Ensure to have valid values for all the parameters to properly instantiate this class and access the ARM Archive Job details.
#>
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