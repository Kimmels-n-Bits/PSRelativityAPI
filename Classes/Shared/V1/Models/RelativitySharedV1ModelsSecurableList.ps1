class RelativitySharedV1ModelsSecurableList
{
    <#
        .SYNOPSIS
            Generic class that indicates whether a list has items secured from the current user.
        .PARAMETER HasSecuredItems
            Whether or not there are any number of items secured away from the user.
        .PARAMETER ViewableItems
            A Generic [Collections.Generic.List[System.Object]]
            List of items that are accessible to the user.
    #>
    [Boolean] $HasSecuredItems
    [Collections.Generic.List[System.Object]] $ViewableItems

    RelativitySharedV1ModelsSecurableList()
    {
    }

    RelativitySharedV1ModelsSecurableList(
        [Boolean] $HasSecuredItems,
        [Collections.Generic.List[System.Object]] $ViewableItems
    )
    {
        $this.HasSecuredItems = $HasSecuredItems
        $this.ViewableItems = $ViewableItems
    }
}