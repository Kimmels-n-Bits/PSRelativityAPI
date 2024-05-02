<#
.SYNOPSIS
Function to retrieve metadata for a Relativity Agent using Relativity's REST API.

.DESCRIPTION
This function sends a GET request to the Relativity REST API to retrieve metadata for an agent. It can fetch basic
information or extended metadata, which includes operations permitted for the agent.

.PARAMETER ArtifactID
The Artifact ID of the agent for which metadata is being retrieved.

.PARAMETER Extended
Switch to indicate if extended metadata should be retrieved. If this switch is provided, the function retrieves
extended information, including permissible operations on the agent.

.EXAMPLE
Get-RelativityAgent -ArtifactID 2017104
This example retrieves basic metadata for the Relativity agent with the given Artifact ID.

.EXAMPLE
Get-RelativityAgent -ArtifactID 2017104 -Extended
This example retrieves extended metadata for the Relativity agent with the given Artifact ID.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Get-RelativityAgent
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ArtifactID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $Extended
    )

    Begin
    {
        Write-Verbose "Starting Get-RelativityAgent"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("workspace", "-1", "agents", $ArtifactID.ToString())

            if ($Extended)
            {
                $Resources += "true"
                $Resources += "true"
            }

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = [RelativityAgentReadResponse]::New($ApiResponse)

            Write-Verbose "Agent metadata retrieved successfully."
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
        Write-Verbose "Completed Get-RelativityAgent"
    }
}