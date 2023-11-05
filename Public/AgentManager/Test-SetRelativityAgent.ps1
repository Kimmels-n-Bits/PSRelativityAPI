<#
.SYNOPSIS
Function to validate whether a Relativity Agent can be updated using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, calls Relativity's REST API, and processes the response to validate whether an agent can be updated.

.PARAMETER ArtifactID
The Artifact ID of the agent to update.

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

.EXAMPLE
Test-SetRelativityAgent -ArtifactID 1019521 -AgentTypeArtifactID 1015277 -AgentServerArtifactID 1016924 -Enabled -Interval 60 -Count 2
This example validates whether a Relativity agent can be updated with the given agent type, agent server and a check interval of 60 seconds.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Test-SetRelativityAgent
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ArtifactID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $AgentTypeSecured,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $AgentTypeArtifactID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $AgentServerSecured,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $AgentServerArtifactID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $Enabled,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, 604800)]
        [Int32] $Interval = 30,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, 10)]
        [Int32] $LoggingLevel = 5,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $Keywords,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $Notes
    )

    Begin
    {
        Write-Verbose "Starting Test-SetRelativityAgent"
    }
    Process
    {
        try
        {
            $AgentType = [RelativityAgentRequestSecuredValue]::New($AgentTypeSecured, $AgentTypeArtifactID)
            $AgentServer = [RelativityAgentRequestSecuredValue]::New($AgentServerSecured, $AgentServerArtifactID)
            $AgentRequest = [RelativityAgentRequestAgentRequest]::New($AgentType, $AgentServer, $Enabled, $Interval, $LoggingLevel, $Keywords, $Notes)
            
            $Request = [RelativityAgentUpdateRequest]::New($AgentRequest, $null)

            $RequestBody = $Request.ToHashTable()

            [String[]] $Resources = @("workspace", "-1", "agents", $ArtifactID.ToString(), "validateinstancelimits")

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Debug "Prepaparing to invoke POST method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 3)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody

            $Response = [RelativityApiSuccessResponse]::New($ApiResponse.Success)

            Write-Verbose "Successfully validated whether an agent could be updated."

            return $Response
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            Write-Verbose "AgentTypeSecured: $($AgentTypeSecured)"
            Write-Verbose "AgentTypeArtifactID: $($AgentTypeArtifactID)"
            Write-Verbose "AgentServerSecured: $($AgentServerSecured)"
            Write-Verbose "AgentServerArtifactID: $($AgentServerArtifactID)"
            Write-Verbose "Enabled: $($Enabled)"
            Write-Verbose "Interval: $($Interval)"
            Write-Verbose "LoggingLevel: $($LoggingLevel)"
            Write-Verbose "Keywords: $($Keywords)"
            Write-Verbose "Notes: $($Notes)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed Test-SetRelativityAgent"
    }
}