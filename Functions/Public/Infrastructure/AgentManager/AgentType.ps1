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
    Process
    {
        $RelativityApiEndpointExtended = "agenttypes"

        $RelativityAgentTypeReadResponse = Invoke-RelativityApiRequest -RelativityBusinessDomain "AgentManager" -RelativityApiEndpointExtended $RelativityApiEndpointExtended -RelativityApiHttpMethod "Get"

        $RelativityAgentTypes = [RelativityAgentType[]]@()

        $RelativityAgentTypeReadResponse | ForEach-Object {
            $RelativityAgentTypes += [RelativityAgentType]::New($_.ApplicationName, $_.CompanyName, $_.DefaultInterval, $_.DefaultLoggingLevel, $_.ArtifactID, $_.Name)
        }
        
        return $RelativityAgentTypes
    }
}