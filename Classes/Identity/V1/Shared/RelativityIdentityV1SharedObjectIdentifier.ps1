class RelativityIdentityV1SharedObjectIdentifier
{
    [Int32] $ArtifactID
    [Collections.Generic.List[Guid]] $Guids

    RelativityIdentityV1SharedObjectIdentifier()
    {
    }

    RelativityIdentityV1SharedObjectIdentifier(
        [Int32] $ArtifactID,
        [Collections.Generic.List[Guid]] $Guids
    )
    {
        $this.ArtifactID = $ArtifactID
        $this.Guids = $Guids
    }

    RelativityIdentityV1SharedObjectIdentifier(
        [PSCustomObject] $ApiResponse
    )
    {
        $this.ArtifactID = $ApiResponse.ArtifactID
        
        [Collections.Generic.List[Guid]] $ObjectGuids = @()

        $ApiResponse.Guids | ForEach-Object {
            $ObjectGuids.Add($_)
        }
    }
}