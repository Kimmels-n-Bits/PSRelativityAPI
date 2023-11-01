<#
.SYNOPSIS
Class to represent the response received after creating agents in the Relativity's REST API.

.DESCRIPTION
This class contains properties that hold information about the created agent in the Relativity's REST API.

.PARAMETER ArtifactID
The Artifact ID of the created agent.
#>
class RelativityAgentCreateResponse {
    [ValidateNotNull()]
    [Int32] $ArtifactID

    RelativityAgentCreateResponse([Int32] $artifactID)
    {
        $this.ArtifactID = $artifactID
    }
}