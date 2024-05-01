class RelativityObjectManagerV1ModelsSearchIndexRef
{
    <#
        .SYNOPSIS
            Represents a key or reference to a search provider.
        .PARAMETER ArtifactID
            Gets or sets the Artifact ID of a search provider.
        .PARAMETER Name
            Gets or sets the user-friendly name of a search provider.
    #>
    [Int32] $ArtifactID
    [String] $Name

    RelativityObjectManagerV1ModelsSearchIndexRef()
    {
    }

    RelativityObjectManagerV1ModelsSearchIndexRef(
        [Int32] $ArtifactID,
        [String] $Name
    )
    {
        $this.ArtifactID = $ArtifactID
        $this.Name = $Name
    }
}