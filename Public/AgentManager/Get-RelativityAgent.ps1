<#
.SYNOPSIS
Function to retrieve metadata of a specific Relativity Agent.

.DESCRIPTION
The function sends a request to retrieve either basic or extended metadata of a specified Relativity Agent.

.PARAMETER AgentID
The Artifact ID of the agent for which the metadata needs to be retrieved.

.PARAMETER Extended
Switch to indicate if extended metadata should be retrieved.

.EXAMPLE
Get-RelativityAgent -AgentID $AgentID

.EXAMPLE
Get-RelativityAgent -AgentID $AgentID -Extended

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function. 
The function does not modify any data but only retrieves details of Relativity's agent types
#>
function Get-RelativityAgent
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [Int32] $AgentID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Switch] $Extended
    )

    Process
    {
        try
        {
            [String[]] $Resources = @("workspace", "-1", "agents", $AgentID.ToString())

            if ($Extended)
            {
                $Resources += "true"
                $Resources += "true"
            }

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            [RelativityAgentReadResponse] $Response = [RelativityAgentReadResponse]::New($ApiResponse)

            Write-Verbose "Agent metadata retrieved successfully."
            return $Response
        }
        catch 
        {
            Write-Debug "API Endpoint: $($ApiEndpoint)"
            Write-Debug "AgentID: $($AgentID)"
            Write-Debug "Extended: $($Extended)"
            throw
        }
    }
}