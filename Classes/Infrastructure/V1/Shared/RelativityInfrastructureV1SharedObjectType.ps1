class RelativityInfrastructureV1SharedObjectType
{
    <#
        .SYNOPSIS
            Represents a custom object type added to a workspace.
        .PARAMETER ArtifactID
            Gets or sets the Artifact ID of an Object Type.
        .PARAMETER ArtifactTypeID
            Gets or sets the Descriptor Artifact Type ID of the Object Type object.
        .PARAMETER Guids
            Gets or sets the GUIDs used to identify the Object Type.
        .PARAMETER Name
            Gets or sets the user-friendly name of an Object Type.
    #>
    [Int32] $ArtifactID
    [Int32] $ArtifactTypeID
    [Collections.Generic.List[Guid]] $Guids
    [String] $Name
    
    RelativityInfrastructureV1SharedObjectType()
    {
    }

    RelativityInfrastructureV1SharedObjectType(
        [Int32] $ArtifactID,
        [Int32] $ArtifactTypeID,
        [Collections.Generic.List[Guid]] $Guids,
        [String] $Name
    )
    {
        $this.ArtifactID = $ArtifactID
        $this.ArtifactTypeID = $ArtifactTypeID
        $this.Guids = $Guids
        $this.Name = $Name
    }

    RelativityInfrastructureV1SharedObjectType([Hashtable] $ObjectType)
    {
        $this.ArtifactID = $ObjectType.ArtifactID
        $this.ArtifactTypeID = $ObjectType.ArtifactTypeID
        
        $this.Guids = @()
        $ObjectType.Guids | ForEach-Object (
            $this.Guids.Add($_)
        )

        $this.Name = $ObjectType.Name        
    }
}