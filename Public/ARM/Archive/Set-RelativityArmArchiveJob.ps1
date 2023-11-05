<#
.SYNOPSIS
Function to update an existing Relativity ARM archive Job using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, calls Relativity's REST API, and processes the response to update a an existing ARM archive job.

.PARAMETER ArtifactID
The ArtifactId of the workspace to archive for the archive job.
This workspace must not be in the process of upgrading or currently in use by another ARM job.

.PARAMETER JobPriority
Priority of execution for the job. Possible options include "Low", "Medium", and "High".
Default is "Medium".

.PARAMETER ArchiveDirectory
File path of the configured archive directory to save the archive to.
When this is set UseDefaultArchiveDirectory has to be false.

.PARAMETER ScheduledStartTime
Scheduled time when the job will be run.

.PARAMETER IncludeDatabaseBackup
Indicates if the workspace database backup is included in the archive.

.PARAMETER IncludeDtSearch
Indicates whether dtSearch indices will be included in the archive directory.

.PARAMETER IncludeConceptualAnalytics
Indicates whether Conceptual Analytics indices will be included in the archive directory.

.PARAMETER IncludeStructuredAnalytics
Indicates whether Structured Analytics sets will be included in the archive directory.

.PARAMETER IncludeDataGrid
Indicates whether Data Grid application data will be present in the archive directory.

.PARAMETER IncludeRepositoryFiles
 Indicates whether all files included in the workspace repository, including files from file fields, will be archived in the archive directory.

.PARAMETER IncludeLinkedFiles
Indicates whether all linked files that do not exist in the workspace file repository will be archived in the archive directory.

.PARAMETER MissingFileBehavior
Indicates whether to skip ("SkipFile") or stop ("StopJob") when missing files are detected during the archiving process.
If there is potential for any files to not be found while the job is running, skipping them will result in compiling a downloadable list of the files that were missing and allow the job to complete without error.
Setting this to stop will immediately stop on the first missing file and cannot resume until the file is placed in the expected location.
Default is "SkipFile".

.PARAMETER IncludeProcessing
Indicates whether Processing application data will be present in the archive directory.

.PARAMETER IncludeProcessingFiles
Indicates whether all the files and containers that have been discovered by Processing will be archived and placed in the Invariant directory.

.PARAMETER ProcessingMissingFileBehavior
Indicates whether to skip ("SkipFile") or stop ("StopJob") when missing Processing files are detected during the archiving process.
If there is potential for any files to not be found while the job is running, skipping them will result in compiling a downloadable list of the files that were missing and allow the job to complete without error.
Setting this to stop will immediately stop on the first missing file and cannot resume until the file is placed in the expected location.
Default is "SkipFile".

.PARAMETER IncludeExtendedWorkspaceData
 Indicates whether extended workspace information is included in the archive.
 This includes installed applications, linked relativity scripts, and non-application event handlers.

.PARAMETER ApplicationErrorExportBehavior
Indicates whether to skip applications that errored during export ("SkipApplication") or to stop ("StopJob").
Default is "SkipApplication".

.PARAMETER NotifyJobCreator
Indicates if email notifications will be sent to the job creator.

.PARAMETER NotifyJobExecutor
Indicates if email notifications will be sent to the job executor.

.PARAMETER UiJobActionsLocked
Indicates if job actions normally available on UI should be visible for the user.
This behavior can be override by adding boolean instance setting OverrideUiJobActionsLock.

.PARAMETER UseDefaultArchiveDirectory
When this option is set to true leave ArchiveDirectory empty.
ARM will select the fist valid one from configuration.

.EXAMPLE
Set-RelativityArmArchiveJob -JobID 54 -WorkspaceId 1234567 -IncludeDatabaseBackup -IncludeRepositoryFiles -UseDefaultArchiveDirectory

This example updates the existing archive job with JobID 54 to a workspace with the ArtifactId 1234567 using the default archive directory and includes a database backup and repository files.

.EXAMPLE
Set-RelativityArmArchiveJob -JobID 54 -WorkspaceId 1234567 -ArchiveDirectory "\\server\path" -IncludeDatabaseBackup

This example updates the existing archive job with JobID 54 to a workspace with the ArtifactId 1234567 in the specified directory and includes a database backup.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Set-RelativityArmArchiveJob
{
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $JobID,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ArtifactID,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet("Low", "Medium", "High")]
        [String] $JobPriority = "Medium",
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $ArchiveDirectory,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateScript({
            $date = "1970-01-01"
            [DateTime]::TryParse($_, [ref]$date)
            if($_ -eq "") { return $true }
            elseif ($date -eq [DateTime]::MinValue) { throw "Invalid DateTime for ScheduledStartTime: $($_)."}
            $true
        })]
        [String] $ScheduledStartTime,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $IncludeDatabaseBackup,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $IncludeDtSearch,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $IncludeConceptualAnalytics,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $IncludeStructuredAnalytics,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $IncludeDataGrid,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $IncludeRepositoryFiles,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $IncludeLinkedFiles,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet("SkipFile", "StopJob")]
        [String] $MissingFileBehavior = "SkipFile",
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $IncludeProcessing,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $IncludeProcessingFiles,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet("SkipFile", "StopJob")]
        [String] $ProcessingMissingFileBehavior = "SkipFile",
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $IncludeExtendedWorkspaceData,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet("SkipApplication", "StopJob")]
        [String] $ApplicationErrorExportBehavior = "SkipApplication",
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $NotifyJobCreator,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $NotifyJobExecutor,
        [Parameter(ParameterSetName = "ProvidedArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $UiJobActionsLocked,
        [Parameter(ParameterSetName = "DefaultArchiveDirectory", Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $UseDefaultArchiveDirectory
    )

    Begin
    {
        Write-Verbose "Starting Set-RelativityArmArchiveJob"
    }
    Process
    {
        try
        {
            $MigratorOptions = [RelativityArmArchiveJobMigratorOptions]::New(
                $IncludeDatabaseBackup,
                $IncludeDtSearch,
                $IncludeConceptualAnalytics,
                $IncludeStructuredAnalytics,
                $IncludeDataGrid
            )

            $FileOptions = [RelativityArmArchiveJobFileOptions]::New(
                $IncludeRepositoryFiles,
                $IncludeLinkedFiles,
                $MissingFileBehavior
            )
            
            $ProcessingOptions = [RelativityArmArchiveJobProcessingOptions]::New(
                $IncludeProcessing,
                $IncludeProcessingFiles,
                $ProcessingMissingFileBehavior
            )

            $ExtendedWorkspaceDataOptions = [RelativityArmArchiveJobExtendedWorkspaceDataOptions]::New(
                $IncludeExtendedWorkspaceData,
                $ApplicationErrorExportBehavior
            )

            $NotificationOptions = [RelativityArmJobNotificationOptions]::New(
                $NotifyJobCreator,
                $NotifyJobExecutor
            )

            $JobOptions = [RelativityArmArchiveJobOptions]::New(
                $ArtifactID,
                $JobPriority,
                $ArchiveDirectory,
                $ScheduledStartTime,
                $MigratorOptions,
                $FileOptions,
                $ProcessingOptions,
                $ExtendedWorkspaceDataOptions,
                $NotificationOptions,
                $UiJobActionsLocked,
                $UseDefaultArchiveDirectory
            )

            $Request = [RelativityArmArchiveJobCreateOrUpdateRequest]::New(
                $JobOptions
            )

            $RequestBody = $Request.ToHashTable()

            [String[]] $Resources = @("archive-jobs", $JobID.ToString())

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke PUT method at Relativity API endpoint '$($ApiEndPoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking PUT method at Relativity API endpoint: $($ApiEndpoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Put" -RequestBody $RequestBody

                $Response = [RelativityApiSuccessResponse]::New($ApiResponse.Success)
                Write-Verbose "Successfully updated ARM archive job with ID: $($JobID)"
            }

            return $Response
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            Write-Verbose "ArtifactID: $($ArtifactID)"
            Write-Verbose "JobPriority: $($JobPriority)"
            Write-Verbose "ArchiveDirectory: $($ArchiveDirectory)"
            Write-Verbose "ScheduledStartTime: $($ScheduledStartTime)"
            Write-Verbose "IncludeDatabaseBackup: $($IncludeDatabaseBackup)"
            Write-Verbose "IncludeDtSearch: $($IncludeDtSearch)"
            Write-Verbose "IncludeConceptualAnalytics: $($IncludeConceptualAnalytics)"
            Write-Verbose "IncludeStructuredAnalytics: $($IncludeStructuredAnalytics)"
            Write-Verbose "IncludeDataGrid: $($IncludeDataGrid)"
            Write-Verbose "IncludeRepositoryFiles: $($IncludeRepositoryFiles)"
            Write-Verbose "IncludeLinkedFiles: $($IncludeLinkedFiles)"
            Write-Verbose "MissingFileBehavior: $($MissingFileBehavior)"
            Write-Verbose "IncludeProcessing: $($IncludeProcessing)"
            Write-Verbose "IncludeProcessingFIles: $($IncludeProcessingFiles)"
            Write-Verbose "ProcessingMissingFileBehavior: $($ProcessingMissingFileBehavior)"
            Write-Verbose "IncludeExtendedWorkspaceData: $($IncludeExtendedWorkspaceData)"
            Write-Verbose "ApplicationErrorExportBehavior: $($ApplicationErrorExportBehavior)"
            Write-Verbose "NotifyJobCreator: $($NotifyJobCreator)"
            Write-Verbose "NotifyJobExecutor: $($NotifyJobExecutor)"
            Write-Verbose "UiJobActionsLocked: $($UiJobActionsLocked)"
            Write-Verbose "UseDefaultArchiveDirectory: $($UseDefaultArchiveDirectory)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed Set-RelativityArmArchiveJob"
    }
}