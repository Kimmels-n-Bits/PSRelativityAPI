class RelativityIdentityV1SharedMeta
{
    [Collections.Generic.List[String]] $ReadOnly
    [Collections.Generic.List[String]] $Unsupported

    RelativityIdentityV1SharedMeta()
    {
    }

    RelativityIdentityV1SharedMeta(
        [Collections.Generic.List[String]] $ReadOnly,
        [Collections.Generic.List[String]] $Unsupported
    )
    {
        $this.ReadOnly = $ReadOnly
        $this.Unsupported = $Unsupported
    }
}