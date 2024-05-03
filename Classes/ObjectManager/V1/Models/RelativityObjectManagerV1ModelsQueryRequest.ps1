class RelativityObjectManagerV1ModelsQueryRequest
{
    <#
        .SYNOPSIS
            Describes conditions, sorts and fields to be returned for a query.
        .PARAMETER ActiveArtifactID
            Gets or sets the Artifact ID of an item when available in the query results. This item is used to override
            the start position for the result page.
        .PARAMETER Condition
            Gets or sets the search criteria. It can be a simple, single-field condition or a complex expression made
            by combining conditions.
        .PARAMETER ConvertNumberFieldValuesToString
            Gets or sets a Boolean value indicating whether to convert the numbers returned in the query to text.
        .PARAMETER ExecutingSavedSearchID
            Gets or sets the ID of the currently executing saved search.
        .PARAMETER ExecutingViewID
            Gets or sets the ID of the currently executing view.
        .PARAMETER Fields
            Gets or sets a collection of fields like a SELECT statement in an SQL query.
        .PARAMETER IncludeIDWindow
            Gets or sets Boolean value indicating whether the query results should include the IDs of the objects
            included in the current results set.
        .PARAMETER IncludeNameInQueryResult
            Gets or sets Boolean value indicating whether the Name property on the result objects is populated.
        .PARAMETER IsAdhocQuery
            Gets or sets a Boolean value indicating whether the query engine should handle the search or view
            condition as a query type or simple condition.
        .PARAMETER Length
            Gets or sets the number of items to return in the query set, starting with the index of the Start property.
        .PARAMETER LongTextBehavior
            Gets or sets the behavior used when a long text field exceeds the configured character limit.
        .PARAMETER MaxCharactersForLongTextValues
            Gets or sets the maximum number of characters returned in the query results for long text fields.
        .PARAMETER ObjectType
            Gets or sets the ObjectTypeRef for the type of object the query will run against.
        .PARAMETER QueryHint
            Gets or sets the QueryHint of the currently executing search. It is used to optimize the view.
        .PARAMETER RankSortOrder
            Gets or sets the sorting direction of Rank column in the Relativity UI, as either ascending or descending.
        .PARAMETER RelationalField
            Gets or sets the FieldRef used to include related items in query result.
        .PARAMETER RowCondition
            Gets or sets the row condition criteria.
        .PARAMETER SampleParameters
            Gets or sets the SampleParameters used to take a sample of the query result set.
        .PARAMETER SearchProviderConditions
            Gets or sets the search provider search condition.
        .PARAMETER Sorts
            Gets or sets the sort order for view results specified as a collection of Sort objects.
        .PARAMETER Start
            Gets or sets the one-based index of the first artifact in the result set.
    #>
    [Int32] $ActiveArtifactID
    [String] $Condition
    [Boolean] $ConvertNumberFieldValuesToString
    [Int32] $ExecutingSavedSearchID
    [Int32] $ExecutingViewID
    [Collections.Generic.List[RelativityObjectManagerV1ModelsFieldRef]] $Fields
    [Boolean] $IncludeIDWindow
    [Boolean] $IncludeNameInQueryResult
    [Boolean] $IsAdhocQuery
    [Int32] $Length
    [RelativityObjectManagerV1ModelsLongTextBehavior] $LongTextBehavior
    [Int32] $MaxCharactersForLongTextValues
    [RelativityObjectManagerV1ModelsObjectTypeRef] $ObjectType
    [String] $QueryHint
    [RelativityObjectManagerV1ModelsSortEnum] $RankSortOrder
    [RelativityObjectManagerV1ModelsFieldRef] $RelationalField
    [String] $RowCondition
    [RelativityObjectManagerV1ModelsSampleParameters] $SampleParameters
    [RelativityObjectManagerV1ModelsSearchProviderConditions] $SearchProviderConditions
    [Collections.Generic.List[RelativityObjectManagerV1ModelsSort]] $Sorts
    [Int32] $Start

    RelativityObjectManagerV1ModelsQueryRequest()
    {
    }

    RelativityObjectManagerV1ModelsQueryRequest(
        [Int32] $ActiveArtifactID,
        [String] $Condition,
        [Boolean] $ConvertNumberFieldValuesToString,
        [Int32] $ExecutingSavedSearchID,
        [Int32] $ExecutingViewID,
        [Collections.Generic.List[RelativityObjectManagerV1ModelsFieldRef]] $Fields,
        [Boolean] $IncludeIDWindow,
        [Boolean] $IncludeNameInQueryResult,
        [Boolean] $IsAdhocQuery,
        [Int32] $Length,
        [RelativityObjectManagerV1ModelsLongTextBehavior] $LongTextBehavior,
        [Int32] $MaxCharactersForLongTextValues,
        [RelativityObjectManagerV1ModelsObjectTypeRef] $ObjectType,
        [String] $QueryHint,
        [RelativityObjectManagerV1ModelsSortEnum] $RankSortOrder,
        [RelativityObjectManagerV1ModelsFieldRef] $RelationalField,
        [String] $RowCondition,
        [RelativityObjectManagerV1ModelsSampleParameters] $SampleParameters,
        [RelativityObjectManagerV1ModelsSearchProviderConditions] $SearchProviderConditions,
        [Collections.Generic.List[RelativityObjectManagerV1ModelsSort]] $Sorts,
        [Int32] $Start
    )
    {
        $this.ActiveArtifactID = $ActiveArtifactID
        $this.Condition = $Condition
        $this.ConvertNumberFieldValuesToString = $ConvertNumberFieldValuesToString
        $this.ExecutingSavedSearchID = $ExecutingSavedSearchID
        $this.ExecutingViewID = $ExecutingViewID
        $this.Fields = $Fields
        $this.IncludeIDWindow = $IncludeIDWindow
        $this.IncludeNameInQueryResult = $IncludeNameInQueryResult
        $this.IsAdhocQuery = $IsAdhocQuery
        $this.Length = $Length
        $this.LongTextBehavior = $LongTextBehavior
        $this.MaxCharactersForLongTextValues = $MaxCharactersForLongTextValues
        $this.ObjectType = $ObjectType
        $this.QueryHint = $QueryHint
        $this.RankSortOrder = $RankSortOrder
        $this.RelationalField = $RelationalField
        $this.RowCondition = $RowCondition
        $this.SampleParameters = $SampleParameters
        $this.SearchProviderConditions = $SearchProviderConditions
        $this.Sorts = $Sorts
        $this.Start = $Start
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}
        $Request = @{}

        if ($this.ActiveArtifactID -ne 0) { $Request.Add("ActiveArtifactID", $this.ActiveArtifactID) }
        if (-not [String]::IsNullOrEmpty($this.Condition)) { $Request.Add("Condition", $this.Condition) }
        $Request.Add("ConvertNumberFieldValuesToString", $this.ConvertNumberFieldValuesToString)

        if ($this.ExecutingSavedSearchID -ne 0)
        {
            $Request.Add("ExecutingSavedSearchID", $this.ExecutingSavedSearchID)
        }

        if ($this.ExecutingViewID -ne 0) { $Request.Add("ExecutingViewID", $this.ExecutingViewID) }
        $Request.Add("Fields", @($this.Fields | ForEach-Object { $_.ToHashTable() }))
        $Request.Add("IncludeIDWindow", $this.IncludeIDWindow)
        $Request.Add("IncludeNameInQueryResult", $this.IncludeNameInQueryResult)
        $Request.Add("IsAdhocQuery", $this.IsAdhocQuery)
        $Request.Add("LongTextBehavior", $this.LongTextBehavior)

        if ($this.MaxCharactersForLongTextValues -ne 0)
        {
            $Request.Add("MaxCharactersForLongTextValues", $this.MaxCharactersForLongTextValues)
        }

        $Request.Add("ObjectType", $this.ObjectType.ToHashTable())
        if (-not [String]::IsNullOrEmpty($this.QueryHint)) { $Request.Add("QueryHint", $this.QueryHint) }
        $Request.Add("RankSortOrder", $this.RankSortOrder)
        if ($null -ne $this.RelationalField) { $Request.Add("RelationalField", $this.RelationalField.ToHashTable()) }
        if (-not [String]::IsNullOrEmpty($this.RowCondition)) { $Request.Add("RowCondition", $this.RowCondition) }
        
        if ($null -ne $this.SampleParameters)
        {
            $Request.Add("SampleParameters", $this.SampleParameters.ToHashTable())
        }

        if ($null -ne $this.SearchProviderConditions)
        {
            $Request.Add("SearchProviderConditions", $this.SearchProviderConditions.ToHashTable())
        }

        if ($this.Sorts.Count -gt 0)
        {
            $Request.Add("Sorts", ($this.Sorts | ForEach-Object { $_.ToHashTable() }))
        }

        $ReturnValue.Add("Length", $this.Length)
        $ReturnValue.Add("Request", $Request)
        $ReturnValue.Add("Start", $this.Start)

        return $ReturnValue
    }
}