class RelativityObjectManagerV1ModelsSearchIndexRef
{
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