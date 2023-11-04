function Set-RelativityAgent
{
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Int32] $AgentID,
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
        [ValidateRange(1, 10)]
        [Int32] $LoggingLevel = 5,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $Keywords,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $Notes,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String] $LastModifiedOn
    )
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

            [String[]] $Resources = @()
            $Resources += "workspace"
            $Resources += "-1"
            $Resources += "agents"
            $Resources += $AgentID.ToString()

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Debug "Prepaparing to invoke method with RequestBody $($RequestBody | ConvertTo-Json -Depth 3)"
            Write-Verbose "Invoking PUT method at Relativity API: $($ApiEndpoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Put" -RequestBody $RequestBody

                Write-Verbose "Successfully updated agent."
            }
            
            return $ApiResponse
        }
        catch 
        {
            Write-Debug "API Endpoint: $($ApiEndpoint)"
            Write-Debug "AgentTypeSecured: $($AgentTypeSecured)"
            Write-Debug "AgentTypeArtifactID: $($AgentTypeArtifactID)"
            Write-Debug "AgentServerSecured: $($AgentServerSecured)"
            Write-Debug "AgentServerArtifactID: $($AgentServerArtifactID)"
            Write-Debug "Enabled: $($Enabled)"
            Write-Debug "Interval: $($Interval)"
            Write-Debug "LoggingLevel: $($LoggingLevel)"
            Write-Debug "Keywords: $($Keywords)"
            Write-Debug "Notes: $($Notes)"
            Write-Debug "LastModifiedOn: $($LastModifiedOn)"
            throw
        }
    }
}