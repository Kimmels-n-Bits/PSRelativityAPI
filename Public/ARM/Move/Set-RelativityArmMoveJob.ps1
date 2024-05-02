<#
.SYNOPSIS
Function to create a update an existing Relativity ARM move job using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, calls Relativity's REST API, and processes the response to update an existing ARM move job.

.PARAMETER JobID
The Job ID of the ARM move job to be updated. This is a mandatory parameter.

.PARAMETER ArtifactID
The ArtifactId of the workspace to move. This is a mandatory parameter.
This workspace must not be in the process of upgrading or currently in use by another ARM job.

.PARAMETER JobPriority
Priority of execution for the job. Possible options include "Low", "Medium", and "High". Default is "Medium".

.PARAMETER ScheduledStartTime
Scheduled time when the job will be run.

.PARAMETER LinkToExistingDocuments
Indicates whether repository files should be moved to new location or stay in their current one.

.PARAMETER MissingFileBehavior
Indicates whether to skip ("SkipFile") or stop ("StopJob") when missing files are detected during the archiving process.
If there is potential for any files to not be found while the job is running, skipping them will result in compiling a downloadable list of the files that were missing and allow the job to complete without error.
Setting this to stop will immediately stop on the first missing file and cannot resume until the file is placed in the expected location.
Default is "SkipFile".

.PARAMETER LinkedFileBehavior
Indicates whether linked files should be moved/copied to new location or stay in their current one.
Possible options include "LeaveInPlace", "CopyToRepository", and "MoveToRepository" Default is "CopyToRepository"

.PARAMETER IncludeDatabaseBackup
Indicates whether the workspace database is backed up and used for the new workspace. Default is true.

.PARAMETER CustomDatabasePath
The path to a custom database to apply to the new workspace. Required if IncludeDatabaseBackup is false.

.PARAMETER DatabaseServerID
ArtifactId of the target database server to restore the workspace to.

.PARAMETER ResourcePoolID
ArtifactId of the target resource pool to restore the workspace to.

.PARAMETER CacheLocationID
ArtifactId of the target cache location to restore the workspace to.

.PARAMETER FileRepositoryID
ArtifactId of the target file repository to restore the workspace to.

.PARAMETER NotifyJobCreator
Indicates if email notifications will be sent to the job creator.

.PARAMETER NotifyJobExecutor
Indicates if email notifications will be sent to the job executor.

.PARAMETER UiJobActionsLocked
Indicates if job actions normally available on UI should be visible for the user.
This behavior can be override by adding boolean instance setting OverrideUiJobActionsLock.

.EXAMPLE
Set-RelativityArmMoveJob -JobID 500 -ArtifactID 1234567  -DatabaseServerID 2345671 -ResourcePoolID 3456712 -CacheLocationID 4567123 -FileRepositoryID 5671234

This example updates an existing move job with the specified destination options.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Set-RelativityArmMoveJob
{
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $JobID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [String] $ArtifactID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet("Low", "Medium", "High")]
        [String] $JobPriority = "Medium",
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateScript({
                $date = "1970-01-01"
                [DateTime]::TryParse($_, [ref]$date)
                if ($_ -eq "") { return $true }
                elseif ($date -eq [DateTime]::MinValue) { throw "Invalid DateTime for ScheduledStartTime: $($_)." }
                $true
            })]
        [String] $ScheduledStartTime,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $LinkToExistingDocuments,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet("SkipFile", "StopJob")]
        [String] $MissingFileBehavior = "SkipFile",
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet("LeaveInPlace", "CopyToRepository", "MoveToRepository")]
        [String] $LinkedFileBehavior = "CopyToRepository",
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $IncludeDatabaseBackup = $true,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $CustomDatabasePath,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $DatabaseServerID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ResourcePoolID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $CacheLocationID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $FileRepositoryID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $NotifyJobCreator,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $NotifyJobExecutor,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $UiJobActionsLocked
    )

    Begin
    {
        Write-Verbose "Starting Set-RelativityArmMoveJob"
    }
    Process
    {
        try
        {
            $Params = @{
                SourceWorkspaceID = $ArtifactID
                JobPriority = $JobPriority
                ScheduledStartTime = $ScheduledStartTime
                LinkToExistingDocuments = $LinkToExistingDocuments
                MissingFileBehavior = $MissingFileBehavior
                LinkedFileBehavior = $LinkedFileBehavior
                IncludeDatabaseBackup = $IncludeDatabaseBackup
                CustomDatabasePath = $CustomDatabasePath
                DatabaseServerID = $DatabaseServerID
                ResourcePoolID = $ResourcePoolID
                CacheLocationID = $CacheLocationID
                FileRepositoryID = $FileRepositoryID
                NotifyJobCreator = $NotifyJobCreator
                NotifyJobExecutor = $NotifyJobExecutor
                UiJobActionsLocked = $UiJobActionsLocked
            }

            $Request = Get-RelativityArmMoveJobCreateOrUpdateRequest @Params

            $RequestBody = $Request.ToHashTable()

            [String[]]$Resources = @("move-jobs", $JobID.ToString())

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke PUT method at Relativity API endpoint '$($ApiEndPoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking PUT method at Relativity API endpoint: $($ApiEndPoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Put" -RequestBody $RequestBody

                $Response = [RelativityApiSuccessResponse]::New($ApiResponse.Success)
                Write-Verbose "Successfully updated ARM move job with ID: $($JobID)"
            }

            return $Response
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "Logging parameter values:"

            (Get-Command -Name $PSCmdlet.MyInvocation.InvocationName).Parameters | ForEach-Object {
                $_.Values | ForEach-Object {
                    $Parameter = Get-Variable -Name $_.Name -ErrorAction SilentlyContinue

                    if ($null -ne $Parameter)
                    {
                        Write-Verbose "$($Parameter.Name): $($Parameter.Value)"
                    }
                }
            }

            Write-Verbose "API Endpoint: $($ApiEndpoint)"

            throw
        }
    }
    End
    {
        Write-Verbose "Completed Set-RelativityArmMoveJob"
    }
}
