class RelativityAgentRequest {
    [ValidateNotNull()]
    [RelativityAgentRequestAgentType] $AgentType
    [ValidateNotNull()]
    [RelativityAgentRequestAgentServer] $AgentServer
    [ValidateNotNull()]
    [Boolean] $Enabled
    [ValidateNotNull()]
    [Int32] $Interval
    [ValidateRange(1, 10)]
    [Int32] $LoggingLevel
    [ValidateNotNull()]
    [String] $Keywords
    [ValidateNotNull()]
    [String] $Notes

    RelativityAgentRequest([RelativityAgentRequestAgentType] $agentType, [RelativityAgentRequestAgentServer] $agentServer, [Boolean] $enabled, [Int32] $interval, [Int32] $loggingLevel, [String] $keywords, [String] $notes)
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
        return @{
            AgentType = $this.AgentType.ToHashTable()
            AgentServer = $this.AgentServer.ToHashTable()
            Enabled = $this.Enabled
            Interval = $this.Interval
            LoggingLevel = $this.LoggingLevel
            Keywords = $this.Keywords
            Notes = $this.Notes
        }
    }
}

