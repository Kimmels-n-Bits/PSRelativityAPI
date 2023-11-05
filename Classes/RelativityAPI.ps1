class RelativityApiSuccessResponse
{
    [Boolean] $Success

    RelativityApiSuccessResponse([Boolean] $success)
    {
        $this.Success = $success
    }
}