class RelativityObjectQueryRequestBase
{
    [RelativityObjectTypeBase] $ObjectType
    [RelativityObjectBase[]] $Fields
    [RelativityObjectQueryCondition] $Condition
    [Boolean] $LongTextBehavior
    [RelativityObjectQuerySort[]] $Sorts
    [String] $QueryHint

    RelativityObjectQueryRequestBase(
        [RelativityObjectTypeBase] $ObjectType,
        [RelativityObjectBase[]] $Fields,
        [RelativityObjectQueryCondition] $Condition,
        [Boolean] $LongTextBehavior,
        [RelativityObjectQuerySort[]] $Sorts,
        [String] $QueryHint
    )
    {
        $this.ObjectType = $ObjectType,
        $this.Fields = $Fields,
        $this.Condition = $Condition,
        $this.LongTextBehavior = $LongTextBehavior,
        $this.Sorts = $Sorts,
        $this.QueryHint = $QueryHint
    }
}