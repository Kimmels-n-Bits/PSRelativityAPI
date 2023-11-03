class RelativityAgentCreateRequestSecuredValue
{
    [Boolean] $Secured
    [Int32] $Value

    RelativityAgentCreateRequestSecuredValue([Boolean] $secured, [Int32] $value)
    {
        $this.Secured = $secured
        $this.Value = $value
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("Secured", $this.Secured)
        $ReturnValue.Add("Value", @{ ArtifactID = $this.Value.ToString() })
        
        return $ReturnValue
    }
}

class RelativityAgentCreateRequestAgentRequest
{
    [RelativityAgentCreateRequestSecuredValue] $AgentType
    [RelativityAgentCreateRequestSecuredValue] $AgentServer
    [Boolean] $Enabled
    [Int32] $Interval
    [Int32] $LoggingLevel
    [String] $Keywords
    [String] $Notes

    RelativityAgentCreateRequestAgentRequest(
        [RelativityAgentCreateRequestSecuredValue] $agentType,
        [RelativityAgentCreateRequestSecuredValue] $agentServer,
        [Boolean] $enabled,
        [Int32] $interval,
        [Int32] $loggingLevel,
        [String] $keywords,
        [String] $notes
    )
    {
        $this.AgentType = $agentType
        $this.AgentServer = $agentServer
        $this.Enabled = $enabled
        $this.Interval = $interval
        $this.LoggingLevel = $loggingLevel
        $this.Keywords = $keywords
        $this.Notes = $notes
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("AgentType", $this.AgentType.ToHashTable())
        $ReturnValue.Add("AgentServer", $this.AgentServer.ToHashTable())
        $ReturnValue.Add("Enabled", $this.Enabled)
        $ReturnValue.Add("Interval", $this.Interval)
        $ReturnValue.Add("LoggingLevel", $this.LoggingLevel)
        $ReturnValue.Add("Keywords", $this.Keywords)
        $ReturnValue.Add("Notes", $this.Notes)

        return $ReturnValue
    }
}

class RelativityAgentCreateRequest
{
    [RelativityAgentCreateRequestAgentRequest] $AgentRequest
    [Int32] $Count

    RelativityAgentCreateRequest([RelativityAgentCreateRequestAgentRequest] $agentRequest, [Int32] $count)
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