<#
.SYNOPSIS
Function to remove a Relativity Agent using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, sends a DELETE request to the Relativity REST API, and processes the response to remove an agent. It supports both graceful and forceful deletion of an agent. A graceful delete waits for the agent to finish executing before deletion, while a forceful delete removes the agent immediately, which is useful when an agent becomes unresponsive.

.PARAMETER AgentArtifactID
The Artifact ID of the agent to be deleted.

.PARAMETER Force
Switch to indicate whether to forcefully delete the agent. When this switch is provided, the agent will be deleted immediately without waiting for it to finish executing.

.EXAMPLE
Remove-RelativityAgent -AgentArtifactID 1015277
This example removes the Relativity agent with the given Artifact ID after it has finished executing.

.EXAMPLE
Remove-RelativityAgent -AgentArtifactID 1015277 -Force
This example forcefully removes the Relativity agent with the given Artifact ID immediately without waiting for it to finish executing.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function. It's recommended to use force delete only when an agent has become unresponsive.
#>
function Remove-RelativityAgent
{
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [Int32] $AgentArtifactID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $True)]
        [Switch] $Force
    )
    Process
    {
        try 
        {
            $Request = [RelativityagentDeleteRequest]::New($Force)

            $RequestBody = $Request.ToHashTable()

            [String[]] $Resources = @("workspace", "-1", "agents", $AgentArtifactID.ToString())

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Debug "Prepaparing to invoke method with RequestBody $($RequestBody | ConvertTo-Json -Depth 3)"
            Write-Verbose "Invoking DELETE method at Relativity API endpoint: $($ApiEndpoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Delete" -RequestBody $RequestBody
                Write-Verbose "Successfully deleted agent."
            }
            
            return $ApiResponse
        }
        catch 
        {
            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            Write-Verbose "AgentID: $($AgentArtifactID)"
            Write-Verbose "Force: $($Force)"
            throw
        }
    }
}