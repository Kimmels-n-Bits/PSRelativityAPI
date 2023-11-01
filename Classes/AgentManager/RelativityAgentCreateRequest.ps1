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

