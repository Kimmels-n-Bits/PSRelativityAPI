class RelativityServicesObjectsDataContractsRelativityObjectRef
{
    <#
        .SYNOPSIS
            Part of a QueryResult object.

        .PARAMETER ArtifactID
            none
        .PARAMETER Guid
            none
    #>
    [Int32] $ArtifactID
    [Nullable[Guid]] $Guid

    
    RelativityServicesObjectsDataContractsRelativityObjectRef()
    {
    }

    RelativityServicesObjectsDataContractsRelativityObjectRef(
        [Int32] $ArtifactID,
        [Nullable[Guid]] $Guid
    )
    {
        $this.ArtifactID = $ArtifactID
        $this.Guid = $Guid
    }

    RelativityServicesObjectsDataContractsRelativityObjectRef([PSCustomObject] $RelativityObjectRef)
    {
        $this.ArtifactID = $RelativityObjectRef.ArtifactID

        if ($RelativityObjectRef.Guid -ne $null)
        {
            $this.Guid = $RelativityObjectRef.Guid
        }
    }
}