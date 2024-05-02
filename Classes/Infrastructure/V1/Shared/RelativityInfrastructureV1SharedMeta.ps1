class RelativityInfrastructureV1SharedMeta
{
    <#
        .SYNOPSIS
            A collection of information about fields on a given static object that may have restrictions.
        .PARAMETER ReadOnly
            A list of fields on the given static object that can't be updated.
        .PARAMETER Unsupported
            A list of fields on the static object that are not supported on the given object instance.
    #>
    [Collections.Generic.List[String]] $ReadOnly
    [Collections.Generic.List[String]] $Unsupported

    RelativityInfrastructureV1SharedMeta()
    {
    }

    RelativityInfrastructureV1SharedMeta(
        [Collections.Generic.List[String]] $ReadOnly,
        [Collections.Generic.List[String]] $Unsupported
    )
    {
        $this.ReadOnly = $ReadOnly
        $this.Unsupported = $Unsupported
    }
}