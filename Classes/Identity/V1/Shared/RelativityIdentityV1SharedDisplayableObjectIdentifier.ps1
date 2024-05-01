class RelativityIdentityV1SharedDisplayableObjectIdentifier : RelativityIdentityV1SharedObjectIdentifier
{
    [String] $Name

    RelativityIdentityV1SharedDisplayableObjectIdentifier()
    {
    }

    RelativityIdentityV1SharedDisplayableObjectIdentifier(
        [Int32] $ArtifactID,
        [Collections.Generic.List[Guid]] $Guids,
        [String] $Name
    ) : base ($ArtifactID, $Guids)
    {
        $this.Name = $Name
    }
}
