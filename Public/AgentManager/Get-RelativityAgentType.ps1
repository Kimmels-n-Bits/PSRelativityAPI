<#
.SYNOPSIS
Function to retrieve a list of agent types available in a Relativity instance using Relativity's REST API.

.DESCRIPTION
This function sends a GET request to the Relativity REST API to retrieve a list of agent types.

.EXAMPLE
Get-RelativityAgentType
This example retrieves a list of all agent types in the Relativity environment.

.NOTES
Make sure you have connectivity and the necessary permissions in Relativity before executing this function.
#>
function Get-RelativityAgentType
{
    [CmdletBinding()]
    Param ()

    Begin
    {
        Write-Verbose "Starting Get-RelativityAgentType"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("workspace", "-1", "agenttypes")

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = New-Object "System.Collections.Generic.List[RelativityAgentTypeReadResponse]"

            $ApiResponse | ForEach-Object {
                $Response.Add([RelativityAgentTypeReadResponse]::New($_))
            }

            Write-Verbose "Agent types retrieved successfully."
            return $Response.ToArray()
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed Get-RelativityAgentType"
    }
}