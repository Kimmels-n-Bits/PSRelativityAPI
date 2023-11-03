<#
.SYNOPSIS
Retrieves details of Relativity agent servers.

.DESCRIPTION
The function sends a request to retrieve details of the agent servers in Relativity.
The response contains various details about each agent server, such as the agent server's name, artifactID, type, number of agents, and number of processor cores.

.PARAMETER AgentTypeID
AgentTypeID is an optional filter for servers that support the indicated Agent Type.

.EXAMPLE
Get-RelativityAgentServer

.EXAMPLE
Get-RelativityAgentServer -AgentTypeID 1234567

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function. 
The function does not modify any data but only retrieves details of Relativity's agent servers
#>
function Get-RelativityAgentServer
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Int32] $AgentTypeID
    )
    Process
    {
        try
        {
            [String[]] $Resources = @("workspace", "-1")

            if ($null -ne $AgentTypeID -and $AgentTypeID -gt 0)
            {
                $Resources += "agenttypes"
                $Resources += $AgentTypeID.ToString()
                $Resources += "availableagentservers"
            }
            else 
            {
                $Resources += "agentservers"
            }

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = [RelativityAgentServerReadResponse[]]@()

            $ApiResponse | ForEach-Object {
                $Response += [RelativityAgentServerReadResponse]::New($_)
            }
            
            Write-Verbose "Agent servers retrieved successfully."
            return $Response
        }
        catch 
        {
            Write-Debug "API Endpoint: $($ApiEndpoint)"
            Write-Debug "AgentTypeID: $($AgentTypeID)"
            throw
        }
    }
}