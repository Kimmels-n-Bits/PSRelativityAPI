class RelativityAgentUpdateRequestSecuredValue
{
    [Boolean] $Secured
    [Int32] $Value

    RelativityAgentUpdateRequestSecuredValue([Boolean] $secured, [Int32] $value)
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

class RelativityAgentUpdateRequestAgentRequest
{
    [RelativityAgentUpdateRequestSecuredValue] $AgentType
    [RelativityAgentUpdateRequestSecuredValue] $AgentServer
    [Boolean] $Enabled
    [Int32] $Interval
    [Int32] $LoggingLevel
    [String] $Keywords
    [String] $Notes

    RelativityAgentUpdateRequestAgentRequest(
        [RelativityAgentUpdateRequestSecuredValue] $agentType,
        [RelativityAgentUpdateRequestSecuredValue] $agentServer,
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
        
        if (-not $null -eq $this.Keywords)
        {
            $ReturnValue.Add("Keywords", $this.Keywords)
        }

        if (-not $null -eq $this.Notes)
        {
            $ReturnValue.Add("Notes", $this.Notes)
        }

        return $ReturnValue
    }
}

class RelativityAgentUpdateRequest
{
    [RelativityAgentUpdateRequestAgentRequest] $AgentRequest
    [String] $LastModifiedOn

    RelativityAgentUpdateRequest([RelativityAgentUpdateRequestAgentRequest] $agentRequest, [String] $lastModifiedOn)
    {
        $this.AgentRequest = $agentRequest

        [DateTime] $lastModifiedOnResult = New-Object DateTime

        if ([DateTime]::TryParse($lastModifiedOn, [ref]$lastModifiedOnResult))
        {
            $this.LastModifiedOn = $lastModifiedOnResult
        }
        elseif(-not [String]::IsNullOrEmpty($lastModifiedOn))
        {
            throw "Error parsing LastModifiedOn value: $($lastModifiedOn)"
        }
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("AgentRequest", $this.AgentRequest.ToHashTable())

        if($null -ne $this.LastModifiedOn)
        {
            $ReturnValue.Add("LastModifiedOn", $this.LastModifiedOn)
        }

        return $ReturnValue
    }
}