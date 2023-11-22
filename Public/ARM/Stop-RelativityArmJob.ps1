<#
.SYNOPSIS
Function to stop a Relativity ARM job using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, sends a POST request to the Relativity REST API, and processes the response to stop an ARM job.

.PARAMETER JobID
The Job ID of the ARM job to stop. This is a mandatory parameter.

.EXAMPLE
Stop-RelativityArmJob -JobID 250
This example stops the Relativity ARM job with the given Job ID.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Stop-RelativityArmJob
{
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $JobID
    )

    Begin
    {
        Write-Verbose "Starting Stop-RelativityArmJob"
    }
    Process
    {
        try 
        {
            [String[]] $Resources = @("jobs", $JobID.ToString(), "cancel")

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndPoint)'"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody

                $Response = [RelativityApiSuccessResponse]::New($ApiResponse.Success)

                Write-Verbose "Successfully stopped ARM job."
            }
            
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
        Write-Verbose "Completed Stop-RelativityArmJob"
    }
}