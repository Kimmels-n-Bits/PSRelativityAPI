class RelativityInfrastructureV1SharedField
{
    <#
        .SYNOPSIS
            Represents a field used to store metadata, choices, and other information in Relativity. 
        .PARAMETER ArtifactID
            Gets or sets the Artifact ID of a Field object.
        .PARAMETER FieldCategory
            Gets or sets the FieldCategory enum used to indicate the specific functionality assigned to a field, such as stores descriptive text or acts as a relational field.
        .PARAMETER FieldType
            Gets or sets the type of a Relativity field, such as fixed-length text, date, single object, or others.
        .PARAMETER Guids
            Gets or sets the GUIDs used to identify a Field object.
        .PARAMETER Name
            Gets or sets the user-friendly name of a Field object.
        .PARAMETER ViewFieldID
            Gets or sets a unique integer used to reference a view field.
    #>
    [Int32] $ArtifactID
    [RelativityInfrastructureV1SharedFieldCategory] $FieldCategory
    [RelativityInfrastructureV1SharedFieldType] $FieldType
    [Collections.Generic.List[Guid]] $Guids
    [String] $Name
    [Int32] $ViewFieldID
    
    RelativityInfrastructureV1SharedField()
    {
    }

    RelativityInfrastructureV1SharedField(
        [Int32] $ArtifactID,
        [RelativityInfrastructureV1SharedFieldCategory] $FieldCategory,
        [RelativityInfrastructureV1SharedFieldType] $FieldType,
        [Collections.Generic.List[Guid]] $Guids,
        [String] $Name,
        [Int32] $ViewFieldID
    )
    {
        $this.ArtifactID = $ArtifactID
        $this.FieldCategory = $FieldCategory
        $this.FieldType = $FieldType
        $this.Guids = $Guids
        $this.Name = $Name
        $this.ViewFieldID = $ViewFieldID
    }

    RelativityInfrastructureV1SharedField([PSCustomObject] $Field)
    {
        $this.ArtifactID = $Field.ArtifactID

        if ([Enum]::IsDefined([RelativityInfrastructureV1SharedFieldCategory], $Field.FieldCategory)) {
            $this.FieldCategory = [Enum]::Parse([RelativityInfrastructureV1SharedFieldCategory], $Field.FieldCategory)
        } else {
            throw "Invalid enum [RelativityInfrastructureV1SharedFieldCategory] = $($Field.FieldCategory)"
        }

        if ([Enum]::IsDefined([RelativityInfrastructureV1SharedFieldType], $Field.FieldType)) {
            $this.FieldType = [Enum]::Parse([RelativityInfrastructureV1SharedFieldType], $Field.FieldType)
        } else {
            throw "Invalid enum [RelativityInfrastructureV1SharedFieldType] = $($Field.FieldType)"
        }

        $this.Guids = @()
        $Field.Guids | ForEach-Object {
            $this.Guids.Add($_)
        }

        $this.Name = $Field.Name

        $this.ViewFieldID = $Field.ViewFieldID
    }
}