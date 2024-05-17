class RelativityObjectManagerV1ModelsSort
{
    <#
        .SYNOPSIS
            Represents sorting information for query results.
        .PARAMETER Direction
            Gets or sets the sort order as either ascending or descending.
        .PARAMETER FieldIdentifier
            Gets or sets the identifier for the field used to sort the results.
        .PARAMETER Order
            Gets or sets an integer indicating precedence when more than one sort order is defined.
    #>
    [RelativityObjectManagerV1ModelsSortEnum] $Direction
    [RelativityObjectManagerV1ModelsFieldRef] $FieldIdentifier
    [Int32] $Order

    RelativityObjectManagerV1ModelsSort()
    {
    }

    RelativityObjectManagerV1ModelsSort(
        [RelativityObjectManagerV1ModelsSortEnum] $Direction,
        [RelativityObjectManagerV1ModelsFieldRef] $FieldIdentifier,
        [Int32] $Order
    )
    {
        $this.Direction = $Direction
        $this.FieldIdentifier = $FieldIdentifier
        $this.Order = $Order
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("Direction", $this.Direction)
        $ReturnValue.Add("FieldIdentifier", $this.FieldIdentifier.ToHashTable())
        $ReturnValue.Add("Order", $this.Order)

        return $ReturnValue
    }
}