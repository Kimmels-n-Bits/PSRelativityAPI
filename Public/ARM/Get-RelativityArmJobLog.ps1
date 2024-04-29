<#
.SYNOPSIS
Retrieves the log of a Relativity ARM job using Relativity's REST API.

.DESCRIPTION
The function sends a request to retrieve the log of an ARM job in Relativity based on the provided JobID.

.PARAMETER JobID
The ID of the ARM job to retrieve. This is a mandatory parameter.

.EXAMPLE
Get-RelativityArmJobLog -JobID 3026

This example retrieves the log of the ARM job with the ID of 3026.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Get-RelativityArmJobLog
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
        Write-Verbose "Starting Get-RelativityArmJobLog"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("jobs", $JobID.ToString(), "logs")

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-arm" `
                -Version "v1" `
                -Resources $Resources

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = ($ApiResponse | Select-Object -Skip 3 | ForEach-Object { [Char][Int32]$_ }) -join ""
            Write-Verbose "ARM job log retrieved successfully."

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
        Write-Verbose "Completed Get-RelativityArmJobLog"
    }
}