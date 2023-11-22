<#
.SYNOPSIS
Function to retry a Relativity ARM job task using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, sends a POST request to the Relativity REST API, and processes the response to retry an ARM job task.

.PARAMETER TaskID
The Task ID of the ARM job task to retry. This is a mandatory parameter.

.EXAMPLE
Restart-RelativityArmJobTask -TaskID 1000
This example retries the Relativity ARM job task with the given Task ID.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Restart-RelativityArmJobTask
{
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $TaskID
    )

    Begin
    {
        Write-Verbose "Starting Restart-RelativityArmJobTask"
    }
    Process
    {
        try 
        {
            [String[]] $Resources = @("tasks", $TaskID.ToString(), "retry")

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndPoint)'"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody

                $Response = [RelativityApiSuccessResponse]::New($ApiResponse.Success)

                Write-Verbose "Successfully retried ARM job task."
            }
            
            return $Response
        }
        catch 
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            Write-Verbose "TaskID: $($TaskID)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed Restart-RelativityArmJobTask"
    }
}