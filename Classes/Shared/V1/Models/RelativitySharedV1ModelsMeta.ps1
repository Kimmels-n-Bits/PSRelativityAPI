class RelativitySharedV1ModelsMeta
{
    <#
        .SYNOPSIS
            A collection of information about properties on a given object.
        .PARAMETER ReadOnly
            A list of properties on the given object that cannot be updated.
        .PARAMETER Unsupported
            A list of properties on the object that are not supported on the given object instance.
    #>
    [Collections.Generic.List[String]] $ReadOnly
    [Collections.Generic.List[String]] $Unsupported

    RelativitySharedV1ModelsMeta()
    {
    }

    RelativitySharedV1ModelsMeta(
        [Collections.Generic.List[String]] $ReadOnly,
        [Collections.Generic.List[String]] $Unsupported
    )
    {
        $this.ReadOnly = $ReadOnly
        $this.Unsupported = $Unsupported
    }

    RelativitySharedV1ModelsMeta(
        [PSCustomObject] $ApiResponse
    )
    {
        [Collections.Generic.List[String]] $_readOnly = @()
        $ApiResponse.ReadOnly | ForEach-Object {
            $_readOnly.Add($_)
        }

        [Collections.Generic.List[String]] $_unsupported = @()
        $ApiResponse.Unsupported | ForEach-Object {
            $_unsupported.Add($_)
        }
        
        $this.ReadOnly = $_readOnly
        $this.Unsupported = $_unsupported
    }
}