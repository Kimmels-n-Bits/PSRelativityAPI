class RelativityIdentityV1SharedSecurable
{
    <#
        .SYNOPSIS
            Generic class that indicates whether or not the given value is secured from the current user
        .PARAMETER Secured
            Whether or not the current user has permission to view the given value
        .PARAMETER Value
            A Generic [System.Object]
            The value that may or may not be secured
        
        .NOTES
            The class is currently exactly like [RelativitySharedV1ModelsSecurable], but a different namespace.
    #>
    [Boolean] $Secured
    [System.Object] $Value

    RelativityIdentityV1SharedSecurable()
    {
    }

    RelativityIdentityV1SharedSecurable(
        [Boolean] $Secured,
        [System.Object] $Value
    )
    {
        $this.Secured = $Secured
        $this.Value = $Value
    }
}