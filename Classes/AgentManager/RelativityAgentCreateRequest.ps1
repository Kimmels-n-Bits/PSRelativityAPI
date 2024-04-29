class RelativityAgentCreateRequest
{
    [RelativityAgentRequestAgentRequest] $AgentRequest
    [Int32] $Count

    RelativityAgentCreateRequest([RelativityAgentRequestAgentRequest] $agentRequest, [Int32] $count)
    {
        $this.AgentRequest = $agentRequest
        $this.Count = $count
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("AgentRequest", $this.AgentRequest.ToHashTable())
        $ReturnValue.Add("Count", $this.Count)

        return $ReturnValue
    }
}
