class RelativityAgentTypeReadResponse
{
    [String] $ApplicationName
    [String] $CompanyName
    [Double] $DefaultInterval
    [Int32] $DefaultLoggingLevel
    [Int32] $ArtifactID
    [String] $Name

    RelativityAgentTypeReadResponse([PSCustomObject] $ApiResponse)
    {
        $this.ApplicationName = $ApiResponse.ApplicationName
        $this.CompanyName = $ApiResponse.CompanyName
        $this.DefaultInterval = $ApiResponse.DefaultInterval
        $this.DefaultLoggingLevel = $ApiResponse.DefaultLoggingLevel
        $this.ArtifactID = $ApiResponse.ArtifactID
        $this.Name = $ApiResponse.Name
    }
}