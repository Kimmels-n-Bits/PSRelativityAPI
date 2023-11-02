<#
.SYNOPSIS
Class to represent the kind of job that the agent executes in the Relativity's REST API.

.DESCRIPTION
This class contains properties and methods required to build a structured request for Agent Type in the Relativity's REST API.

.PARAMETER Secured
Indicates whether the current user has permission to view the setting in the Value field.

.PARAMETER Value
The Artifact ID for the agent type, such as a Branding Manager or Production Manager agent.

.METHOD ToHashTable
Converts the object to a hashtable suitable for JSON conversion.
#>

class RelativityAgentRequestAgentType {
    [ValidateNotNull()]
    [Boolean] $Secured
    [ValidateNotNull()]
    [Int32] $Value

    RelativityAgentRequestAgentType([Boolean] $secured, [Int32] $value)
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

