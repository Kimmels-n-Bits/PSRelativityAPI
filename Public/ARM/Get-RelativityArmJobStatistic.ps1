<#
.SYNOPSIS
Retrieves the statistics of a Relativity ARM job using Relativity's REST API.

.DESCRIPTION
The function sends a request to retrieve the statistics of an ARM job in Relativity based on the provided JobID.

.PARAMETER JobExecutionID
The Execution ID of the ARM job to retrieve. This is a mandatory parameter.

.EXAMPLE
Get-RelativityArmJobStatistic -JobExecutionID 1000

This example retrieves the statistics of the ARM job execution with the ID of 1000.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Get-RelativityArmJobStatistic
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1,[Int32]::MaxValue)]
        [Int32] $JobExecutionID
    )

    Begin
    {
        Write-Verbose "Starting Get-RelativityArmJobStatistic"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("jobs", $JobExecutionID.ToString(), "statistics")

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = $ApiResponse
            <#$Response = [RelativityArmJobStatusReadResponse]::New($ApiResponse)#>

            Write-Verbose "ARM job statistics retrieved successfully."
            return $Response
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            Write-Verbose "JobExecutionID: $($JobExecutionID)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed Get-RelativityArmJobStatistic"
    }
}