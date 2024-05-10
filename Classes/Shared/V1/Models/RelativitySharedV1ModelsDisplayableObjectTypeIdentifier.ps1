class RelativitySharedV1ModelsDisplayableObjectTypeIdentifier : RelativitySharedV1ModelsObjectIdentifier
{
    <#
        .SYNOPSIS
            An identifier that can identify an Object Type by its ArtifactID, Guids, Name, or ArtifactTypeID.
        .PARAMETER ArtifactTypeID
            The Int32 that uniquely identifies the object type within the current context (i.e. workspace vs. admin).
        .PARAMETER Name
            The Name of the displayable object.
    #>
    [Int32] $ArtifactTypeID
    [String] $Name

    RelativitySharedV1ModelsDisplayableObjectTypeIdentifier()
    {
    }

    RelativitySharedV1ModelsDisplayableObjectTypeIdentifier(
        [Int32] $ArtifactTypeID,
        [Int32] $ArtifactID,
        [Collections.Generic.List[Guid]] $Guids,
        [String] $Name
    ) : base ($ArtifactID, $Guids)
    {
        $this.ArtifactTypeID = $ArtifactTypeID
        $this.Name = $Name
    }

    RelativitySharedV1ModelsDisplayableObjectTypeIdentifier(
        [PSCustomObject] $ApiResponse
    )
    {
        [Collections.Generic.List[Guid]] $_guids = @()
        if($ApiResponse.Guids -ne $null)
        {
            $ApiResponse.Guids | ForEach-Object {
                $_guids.Add($_)
            }
        }
        else
        {
            $_guids = $null
        }

        $this.ArtifactTypeID = $ApiResponse.ArtifactTypeID
        $this.ArtifactID = $ApiResponse.ArtifactID
        $this.Name = $ApiResponse.Name
        $this.Guids = $_guids
    }
}