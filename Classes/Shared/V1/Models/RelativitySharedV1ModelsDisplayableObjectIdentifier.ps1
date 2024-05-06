class RelativitySharedV1ModelsDisplayableObjectIdentifier : RelativitySharedV1ModelsObjectIdentifier
{
    <#
        .SYNOPSIS
            An identifier that also includes a name.
        .PARAMETER Name
            The Name of the displayable object.
    #>
    [String] $Name

    RelativitySharedV1ModelsDisplayableObjectIdentifier()
    {
    }

    RelativitySharedV1ModelsDisplayableObjectIdentifier(
        [Int32] $ArtifactID,
        [Collections.Generic.List[Guid]] $Guids,
        [String] $Name
    ) : base ($ArtifactID, $Guids)
    {
        $this.Name = $Name
    }
}