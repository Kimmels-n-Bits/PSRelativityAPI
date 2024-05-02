<#
.SYNOPSIS
Function to remove a Relativity ARM database restore job using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, sends a DELETE request to the Relativity REST API, and processes the response to remove an ARM database restore job.

.PARAMETER JobID
The Job ID of the ARM database restore job to be deleted. This is a mandatory parameter.

.EXAMPLE
Remove-RelativityArmDatabaseRestoreJob -JobID 250
This example removes the Relativity ARM database restore job with the given Job ID.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Remove-RelativityArmDatabaseRestoreJob
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
        Write-Verbose "Starting Remove-RelativityArmDatabaseRestoreJob"
    }
    Process
    {
        try 
        {
            [String[]] $Resources = @("database-restore-jobs", $JobID.ToString())

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity-arm" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke DELETE method at Relativity API endpoint '$($ApiEndPoint)'"
            Write-Verbose "Invoking DELETE method at Relativity API endpoint: $($ApiEndpoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Delete" -RequestBody $RequestBody

                $Response = [RelativityApiSuccessResponse]::New($ApiResponse.Success)

                Write-Verbose "Successfully deleted ARM database restore job."
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
        Write-Verbose "Completed Remove-RelativityArmDatabaseRestoreJob"
    }
}