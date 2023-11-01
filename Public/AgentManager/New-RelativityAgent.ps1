<#
.SYNOPSIS
Function to create a new Relativity Agent using the Relativity's REST API.

.DESCRIPTION
This function constructs the required request, calls the Relativity's REST API, and processes the response to create a new agent.

.PARAMETER AgentTypeSecured
Switch to indicate if the current user has permission to view the setting in the Value field for AgentType.

.PARAMETER AgentTypeArtifactID
The Artifact ID for the agent type.

.PARAMETER AgentServerSecured
Switch to indicate if the current user has permission to view the setting in the Value field for AgentServer.

.PARAMETER AgentServerArtifactID
The Artifact ID of the server.

.PARAMETER Enabled
Switch to indicate if the agent should be running.

.PARAMETER Interval
Number of seconds the agent should wait before checking the database. Default is 30 seconds.

.PARAMETER LoggingLevel
Message type that the system should log in the Event Viewer. Default is 5.

.PARAMETER Keywords
Optional words or phrases to describe the agent.

.PARAMETER Notes
Optional description or other information about the agent.

.PARAMETER Count
Number of agents to create. Default is 1.

.EXAMPLE
New-RelativityAgent -AgentTypeArtifactID 1015277 -AgentServerArtifactID 1016924 -Enabled -Interval 60 -Count 2
This example creates two new Relativity agents with the given Artifact IDs and a check interval of 60 seconds.
#>
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
        $RelativityApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $RelativityApiEndpointResources

        $RelativityApiResponse = Invoke-RelativityApiRequest -RelativityApiEndpoint $RelativityApiEndpoint -RelativityApiHttpMethod "Post" -RelativityApiRequestBody $RelativityApiRequestBody

        $RelativityAgentCreateResponse = [RelativityAgentCreateResponse[]]@()

        $RelativityApiResponse | ForEach-Object {
            $RelativityAgentCreateResponse += [RelativityAgentCreateResponse]::New($_)
        }

        return $RelativityAgentCreateResponse
    }
}