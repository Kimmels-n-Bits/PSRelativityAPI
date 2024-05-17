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

    RelativityObjectModelV1SharedModelsShortcut(
        [PSCustomObject] $ApiResponse
    )
    {
        [Collections.Generic.List[RelativityObjectModelV1SharedModelsModifierKey]] $_modifierKeys = @()
        $ApiResponse.ModifierKeys | ForEach-Object {
            # Validate Enum
            if ([Enum]::IsDefined([RelativityObjectModelV1SharedModelsModifierKey], $_)) {
                $_modifierKeys.Add([Enum]::Parse([RelativityObjectModelV1SharedModelsModifierKey], $_))
            } else {
                throw "Invalid enum [RelativityObjectModelV1SharedModelsModifierKey] = $_"
            }
        }

        $this.MainKey = $ApiResponse.MainKey
        $this.ModifierKeys = $_modifierKeys
    }
}