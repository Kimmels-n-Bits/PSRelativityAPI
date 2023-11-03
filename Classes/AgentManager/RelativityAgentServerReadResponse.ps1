class RelativityAgentServerReadResponse
{
    [String] $Type
    [Int32] $ProcessorCores
    [Int32] $NumberOfAgents
    [Int32] $ArtifactID
    [String] $Name

    RelativityAgentServerReadResponse([PSCustomObject] $ApiResponse)
    {
        $this.Type = $ApiResponse.Type
        $this.ProcessorCores = $ApiResponse.ProcessorCores
        $this.NumberOfAgents = $ApiResponse.NumberOfAgents
        $this.ArtifactID = $ApiResponse.ArtifactID
        $this.Name = $ApiResponse.Name
    }
}