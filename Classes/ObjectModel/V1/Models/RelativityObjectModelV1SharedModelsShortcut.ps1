class RelativityObjectModelV1SharedModelsShortcut
{
    <#
        .SYNOPSIS
            Shortcut class
        .PARAMETER FriendlyName
            
        .PARAMETER SourceName
            
    #>
    [String] $MainKey
    [Collections.Generic.List[RelativityObjectModelV1SharedModelsModifierKey]] $ModifierKeys

    RelativityObjectModelV1SharedModelsShortcut()
    {
    }

    RelativityObjectModelV1SharedModelsShortcut(
        [String] $MainKey,
        [Collections.Generic.List[RelativityObjectModelV1SharedModelsModifierKey]] $ModifierKeys
    )
    {
        $this.MainKey = $MainKey
        $this.ModifierKeys = $ModifierKeys
    }
}