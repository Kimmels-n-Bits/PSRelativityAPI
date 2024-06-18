class RelativityServicesObjectsDataContractsRelativityObjectSlim
{
    <#
        .SYNOPSIS
            Represents a streamlined RelativityObjectSlim with values that map to fields on a QueryResult object.

        .PARAMETER ArtifactID
            Gets or sets the Artifact ID of the object.
        .PARAMETER Values
            Gets or sets a list of values for the object. The order of the values corresponds to the order of the fields in the result set.
    #>
    [Int32] $ArtifactID
    [Collections.Generic.List[PSCustomObject]] $Values

    
    RelativityServicesObjectsDataContractsRelativityObjectSlim()
    {
    }

    RelativityServicesObjectsDataContractsRelativityObjectSlim(
        [Int32] $ArtifactID,
        [Collections.Generic.List[PSCustomObject]] $Values
    )
    {
        $this.ArtifactID = $ArtifactID
        $this.Values = $Values
    }

    RelativityServicesObjectsDataContractsRelativityObjectSlim([PSCustomObject] $Object)
    {
        $this.ArtifactID = $Object.ArtifactID

        $this.Values = @()
        $Object.Values | ForEach-Object {
            $this.Values.Add($_)
        }
    }
}