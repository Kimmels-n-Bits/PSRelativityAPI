class RelativityServicesObjectsDataContractsRelativityObject
{
    <#
        .SYNOPSIS
            Represents a streamlined RelativityObject with values that map to fields on a QueryResult object.

        .PARAMETER ArtifactID
            Gets or sets the Artifact ID of the object.
        .PARAMETER FieldValues
            Gets or sets a list of values for the object. The order of the values corresponds to the order of the fields in the result set.
        .PARAMETER Guids
        .PARAMETER Name
        .PARAMETER ParentObject
    #>
    [Int32] $ArtifactID
    [Collections.Generic.List[RelativityServicesObjectsDataContractsFieldValuePair]] $FieldValues
    [Collections.Generic.List[guid]] $Guids
    [String] $Name
    [RelativityServicesObjectsDataContractsRelativityObjectRef] $ParentObject    

    
    RelativityServicesObjectsDataContractsRelativityObject()
    {
    }

    RelativityServicesObjectsDataContractsRelativityObject(
        [Int32] $ArtifactID,
        [Collections.Generic.List[RelativityServicesObjectsDataContractsFieldValuePair]] $FieldValues,
        [Collections.Generic.List[guid]] $Guids,
        [String] $Name,
        [RelativityServicesObjectsDataContractsRelativityObjectRef] $ParentObject
    )
    {
        $this.ArtifactID = $ArtifactID
        $this.FieldValues = $FieldValues
        $this.Guids = $Guids
        $this.Name = $Name
        $this.ParentObject = $ParentObject
    }

    RelativityServicesObjectsDataContractsRelativityObject([PSCustomObject] $Object)
    {
        $this.ArtifactID = $Object.ArtifactID

        $this.FieldValues = @()
        $Object.FieldValues | ForEach-Object {
            $this.FieldValues.Add([RelativityServicesObjectsDataContractsFieldValuePair]::New($_))
        }

        $this.Guids = @()
        $Object.Guids | ForEach-Object {
            $this.Guids.Add($_)
        }

        if ($Object.Name -ne $null)
        {
            $this.Name = $Object.Name
        }

        $this.ParentObject = [RelativityServicesObjectsDataContractsRelativityObjectRef]::New($Object.ParentObject)
    }
}