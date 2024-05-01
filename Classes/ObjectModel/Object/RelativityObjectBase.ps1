class RelativityObjectBase : RelativityObjectRef
{
    [String] $Name
    [Guid[]] $Guids

    RelativityObjectBase(
        [Int32] $ArtifactID,
        [String] $Name,
        [Guid[]] $Guids
    ) : base ($ArtifactID)
    {
        $this.Name = $Name
        $this.Guids = $Guids
    }
}