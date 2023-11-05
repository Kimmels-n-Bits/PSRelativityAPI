class RelativityAgentUpdateRequest
{

    [RelativityAgentRequestAgentRequest] $AgentRequest
    [String] $LastModifiedOn

    RelativityAgentUpdateRequest([RelativityAgentRequestAgentRequest] $agentRequest, [String] $lastModifiedOn)
    {
        $this.AgentRequest = $agentRequest

        [DateTime] $lastModifiedOnResult = New-Object "DateTime"

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