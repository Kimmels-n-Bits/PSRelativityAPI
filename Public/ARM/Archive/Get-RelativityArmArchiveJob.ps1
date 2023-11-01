<#
.SYNOPSIS
Retrieves details of a Relativity ARM Archive Job.

.DESCRIPTION
The function sends a request to retrieve details of an ARM archive job in Relativity based on the provided JobID.
The response contains various details about the job, such as the job's name, execution ID, archive path, workspace it relates to, and other configuration options.
It's important to ensure that the provided JobID corresponds to an existing job in the system.

.PARAMETER JobID
The ID of the ARM archive job to retrieve. This is a mandatory parameter.

.EXAMPLE
Get-RelativityArmArchiveJob -JobID 3026

This example retrieves details of the archive job with the ID of 3026.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function. 
The function does not modify any data but only retrieves details of a specified job.
#>
function Get-RelativityArmArchiveJob
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [Int32] $JobID
    )

    Process
    {
        [RelativityApiEndpointResource[]] $RelativityApiEndpointResources = @()
        $RelativityApiEndpointResources += [RelativityApiEndpointResource]::New("archive-jobs", "$($JobID)")
        $RelativityApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $RelativityApiEndpointResources

        $RelativityApiResponse = Invoke-RelativityApiRequest -RelativityApiEndpoint $RelativityApiEndpoint -RelativityApiHttpMethod "Get"

        $RelativityArmArchiveJobActionsHistory = [RelativityArmArchiveJobActionHistory[]]@()

        $RelativityApiResponse.JobDetails.ActionsHistory | ForEach-Object {
            $RelativityArmArchiveJobActionsHistory += [RelativityArmArchiveJobActionHistory]::New($_.Date, $_.Type, $_.UserName)
        }

        $RelativityArmArchiveJobDetails = [RelativityArmArchiveJobDetails]::New($RelativityApiResponse.JobDetails.CreatedOn, $RelativityApiResponse.JobDetails.ModifiedTime, $RelativityApiResponse.JobDetails.SubmittedBy, $RelativityApiResponse.JobDetails.State, $RelativityApiResponse.JobDetails.Priority, $RelativityApiResponse)
        $RelativityArmArchiveJobMigratorOptions = [RelativityArmArchiveJobMigratorOptions]::New($RelativityApiResponse.MigratorOptions.IncludeDatabaseBackup, $RelativityApiResponse.MigratorOptions.IncludeDtSearch, $RelativityApiResponse.MigratorOptions.IncludeConceptualAnalytics, $RelativityApiResponse.MigratorOptions.IncludeStructuredAnalytics, $RelativityApiResponse.MigratorOptions.IncludeDataGrid)
        $RelativityArmArchiveJobFileOptions = [RelativityArmArchiveJobFileOptions]::New($RelativityApiResponse.FileOptions.IncludeRepositoryFiles, $RelativityApiResponse.FileOptions.IncludeLinkedFiles, $RelativityApiResponse.FileOptions.MissingFileBehavior)
        $RelativityArmArchiveJobProcessingOptions = [RelativityArmArchiveJobProcessingOptions]::New($RelativityApiResponse.FileOptions.IncludeProcessing, $RelativityApiResponse.FileOptions.IncludeProcessingFiles, $RelativityApiResponse.FileOptions.ProcessingMissingFileBehavior)
        $RelativityArmArchiveJobExtendedWorkspaceDataOptions = [RelativityArmArchiveJobExtendedWorkspaceDataOptions]::New($RelativityApiResponse.ExtendedWorkspaceDataOptions.IncludeExtendedWorkspaceData, $RelativityApiResponse.ExtendedWorkspaceDataOptions.ApplicationErrorExportBehavior)
        $RelativityArmArchiveJobNotificationOptions = [RelativityArmArchiveJobNotificationOptions]::New($RelativityApiResponse.NotificationOptions.NotifyJobCreator, $RelativityApiResponse.NotificationOptions.NotifyJobExecutor)

        return [RelativityArmArchiveJobReadResponse]::New($RelativityApiResponse.JobID, $RelativityApiResponse.JobName, $RelativityApiResponse.JobExecutionID, $RelativityApiResponse.JobExecutionGuid, $RelativityApiResponse.ArchivePath, $RelativityApiResponse.WorkspaceID, $RelativityApiResponse.ScheduledStartTime, $RelativityArmArchiveJobDetails, $RelativityArmArchiveJobMigratorOptions, $RelativityArmArchiveJobFileOptions, $RelativityArmArchiveJobProcessingOptions, $RelativityArmArchiveJobExtendedWorkspaceDataOptions, $RelativityArmArchiveJobNotificationOptions, $RelativityApiResponse.UiJobActionsLocked)
    }
}