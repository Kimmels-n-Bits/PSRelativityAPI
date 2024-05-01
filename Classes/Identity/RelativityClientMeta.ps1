class RelativityClientMeta
{
    [String[]] $Unsupported
    [String[]] $ReadOnly

    RelativityClientMeta([String[]] $Unsupported, [String[]] $ReadOnly)
    {
        $this.Unsupported = $Unsupported
        $this.ReadOnly = $ReadOnly
    }
}