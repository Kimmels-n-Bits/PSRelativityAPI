<#
.SYNOPSIS
Function to remove a Relativity ARM restore job using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, sends a DELETE request to the Relativity REST API, and processes the response to remove an ARM restore job.

.PARAMETER JobID
The Job ID of the ARM restore job to be deleted. This is a mandatory parameter.

.EXAMPLE
Remove-RelativityArmRestoreJob -JobID 200
This example removes the Relativity ARM restore job with the given Job ID.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Remove-RelativityArmRestoreJob
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
        Write-Verbose "Starting Remove-RelativityArmRestoreJob"
    }
    Process
    {
        try 
        {
            [String[]] $Resources = @("restore-jobs", $JobID.ToString())

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke DELETE method at Relativity API endpoint '$($ApiEndPoint)'"
            Write-Verbose "Invoking DELETE method at Relativity API endpoint: $($ApiEndpoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Delete" -RequestBody $RequestBody

                $Response = [RelativityApiSuccessResponse]::New($ApiResponse.Success)

                Write-Verbose "Successfully deleted ARM restore job."
            }
            
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
        Write-Verbose "Completed Remove-RelativityArmRestoreJob"
    }
}