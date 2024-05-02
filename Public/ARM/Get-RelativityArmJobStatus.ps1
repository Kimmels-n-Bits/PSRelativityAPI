<#
.SYNOPSIS
Retrieves the status of a Relativity ARM job using Relativity's REST API.

.DESCRIPTION
The function sends a request to retrieve the status of an ARM job in Relativity based on the provided JobID.

.PARAMETER JobID
The ID of the ARM job to retrieve. This is a mandatory parameter.

.EXAMPLE
Get-RelativityArmJobStatus -JobID 3026

This example retrieves the status of the ARM job with the ID of 3026.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Get-RelativityArmJobStatus
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
        Write-Verbose "Starting Get-RelativityArmJobStatus"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("jobs", $JobID.ToString(), "status")

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-arm" `
                -Version "v1" `
                -Resources $Resources

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = [RelativityArmJobStatusReadResponse]::New($ApiResponse)

            Write-Verbose "ARM job status retrieved successfully."
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
        Write-Verbose "Completed Get-RelativityArmJobStatus"
    }
}