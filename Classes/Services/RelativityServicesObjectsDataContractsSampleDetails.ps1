class RelativityServicesObjectsDataContractsSampleDetails
{
    <#
        .SYNOPSIS
            Represents information used to define a sample set. 
        .PARAMETER SampleSize
            Gets or sets the number of Documents or Relativity Dynamic Objects (RDOs) in a sample.
        .PARAMETER Token
            Gets or sets the identifier for a sample set.
        .PARAMETER UniverseSize
            Gets or sets the number of Documents or Relativity Dynamic Objects (RDOs) in the results for sampling.
    #>
    [Nullable[Int32]] $SampleSize
    [String] $Token
    [Nullable[Int32]] $UniverseSize
    
    RelativityServicesObjectsDataContractsSampleDetails()
    {
    }

    RelativityServicesObjectsDataContractsSampleDetails(
        [Nullable[Int32]] $SampleSize,
        [String] $Token,
        [Nullable[Int32]] $UniverseSize
    )
    {
        $this.SampleSize = $SampleSize
        $this.Token = $Token
        $this.UniverseSize = $UniverseSize
    }

    RelativityServicesObjectsDataContractsSampleDetails([PSCustomObject] $SampleDetails)
    {
        $this.SampleSize = $SampleDetails.SampleSize
        $this.Token = $SampleDetails.Token
        $this.UniverseSize = $SampleDetails.UniverseSize     
    }
}