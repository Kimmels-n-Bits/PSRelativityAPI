class RelativityObjectManagerV1ModelsQueryRequest
{
    [Int32] $ActiveArtifactID
    [String] $Condition
    [Boolean] $ConvertNumberFieldValuesToString
    [Int32] $ExecutingSavedSearchID
    [Int32] $ExecutingViewID
    [Collections.Generic.List[RelativityObjectManagerV1ModelsFieldRef]] $Fields
    [Boolean] $IncludeIDWindow
    [Boolean] $IncludeNameInQueryResult
    [Boolean] $IsAdhocQuery
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
    }
}