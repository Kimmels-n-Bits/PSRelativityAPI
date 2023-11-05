<#
.SYNOPSIS
Function to create a new Relativity Agent using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, calls Relativity's REST API, and processes the response to create a new agent.

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
This example creates two new Relativity agents with the given agent type on the given agent server and a check interval of 60 seconds.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function New-RelativityAgent
{
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $AgentTypeSecured,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [Int32] $AgentTypeArtifactID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $AgentServerSecured,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
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
        [ValidateNotNull()]
        [String] $Keywords = "",
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [String] $Notes = "",
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Int32] $Count = 1
    )

    Begin
    {
        Write-Verbose "Starting New-RelativityAgent"
    }
    Process
    {
        try
        {
            $AgentType = [RelativityAgentRequestSecuredValue]::New($AgentTypeSecured, $AgentTypeArtifactID)
            $AgentServer = [RelativityAgentRequestSecuredValue]::New($AgentServerSecured, $AgentServerArtifactID)
            $AgentRequest = [RelativityAgentRequestAgentRequest]::New(
                $AgentType,
                $AgentServer,
                $Enabled,
                $Interval,
                $LoggingLevel,
                $Keywords,
                $Notes
            )
            
            $Request = [RelativityAgentCreateRequest]::New($AgentRequest, $Count)

            $RequestBody = $Request.ToHashTable()

            [String[]] $Resources = @("workspace", "-1", "agents")

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Debug "Prepaparing to invoke method with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody

                $Response = New-Object "System.Collections.Generic.List[RelativityAgentCreateResponse]"

                $ApiResponse | ForEach-Object {
                    $Response.Add([RelativityAgentCreateResponse]::New( [Int32] $_))
                }
                Write-Verbose "Successfully created one or more agents. Count: $($Response.Count)."
            }

            return $Response.ToArray()
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Error "API Endpoint: $($ApiEndpoint)"
            Write-Error "AgentTypeSecured: $($AgentTypeSecured)"
            Write-Error "AgentTypeArtifactID: $($AgentTypeArtifactID)"
            Write-Error "AgentServerSecured: $($AgentServerSecured)"
            Write-Error "AgentServerArtifactID: $($AgentServerArtifactID)"
            Write-Error "Enabled: $($Enabled)"
            Write-Error "Interval: $($Interval)"
            Write-Error "LoggingLevel: $($LoggingLevel)"
            Write-Error "Keywords: $($Keywords)"
            Write-Error "Notes: $($Notes)"
            Write-Error "Count: $($Count)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed New-RelativityAgent"
    }
}