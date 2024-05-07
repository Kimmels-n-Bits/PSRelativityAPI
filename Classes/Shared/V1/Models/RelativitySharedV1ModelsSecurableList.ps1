class RelativitySharedV1ModelsSecurableList
{
    <# TODO
        .SYNOPSIS
            Generic class that indicates whether or not the given value is secured from the current user
        .PARAMETER Secured
            Whether or not the current user has permission to view the given value
        .PARAMETER Value
            A Generic [System.Object]
            The value that may or may not be secured
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
        $this.Secured = $HasSecuredItems
        $this.ViewableItems = $ViewableItems
    }
}