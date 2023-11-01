<#
.SYNOPSIS
Class to represent the server where the agent is to be added in the Relativity's REST API.

.DESCRIPTION
This class contains properties and methods required to build a structured request for Agent Server in the Relativity's REST API.

.PARAMETER Secured
Indicates whether the current user has permission to view the setting in the Value field.

.PARAMETER Value
The Artifact ID of the server.

.METHOD ToHashTable
Converts the object to a hashtable suitable for JSON conversion.
#>
class RelativityAgentRequestAgentServer {
    [ValidateNotNull()]
    [Boolean] $Secured
    [ValidateNotNull()]
    [Int32] $Value

    RelativityAgentRequestAgentServer([Boolean] $secured, [Int32] $value)
    {
        $this.Secured = $secured
        $this.Value = $value
    }

    [Hashtable] ToHashTable()
    {
        return @{
            Secured = $this.Secured
            Value = @{ ArtifactID = $this.Value.ToString() }
        }
    }
}

