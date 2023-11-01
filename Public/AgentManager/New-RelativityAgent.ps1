function New-RelativityAgent
{
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $AgentTypeSecured,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $AgentTypeArtifactID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $AgentServerSecured,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $AgentServerArtifactID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $Enabled,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Int32] $Interval = 30,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Int32] $LoggingLevel = 5,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $Keywords,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $Notes,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Int32] $Count = 1
    )
    Process
    {
        $AgentType = [RelativityAgentRequestAgentType]::New($AgentTypeSecured, $AgentTypeArtifactID)
        $AgentServer = [RelativityagentRequestAgentServer]::New($AgentServerSecured, $AgentServerArtifactID)
        $AgentRequest = [RelativityAgentRequest]::New($AgentType, $AgentServer, $Enabled, $Interval, $LoggingLevel, $Keywords, $Notes)
        
        $RelativityAgentCreateRequest = [RelativityAgentCreateRequest]::New($AgentRequest, $Count)

        $RelativityApiRequestBody = $RelativityAgentCreateRequest.ToHashTable()

        [RelativityApiEndpointResource[]] $RelativityApiEndpointResources = @()
        $RelativityApiEndpointResources += [RelativityApiEndpointResource]::New("workspace", "-1")
        $RelativityApiEndpointResources += [RelativityApiEndpointREsource]::New("agents")
        $RelativityApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain = "relativity.agents" -Resources $RelativityApiEndpointResources

        $RelativityApiResponse = Invoke-RelativityApiRequest -RelativityApiEndpoint $RelativityApiEndpoint -RelativityApiHttpMethod "Post" -RelativityApiRequestBody $RelativityApiRequestBody

        $RelativityAgentCreateResponse = [RelativityAgentCreateResponse[]]@()

        $RelativityApiResponse | ForEach-Object {
            $RelativityAgentCreateResponse += [RelativityAgentCreateResponse]::New($_)
        }

        return $RelativityAgentCreateResponse
    }
}