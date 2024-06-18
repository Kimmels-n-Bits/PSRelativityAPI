class RelativityServicesObjectsDataContractsQueryResult
{
    <#
        .SYNOPSIS
            Represents the results of a QueryRequest.

        .PARAMETER CurrentStartIndex
            Gets or sets the starting index for a result item in a query result set.
        .PARAMETER IDWindow
            Gets or sets the Window object containing the IDs of the objects included in the current results set.
        .PARAMETER Objects[]
            Gets or sets a list of objects in read results from the query.
        .PARAMETER ObjectType
            Gets or sets the type of the objects returned from a query.
        .PARAMETER RankWindow
            Gets or sets the set of ranks used to prime the review tool's session.
        .PARAMETER RelationalField
            Gets or sets the related items included in the result set based on this field.
        .PARAMETER ResultCount
            Gets or sets the number of result items returned by the current query.
        .PARAMETER SampleDetails
            Gets or sets the token used to persist an existing sample from one call to the next. The sample includes the metadata from the sampling run.
        .PARAMETER TotalCount
            Gets or sets the total number of objects returned by the query.
    #>
    [Int32] $CurrentStartIndex
    [Collections.Generic.List[Int32]] $IDWindow
    [Collections.Generic.List[RelativityServicesObjectsDataContractsRelativityObject]] $Objects
    [RelativityServicesObjectsDataContractsObjectType] $ObjectType
    [Collections.Generic.List[System.Double]] $RankWindow
    [RelativityServicesObjectsDataContractsField] $RelationalField
    [Int32] $ResultCount
    [RelativityServicesObjectsDataContractsSampleDetails] $SampleDetails
    [Int32] $TotalCount    

    RelativityServicesObjectsDataContractsQueryResult (
        [PSCustomObject] $ApiResponse
    )
    {
        $this.CurrentStartIndex = $ApiResponse.CurrentStartIndex

        if ($ApiResponse.IDWindow -ne $null)
        {
            $this.IDWindow = @()
            $ApiResponse.IDWindow | ForEach-Object {
                $this.IDWindow.Add($_)
            }
        }

        $this.Objects = @()
        $ApiResponse.Objects | ForEach-Object {
            $this.Objects.Add([RelativityServicesObjectsDataContractsRelativityObject]::new($_))
        }

        $this.ObjectType = $ApiResponse.ObjectType

        $this.RankWindow = $ApiResponse.RankWindow

        if ($ApiResponse.RelationalField -ne $null)
        {
            $this.RelationalField = $ApiResponse.RelationalField
        }

        $this.ResultCount = $ApiResponse.ResultCount

        if ($ApiResponse.SampleDetails -ne $null)
        {
            $this.SampleDetails = $ApiResponse.SampleDetails
        }        

        $this.TotalCount = $ApiResponse.TotalCount
    }
}