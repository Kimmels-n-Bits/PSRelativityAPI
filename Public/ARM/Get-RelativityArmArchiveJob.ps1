<#
.SYNOPSIS
Retrieves details of a Relativity ARM Archive Job using Relativity's REST API.

.DESCRIPTION
The function sends a request to retrieve details of an ARM archive job in Relativity based on the provided JobID.

.PARAMETER JobID
The ID of the ARM archive job to retrieve. This is a mandatory parameter.

.EXAMPLE
Get-RelativityArmArchiveJob -JobID 3026

This example retrieves details of the archive job with the ID of 3026.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Get-RelativityArmArchiveJob
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [Int32] $JobID
    )

    Begin
    {
        Write-Verbose "Starting Get-RelativityArmArchiveJob"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("archive-jobs", $JobID.ToString())

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = [RelativityArmArchiveJobReadResponse]::New($ApiResponse)

            Write-Verbose "ARM Archive Job details retrieved successfully."
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
        Write-Verbose "Completed Get-RelativityArmArchiveJob"
    }
}