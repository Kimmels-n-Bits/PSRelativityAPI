class RelativitySharedV1ModelsSecurable
{
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