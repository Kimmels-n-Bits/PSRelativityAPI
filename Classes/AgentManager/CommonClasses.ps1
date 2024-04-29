#TODO: Replace all references to RelativityAgentRequestSecuredValue to RelativityObjectSecuredValue
class RelativityAgentRequestSecuredValue
{
    [Boolean] $Secured
    [Int32] $Value

    RelativityAgentRequestSecuredValue([Boolean] $secured, [Int32] $value)
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

class RelativityAgentRequestAgentRequest
{
    [RelativityAgentRequestSecuredValue] $AgentType
    [RelativityAgentRequestSecuredValue] $AgentServer
    [Boolean] $Enabled
    [Int32] $Interval
    [Int32] $LoggingLevel
    [String] $Keywords
    [String] $Notes

    RelativityAgentRequestAgentRequest(
        [RelativityAgentRequestSecuredValue] $agentType,
        [RelativityAgentRequestSecuredValue] $agentServer,
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
