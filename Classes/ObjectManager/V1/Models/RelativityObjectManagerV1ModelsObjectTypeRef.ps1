class RelativityObjectManagerV1ModelsObjectTypeRef
{
    [Int32] $ArtifactID
    [Int32] $ArtifactTypeID
    [Guid] $Guid
    [String] $Name

    RelativityObjectManagerV1ModelsObjectTypeRef()
    {
    }

    RelativityObjectManagerV1ModelsObjectTypeRef(
        [Int32] $ArtifactID,
        [Int32] $ArtifactTypeID,
        [Guid] $Guid,
        [String] $Name
    )
    {
        $this.ArtifactID = $ArtifactID
        $this.ArtifactTypeID = $ArtifactTypeID
        $this.Guid = $Guid
        $this.Name = $Name
    }
}