class RelativityObjectModelV1FieldModelsFieldSource
{
    <#
        .SYNOPSIS
            FieldSource class
        .PARAMETER FriendlyName
            
        .PARAMETER SourceName
            
    #>
    [String] $FriendlyName
    [String] $SourceName

    RelativityObjectModelV1FieldModelsFieldSource()
    {
    }

    RelativityObjectModelV1FieldModelsFieldSource(
        [String] $FriendlyName,
        [String] $SourceName
    )
    {
        $this.FriendlyName = $FriendlyName
        $this.SourceName = $SourceName
    }

    RelativityObjectModelV1FieldModelsFieldSource(
        [PSCustomObject] $ApiResponse
    )
    {
        $this.FriendlyName = $ApiResponse.FriendlyName
        $this.SourceName = $ApiResponse.SourceName
    }
}