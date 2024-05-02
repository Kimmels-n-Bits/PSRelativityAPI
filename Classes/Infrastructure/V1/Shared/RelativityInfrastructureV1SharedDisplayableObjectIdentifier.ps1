class RelativityInfrastructureV1SharedDisplayableObjectIdentifier : RelativityInfrastructureV1SharedObjectIdentifier
{
    [String] $Name

    RelativityInfrastructureV1SharedDisplayableObjectIdentifier()
    {
    }

    RelativityInfrastructureV1SharedDisplayableObjectIdentifier(
        [Int32] $ArtifactID,
        [Collections.Generic.List[Guid]] $Guids,
        [String] $Name
    ) : base ($ArtifactID, $Guids)
    {
        $this.Name = $Name
    }
}