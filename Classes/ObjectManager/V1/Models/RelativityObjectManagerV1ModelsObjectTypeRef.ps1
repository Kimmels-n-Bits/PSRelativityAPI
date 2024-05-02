class RelativityObjectManagerV1ModelsObjectTypeRef
{
    <#
        .SYNOPSIS
            Represents a key or reference to an ObjectType object.
        .PARAMETER ArtifactID
            Gets or sets the Artifact ID of an Object Type.
        .PARAMETER ArtifactTypeID
            Gets or sets the Descriptor Artifact Type ID of the Object Type object. This ID also identifies an Object
            Type artifact as an ArtifactType.
        .PARAMETER Guid
            Gets or sets a GUID used to identify the Object Type.
        .PARAMETER Name
            Gets or sets the user-friendly name of an Object Type.
    #>
    [Int32] $ArtifactID
    [Int32] $ArtifactTypeID
    [Guid] $Guid
    [String] $Name

    RelativityObjectManagerV1ModelsObjectTypeRef()
    {
    }

    RelativityObjectManagerV1ModelsObjectTypeRef(
        [Int32] $ArtifactID,
        [Int32] $ArtifactTypeID,
        [Guid] $Guid,
        [String] $Name
    )
    {
        $this.ArtifactID = $ArtifactID
        $this.ArtifactTypeID = $ArtifactTypeID
        $this.Guid = $Guid
        $this.Name = $Name
    }
}