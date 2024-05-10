class RelativitySharedV1ModelsObjectIdentifier
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

    RelativitySharedV1ModelsObjectIdentifier()
    {
    }

    RelativitySharedV1ModelsObjectIdentifier(
        [Int32] $ArtifactID,
        [Collections.Generic.List[Guid]] $Guids
    )
    {
        $this.ArtifactID = $ArtifactID
        $this.Guids = $Guids
    }

    RelativitySharedV1ModelsObjectIdentifier(
        [PSCustomObject] $ApiResponse
    )
    {
        [Collections.Generic.List[Guid]] $_guids = @()
        $ApiResponse.Guids | ForEach-Object {
            $_guids.Add($_)
        }

        $this.ArtifactID = $ApiResponse.ArtifactID
        $this.Guids = $_guids
    }
}