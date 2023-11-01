class RelativityAgentTypeReadResponse {
    [ValidateNotNullOrEmpty()]
    [String] $ApplicationName
    [ValidateNotNull()]
    [String] $CompanyName
    [ValidateNotNull()]
    [Double] $DefaultInterval
    [ValidateNotNull()]
    [Int32] $DefaultLoggingLevel
    [ValidateNotNull()]
    [Int32] $ArtifactID
    [ValidateNotNullOrEmpty()]
    [String] $Name

    RelativityAgentTypeReadResponse([String] $applicationName, [String] $companyName, [Double] $defaultInterval, [Int32] $defaultLoggingLevel, [Int32] $artifactID, [String] $name)
    {
        $this.ApplicationName = $applicationName
        $this.CompanyName = if($null -eq $companyName) { "" } else { $companyName }
        $this.DefaultInterval = $defaultInterval
        $this.DefaultLoggingLevel = if($null -eq $defaultLoggingLevel) { 1 } else { $defaultLoggingLevel }
        $this.ArtifactID = $artifactID
        $this.Name = $name
    }
}