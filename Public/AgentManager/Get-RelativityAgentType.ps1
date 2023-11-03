<#
.SYNOPSIS
Retrieves details of Relativity agent types.

.DESCRIPTION
The function sends a request to retrieve details of the agent types in Relativity.
The response contains various details about each agent type, such as the agent type's name, artifactID, default logging level, default run interval, company name, and associated application.

.EXAMPLE
Get-RelativityAgentType

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function. 
The function does not modify any data but only retrieves details of Relativity's agent types
#>
function Get-RelativityAgentType
{
    [CmdletBinding()]
    Param ()
    Process
    {
        try 
        {
            [String[]] $Resources = @("workspace", "-1", "agenttypes")

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = [RelativityAgentTypeReadResponse[]]@()

            $ApiResponse | ForEach-Object {
                $Response += [RelativityAgentTypeReadResponse]::New($_)
            }
            
            Write-Verbose "Agent types retrieved successfully."
            return $Response
        }
        catch
        {
            Write-Debug "API Endpoint: $($ApiEndpoint)"
            throw
        }
    }
}