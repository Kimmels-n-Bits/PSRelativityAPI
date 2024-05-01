class RelativityObjectTypeBase : RelativityObjectTypeRef
{
    [Int32] $ArtifactID
    [String] $Name
    [Guid[]] $Guids

    RelativityObjectTypeBase (
        [Int32] $ArtifactTypeID,
        [Int32] $ArtifactID,
        [String] $Name,
        [Guid[]] $Guids
    ) : base ($ArtifactTypeID)
    {
        $this.ArtifactID = $ArtifactID
        $this.Name = $Name
        $this.Guids = $Guids
    }
}