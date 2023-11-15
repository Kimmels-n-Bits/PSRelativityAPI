<#
.SYNOPSIS
Function to remove a Relativity ARM move job using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, sends a DELETE request to the Relativity REST API, and processes the response to remove an ARM move job.

.PARAMETER JobID
The Job ID of the ARM move job to be deleted. This is a mandatory parameter.

.EXAMPLE
Remove-RelativityArmMoveJob -JobID 250
This example removes the Relativity ARM move job with the given Job ID.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Remove-RelativityArmMoveJob
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
        Write-Verbose "Starting Remove-RelativityArmMoveJob"
    }
    Process
    {
        try 
        {
            [String[]] $Resources = @("move-jobs", $JobID.ToString())

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke DELETE method at Relativity API endpoint '$($ApiEndPoint)'"
            Write-Verbose "Invoking DELETE method at Relativity API endpoint: $($ApiEndpoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Delete" -RequestBody $RequestBody

                $Response = [RelativityApiSuccessResponse]::New($ApiResponse.Success)

                Write-Verbose "Successfully deleted ARM move job."
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
        Write-Verbose "Completed Remove-RelativityArmMoveJob"
    }
}