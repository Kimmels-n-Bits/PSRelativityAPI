class RelativityInfrastructureV1SharedObjectIdentifier
{
    <#
        .SYNOPSIS
            Represents a way to uniquely identify Relativity Objects.
        .PARAMETER ArtifactID
            Unique identifier for the object.
        .PARAMETER Guids
            A list of unique Guids identifying the object.
    #>
    [Int32] $ArtifactID
    [Collections.Generic.List[Guid]] $Guids

    RelativityInfrastructureV1SharedObjectIdentifier()
    {
    }

    RelativityInfrastructureV1SharedObjectIdentifier(
        [Int32] $ArtifactID,
        [Collections.Generic.List[Guid]] $Guids
    )
    {
        $this.ArtifactID = $ArtifactID
        $this.Guids = $Guids
    }

    RelativityInfrastructureV1SharedObjectIdentifier(
        [PSCustomObject] $ApiResponse
    )
    {
        $this.ArtifactID = $ApiResponse.ArtifactID
        
        [Collections.Generic.List[Guid]] $ObjectGuids = @()

        $ApiResponse.Guids | ForEach-Object
        {
            $ObjectGuids.Add($_)
        }
    }
}