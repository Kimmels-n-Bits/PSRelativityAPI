<#
.SYNOPSIS
Class to represent the entire request for creating agents in the Relativity's REST API.

.DESCRIPTION
This class contains properties and methods required to build a structured request for creating agents in the Relativity's REST API.

.PARAMETER AgentRequest
Represents a request for creating or updating an agent.

.PARAMETER Count
The number of agents to create.

.METHOD ToHashTable
Converts the object to a hashtable suitable for JSON conversion.
#>
class RelativityAgentCreateRequest {
    [ValidateNotNull()]
    [RelativityAgentRequest] $AgentRequest
    [ValidateNotNull()]
    [Int32] $Count

    RelativityAgentCreateRequest([RelativityAgentRequest] $agentRequest, [Int32] $count)
    {
        $this.AgentRequest = $agentRequest
        $this.Count = $count
    }

    [Hashtable] ToHashTable()
    {
        return @{
            AgentRequest = $this.AgentRequest.ToHashTable()
            Count = $this.Count
        }
    }
}

