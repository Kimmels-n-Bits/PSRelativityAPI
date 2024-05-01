class RelativityObjectManagerV1ModelsFieldRef
{
    [Int32] $ActiveArtifactID
    [Guid] $Guid
    [String] $Name
    [Int32] $ViewFieldID

    RelativityObjectManagerV1ModelsFieldRef()
    {
    }

    RelativityObjectManagerV1ModelsFieldRef(
        [Int32] $ActiveArtifactID,
        [Guid] $Guid,
        [String] $Name,
        [Int32] $ViewFieldID
    )
    {
        $this.ActiveArtifactID = $ActiveArtifactID
        $this.Guid = $Guid
        $this.Name = $Name
        $this.ViewFieldID = $ViewFieldID
    }
}