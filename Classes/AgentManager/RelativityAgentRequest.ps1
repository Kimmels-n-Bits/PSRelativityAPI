<#
.SYNOPSIS
Class to represent a request for creating or updating an agent in the Relativity's REST API.

.DESCRIPTION
This class contains properties and methods required to build a structured request for Agent Request in the Relativity's REST API.

.PARAMETER AgentType
Indicates the kind of job that the agent executes.

.PARAMETER AgentServer
The server where the agent is to be added.

.PARAMETER Enabled
A Boolean value indicating whether the agent is running.

.PARAMETER Interval
Indicates the number of seconds that the agent should wait before checking the database for available jobs.

.PARAMETER LoggingLevel
An integer value indicating the message type that the system logs in the Event Viewer.

.PARAMETER Keywords
Optional words or phrases used to describe the agent.

.PARAMETER Notes
An optional description or other information about the agent.

.METHOD ToHashTable
Converts the object to a hashtable suitable for JSON conversion.
#>

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

