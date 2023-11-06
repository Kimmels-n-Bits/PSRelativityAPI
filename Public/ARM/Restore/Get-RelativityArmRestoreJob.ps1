<#
.SYNOPSIS
Retrieves details of a Relativity ARM restore job using Relativity's REST API.

.DESCRIPTION
The function sends a request to retrieve details of an ARM restore job in Relativity based on the provided JobID.

.PARAMETER JobID
The ID of the ARM restore job to retrieve. This is a mandatory parameter.

.EXAMPLE
Get-RelativityArmRestoreJob -JobID 2525

This example retrieves details of the restore job with the ID of 2525.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Get-RelativityArmRestoreJob
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1,[Int32]::MaxValue)]
        [Int32] $JobID
    )

    Begin
    {
        Write-Verbose "Starting Get-RelativityArmRestoreJob"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("restore-jobs", $JobID.ToString())

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = [RelativityArmRestoreJobReadResponse]::New($ApiResponse)

            Write-Verbose "ARM Restore Job details retrieved successfully."
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
        Write-Verbose "Completed Get-RelativityArmRestoreJob"
    }
}