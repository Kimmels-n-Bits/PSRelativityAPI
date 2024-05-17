class RelativityObjectManagerV1ModelsFieldRef
{
    <#
        .SYNOPSIS
            Represents a key or reference to a Field object.
        .PARAMETER ArtifactID
            Gets or sets the Artifact ID of a Field object.
        .PARAMETER Guid
            Gets or sets a GUID used to identify a Field object.
        .PARAMETER Name
            Gets or sets the user-friendly name of a Field object.
        .PARAMETER ViewFieldID
            Gets or sets a unique identifier used to reference a view field.
    #>
    [Int32] $ArtifactID
    [Guid] $Guid
    [String] $Name
    [Int32] $ViewFieldID

    RelativityObjectManagerV1ModelsFieldRef()
    {
    }

    RelativityObjectManagerV1ModelsFieldRef(
        [Int32] $ArtifactID,
        [Guid] $Guid,
        [String] $Name,
        [Int32] $ViewFieldID
    )
    {
        $this.ArtifactID = $ArtifactID
        $this.Guid = $Guid
        $this.Name = $Name
        $this.ViewFieldID = $ViewFieldID
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        if ($this.ArtifactID -ne 0) { $ReturnValue.Add("ArtifactID", $this.ArtifactID) }
        if ($this.Guid -ne ([Guid]"00000000-0000-0000-0000-000000000000")) { $ReturnValue.Add("Guid", $this.Guid) }
        if (-not [String]::IsNullOrEmpty($this.Name)) { $ReturnValue.Add("Name", $this.Name) }

        return $ReturnValue
    }
}