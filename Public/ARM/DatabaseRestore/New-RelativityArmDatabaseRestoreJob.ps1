<#
.SYNOPSIS
Function to create a new Relativity ARM database restore job using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, calls Relativity's REST API, and processes the response to create a new ARM database restore job.

.PARAMETER SourceDatabase
The name of the database which will be restored.

.PARAMETER JobPriority
Priority of execution for the job. Possible options include "Low", "Medium", and "High". Default is "Medium".

.PARAMETER ScheduledStartTime
Scheduled time when the job will be run.

.PARAMETER DatabaseServerID
ArtifactId of the target database server to restore the workspace to.

.PARAMETER ResourcePoolID
ArtifactId of the target resource pool to restore the workspace to.

.PARAMETER MatterID
ArtifactId of the target matter to restore the workspace to.

.PARAMETER CacheLocationID
ArtifactId of the target cache location to restore the workspace to.

.PARAMETER FileRepositoryID
ArtifactId of the target file repository to restore the workspace to.

.PARAMETER AutoMapUsers
Indicates if archive users should be auto mapped by email address.

.PARAMETER UserMappings
Hashtable array of explicit user mappings from the archive to the Relativity instance.
Array must have two properties, ArchiveUserID and InstanceUserID, of type Int32.

.PARAMETER AutoMapGroups
Indicates if archive groups should be auto mapped by name.

.PARAMETER GroupMappings
Hashtable array of explicit group mappings from the archive to the Relativity instance.
Array must have two properties, ArchiveGroupID and InstanceGroupID, of type Int32.

.PARAMETER NotifyJobCreator
Indicates if email notifications will be sent to the job creator.

.PARAMETER NotifyJobExecutor
Indicates if email notifications will be sent to the job executor.

.PARAMETER UiJobActionsLocked
Indicates if job actions normally available on UI should be visible for the user.
This behavior can be override by adding boolean instance setting OverrideUiJobActionsLock.

.EXAMPLE
New-RelativityArmDatabaseRestoreJob -SourceDatabase "EDDS1234567" -DatabaseServerID 1234567 -ResourcePoolID 2345671 -MatterID 3456712 -CacheLocationID 4567123 -FileRepositoryID 5671234

This example creates a new database restore job with the specified database and destination options.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function New-RelativityArmDatabaseRestoreJob
{
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $SourceDatabase,
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
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $DatabaseServerID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ResourcePoolID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $MatterID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $CacheLocationID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $FileRepositoryID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $AutoMapUsers,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Hashtable[]] $UserMappings,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $AutoMapGroups,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Hashtable[]] $GroupMappings,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $NotifyJobCreator,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $NotifyJobExecutor,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $UiJobActionsLocked
    )

    Begin
    {
        Write-Verbose "Starting New-RelativityArmDatabaseRestoreJob"
    }
    Process
    {
        try
        {
            $Params = @{
                SourceDatabase = $SourceDatabase
                JobPriority = $JobPriority
                ScheduledStartTime = $ScheduledStartTime
                DatabaseServerID = $DatabaseServerID
                ResourcePoolID = $ResourcePoolID
                MatterID = $MatterID
                CacheLocationID = $CacheLocationID
                FileRepositoryID = $FileRepositoryID
                AutoMapUsers = $AutoMapUsers
                UserMappings = $UserMappings
                AutoMapGroups = $AutoMapGroups
                GroupMappings = $GroupMappings
                NotifyJobCreator = $NotifyJobCreator
                NotifyJobExecutor = $NotifyJobExecutor
                UiJobActionsLocked = $UiJobActionsLocked
            }

            $Request = Get-RelativityArmDatabaseRestoreJobCreateOrUpdateRequest @Params

            $RequestBody = $Request.ToHashTable()

            [String[]]$Resources = @("database-restore-jobs")

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndPoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndPoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody

                $Response = [RelativityArmJobCreateResponse]::New([Int32] $ApiResponse)
                Write-Verbose "Successfully created ARM restore job with ID: $($Response.JobID)"
            }

            return $Response
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            Write-Verbose "SourceDatabase: $($SourceDatabase)"
            Write-Verbose "JobPriority: $($JobPriority)"
            Write-Verbose "ScheduledStartTime: $($ScheduledStartTime)"
            Write-Verbose "DatabaseServerID: $($DatabaseServerID)"
            Write-Verbose "ResourcePoolID: $($ResourcePoolID)"
            Write-Verbose "MatterID: $($MatterID)"
            Write-Verbose "CacheLocationID: $($CacheLocationID)"
            Write-Verbose "FileRepositoryID: $($FileRepositoryID)"
            Write-Verbose "AutoMapUsers: $($AutoMapUsers)"
            Write-Verbose "UserMappings $($UserMappings | ConvertTo-Json)"
            Write-Verbose "AutoMapGroups: $($AutoMapGroups)"
            Write-Verbose "GroupMappings: $($GroupMappings | ConvertTo-Json)"
            Write-Verbose "NotifyJobCreator: $($NotifyJobCreator)"
            Write-Verbose "NotifyJobExecutor: $($NotifyJobExecutor)"
            Write-Verbose "UiJobActionsLocked: $($UiJobActionsLocked)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed New-RelativityArmDatabaseRestoreJob"
    }
}
