class RelativityObjectManagerV1ModelsSort
{
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
}