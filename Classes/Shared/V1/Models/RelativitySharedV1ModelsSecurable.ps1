class RelativitySharedV1ModelsSecurable
{
    <#
        .SYNOPSIS
            Generic class that indicates whether or not the given value is secured from the current user
        .PARAMETER Secured
            Whether or not the current user has permission to view the given value
        .PARAMETER Value
            A Generic [System.Object]
            The value that may or may not be secured
    #>
    [Boolean] $Secured
    [System.Object] $Value

    RelativitySharedV1ModelsSecurable()
    {
    }

    RelativitySharedV1ModelsSecurable(
        [Boolean] $Secured,
        [System.Object] $Value
    )
    {
        $this.Secured = $Secured
        $this.Value = $Value
    }
}