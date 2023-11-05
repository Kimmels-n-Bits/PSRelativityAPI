<#
.SYNOPSIS
Function to validte whether a Relativity Agent can be deleted using Relativity's REST API.

.DESCRIPTION
This function constructs the required request, calls Relativity's REST API, and processes the response to validate whether an agent can be deleted.

.PARAMETER ArtifactID
The Artifact ID of the agent to be deleted.

.EXAMPLE
Test-RemoveRelativityAgent -ArtifactID 1015277
This example validates the removal of a Relativity agent with the given Artifact ID.

.NOTES
Ensure you have connectivity and appropriate permissions in Relativity before running this function.
#>
function Test-RemoveRelativityAgent
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [Int32] $ArtifactID
    )

    Begin
    {
        Write-Verbose "Starting Test-RemoveRelativityAgent"
    }
    Process
    {
        try 
        {
            [String[]] $Resources = @("workspace", "-1", "agents", $ArtifactID.ToString(), "validateinstancelimits")

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Verbose "Invoking DELETE method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Delete"

            $Response = [RelativityApiSuccessResponse]::New($ApiResponse.Success)
            
            Write-Verbose "Successfully deleted agent."

            return $Response
        }
        catch 
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            Write-Verbose "ArtifactID: $($ArtifactID)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed Test-RemoveRelativityAgent"
    }
}