class RelativityInfrastructureV1SharedObjectIdentifier
{
    [String] $Name
    [Int32] $ArtifactID
    [Collections.Generic.List[Guid]] $Guids

    RelativityInfrastructureV1SharedObjectIdentifier()
    {
    }

    RelativityInfrastructureV1SharedObjectIdentifier(
        [String] $Name
        [Int32] $ArtifactID,
        [Collections.Generic.List[Guid]] $Guids
    )
    {
        $this.Name = $Name
        $this.ArtifactID = $ArtifactID
        $this.Guids = $Guids
    }

    RelativityInfrastructureV1SharedObjectIdentifier(
        [PSCustomObject] $ApiResponse
    )
    {
        $this.Name = $ApiResponse.Name
        $this.ArtifactID = $ApiResponse.ArtifactID
        
        [Collections.Generic.List[Guid]] $ObjectGuids = @()

        $ApiResponse.Guids | ForEach-Object
        {
            $ObjectGuids.Add($_)
        }
    }
}