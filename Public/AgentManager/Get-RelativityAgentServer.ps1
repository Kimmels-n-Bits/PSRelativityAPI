<#
.SYNOPSIS
Function to retrieve a list of agent servers or servers compatible with a specific agent type using Relativity's REST
API.

.DESCRIPTION
This function sends a GET request to the Relativity REST API to retrieve a list of all agent servers in a Relativity
environment or servers compatible with a specific agent type. If the AgentTypeArtifactID parameter is provided, it
fetches servers compatible with that agent type; otherwise, it retrieves all agent servers.

.PARAMETER AgentTypeArtifactID
(Optional) The Artifact ID of the agent type to retrieve compatible agent servers for. If not specified, the function
retrieves all agent servers.

.EXAMPLE
Get-RelativityAgentServer
This example retrieves a list of all agent servers in the Relativity environment.

.EXAMPLE
Get-RelativityAgentServer -AgentTypeArtifactID 1015277
This example retrieves a list of agent servers compatible with the specified agent type.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Get-RelativityAgentServer
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $AgentTypeArtifactID
    )

    Begin
    {
        Write-Verbose "Starting Get-RelativityAgentServer"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("workspace", "-1")

            if ($null -ne $AgentTypeArtifactID -and $AgentTypeArtifactID -gt 0)
            {
                $Resources += "agenttypes"
                $Resources += $AgentTypeArtifactID.ToString()
                $Resources += "availableagentservers"
            }
            else
            {
                $Resources += "agentservers"
            }

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Verbose "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = New-Object "System.Collections.Generic.List[RelativityAgentServerReadResponse]"

            $ApiResponse | ForEach-Object {
                $Response.Add([RelativityAgentServerReadResponse]::New($_))
            }

            Write-Verbose "Agent servers retrieved successfully."
            return $Response.ToArray()
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            Write-Verbose "AgentTypeArtifactID: $($AgentTypeArtifactID)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed Get-RelativityAgentServer"
    }
}