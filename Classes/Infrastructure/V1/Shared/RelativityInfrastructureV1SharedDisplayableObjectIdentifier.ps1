class RelativityInfrastructureV1SharedDisplayableObjectIdentifier : RelativityInfrastructureV1SharedObjectIdentifier
{
    <#
        .SYNOPSIS
            An identifier that also includes a name.
        .PARAMETER Name
            The Name of the displayable object.
    #>
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