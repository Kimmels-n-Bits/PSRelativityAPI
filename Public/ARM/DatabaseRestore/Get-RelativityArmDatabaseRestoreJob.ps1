<#
.SYNOPSIS
Retrieves details of a Relativity ARM database restore job using Relativity's REST API.

.DESCRIPTION
The function sends a request to retrieve details of an ARM database restore job in Relativity based on the provided JobID.

.PARAMETER JobID
The ID of the ARM database restore job to retrieve. This is a mandatory parameter.

.EXAMPLE
Get-RelativityArmDatabaseRestoreJob -JobID 1333

This example retrieves details of the database restore job with the ID of 1333.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Get-RelativityArmDatabaseRestoreJob
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $JobID
    )

    Begin
    {
        Write-Verbose "Starting Get-RelativityArmDatabaseRestoreJob"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("database-restore-jobs", $JobID.ToString())

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = [RelativityArmDatabaseRestoreJobReadResponse]::New($ApiResponse)

            Write-Verbose "ARM Database Restore Job details retrieved successfully."
            return $Response
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            Write-Verbose "JobID: $($JobID)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed Get-RelativityArmDatabaseRestoreJob"
    }
}