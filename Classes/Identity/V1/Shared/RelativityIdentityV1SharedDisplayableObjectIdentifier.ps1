class RelativityIdentityV1SharedDisplayableObjectIdentifier : RelativityIdentityV1SharedObjectIdentifier
{
    <#
        .SYNOPSIS
            A generic representation of a Relativity Object with an object Name and Artifact ID.
        .PARAMETER Name
            The Name of the displayable object.
    #>
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
