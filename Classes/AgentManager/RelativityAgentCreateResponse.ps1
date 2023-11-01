class RelativityAgentCreateResponse {
    [ValidateNotNull()]
    [Int32] $ArtifactID

    RelativityAgentCreateResponse([Int32] $artifactID)
    {
        $this.ArtifactID = $artifactID
    }
}