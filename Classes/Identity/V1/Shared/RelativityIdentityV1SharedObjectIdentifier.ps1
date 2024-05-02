class RelativityIdentityV1SharedObjectIdentifier
{
    <#
        .SYNOPSIS
            Represents a way to uniquely identify Rlativity Objects.
        .PARAMETER ArtifactID
            Unique identifier for the object.
        .PARAMETER Guids
            A list of unique Guids identifying the object.
    #>
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