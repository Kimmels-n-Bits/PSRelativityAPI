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

    RelativitySharedV1ModelsDisplayableObjectIdentifier(
        [PSCustomObject] $DisplayableObject
    )
    {
        [Collections.Generic.List[Guid]] $_guids = @()
        if($DisplayableObject.Guids -ne $null)
        {
            $DisplayableObject.Guids | ForEach-Object {
                $_guids.Add($_)
            }
        }
        else
        {
            $_guids = $null
        }

        $this.ArtifactID = $DisplayableObject.ArtifactID
        $this.Name = $DisplayableObject.Name
        $this.Guids = $_guids
    }
}