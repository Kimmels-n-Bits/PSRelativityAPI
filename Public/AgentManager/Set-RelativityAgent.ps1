<#
.SYNOPSIS
Function to update the properties of a Relativity Agent using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, sends a PUT request to the Relativity REST API, and processes the
response to update an agent's properties such as its run intervals, enabled property, and others. Additionally, it can
restrict the update to the date the agent was last modified by using the LastModifiedOn parameter.

.PARAMETER ArtifactID
The Artifact ID of the agent to be updated.

.PARAMETER AgentTypeSecured
Switch to indicate whether the current user has permission to view the setting in the Value field for AgentType.

.PARAMETER AgentTypeArtifactID
The Artifact ID for the agent type, such as a Branding Manager or Production Manager agent.

.PARAMETER AgentServerSecured
Switch to indicate whether the current user has permission to view the setting in the Value field for AgentServer.

.PARAMETER AgentServerArtifactID
The Artifact ID of the server where the agent is to be added.

.PARAMETER Enabled
Switch to indicate whether the agent should be running.

.PARAMETER Interval
Number of seconds the agent should wait before checking the database for available jobs. Default is 30 seconds.

.PARAMETER LoggingLevel
An integer value indicating the message type that the system should log in the Event Viewer. Default is 5.

.PARAMETER Keywords
Optional words or phrases used to describe the agent.

.PARAMETER Notes
Optional description or other information about the agent.

.PARAMETER LastModifiedOn
The date and time when the agent was most recently modified. This parameter is only required if you want to restrict
the update of an agent to the date that it was last modified.

.EXAMPLE
Set-RelativityAgent `
    -ArtifactID 1015277 `
    -AgentTypeArtifactID 1016924 `
    -AgentServerArtifactID 1016925 `
    -Enabled -Interval 60
This example updates the properties of a Relativity agent with the given Artifact IDs and a check interval of 60
seconds.

.EXAMPLE
Set-RelativityAgent `
    -ArtifactID 1015277 `
    -AgentTypeArtifactID 1016924 `
    -AgentServerArtifactID 1016925 `
    -Enabled -Interval 60 `
    -LastModifiedOn "2018-10-19T18:41:20.54"
This example updates the properties of a Relativity agent with the given Artifact IDs and a check interval of 60
seconds, and restricts the update to the date the agent was last modified.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Set-RelativityAgent
{
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ArtifactID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $AgentTypeSecured,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $AgentTypeArtifactID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $AgentServerSecured,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
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
        [String] $LastModifiedOn
    )

    Begin
    {
        Write-Verbose "Starting Set-RelativityAgent"
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

            $Request = [RelativityAgentUpdateRequest]::New($AgentRequest, $LastModifiedOn)

            $RequestBody = $Request.ToHashTable()

            [String[]] $Resources = @("workspace", "-1", "agents", $ArtifactID.ToString())

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Debug "Preparing to invoke PUT method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking PUT method at Relativity API: $($ApiEndpoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest `
                    -ApiEndpoint $ApiEndpoint `
                    -HttpMethod "Put" `
                    -RequestBody $RequestBody

                $Response = [RelativityApiSuccessResponse]::New($ApiResponse.Success)

                Write-Verbose "Successfully updated agent."
            }

            return $Response
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            Write-Verbose "ArtifactID: $($ArtifactID)"
            Write-Verbose "AgentTypeSecured: $($AgentTypeSecured)"
            Write-Verbose "AgentTypeArtifactID: $($AgentTypeArtifactID)"
            Write-Verbose "AgentServerSecured: $($AgentServerSecured)"
            Write-Verbose "AgentServerArtifactID: $($AgentServerArtifactID)"
            Write-Verbose "Enabled: $($Enabled)"
            Write-Verbose "Interval: $($Interval)"
            Write-Verbose "LoggingLevel: $($LoggingLevel)"
            Write-Verbose "Keywords: $($Keywords)"
            Write-Verbose "Notes: $($Notes)"
            Write-Verbose "LastModifiedOn: $($LastModifiedOn)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed Set-RelativityAgent"
    }
}