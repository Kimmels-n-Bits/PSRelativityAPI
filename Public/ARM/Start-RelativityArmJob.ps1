<#
.SYNOPSIS
Function to start a Relativity ARM job using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, sends a POST request to the Relativity REST API, and processes the response to start an ARM job.

.PARAMETER JobID
The Job ID of the ARM job to start. This is a mandatory parameter.

.EXAMPLE
Start-RelativityArmJob -JobID 250
This example starts the Relativity ARM job with the given Job ID.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Start-RelativityArmJob
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
        Write-Verbose "Starting Start-RelativityArmJob"
    }
    Process
    {
        try 
        {
            [String[]] $Resources = @("jobs", $JobID.ToString(), "run")

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndPoint)'"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody

                $Response = [RelativityApiSuccessResponse]::New($ApiResponse.Success)

                Write-Verbose "Successfully started ARM job."
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
        Write-Verbose "Completed Start-RelativityArmJob"
    }
}