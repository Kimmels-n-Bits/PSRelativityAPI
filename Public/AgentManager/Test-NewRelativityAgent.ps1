<#
.SYNOPSIS
Function to validate whether a new Relativity Agent can be created using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, calls Relativity's REST API, and processes the response to validate
whether a new agent can be created.

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
Test-NewRelativityAgent -AgentTypeArtifactID 1015277 -AgentServerArtifactID 1016924 -Enabled -Interval 60 -Count 2
This example validates whether two new Relativity agents with the given agent type, agent server and a check interval
of 60 seconds can be created.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Test-NewRelativityAgent
{
    [CmdletBinding()]
    Param
    (
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
        [String] $Notes,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $Count = 1
    )

    Begin
    {
        Write-Verbose "Starting Test-NewRelativityAgent"
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

            [String[]] $Resources = @("workspace", "-1", "agents", "validateinstancelimits")

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Debug "Prepaparing to invoke POST method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody

            $Response = [RelativityApiSuccessResponse]::New($ApiResponse.Success)

            Write-Verbose "Successfully validated whether one or more agents could be created. Count: $($Response.Count)."

            return $Response
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "Logging parameter values:"

            (Get-Command -Name $PSCmdlet.MyInvocation.InvocationName).Parameters | ForEach-Object {
                $_.Values | ForEach-Object {
                    $Parameter = Get-Variable -Name $_.Name -ErrorAction SilentlyContinue

                    if ($null -ne $Parameter)
                    {
                        Write-Verbose "$($Parameter.Name): $($Parameter.Value)"
                    }
                }
            }

            Write-Verbose "API Endpoint: $($ApiEndpoint)"

            throw
        }
    }
    End
    {
        Write-Verbose "Completed Test-NewRelativityAgent"
    }
}