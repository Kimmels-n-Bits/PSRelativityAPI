class RelativityObjectModelV1ChoiceModelsColor
{
    <#
        .SYNOPSIS
            
        .PARAMETER ID
            
        .PARAMETER ImageNameBase64
            
    #>
    [Int32] $ID
    [String] $Name

    RelativityObjectModelV1ChoiceModelsColor()
    {
    }

    RelativityObjectModelV1ChoiceModelsColor(
        [Int32] $ID,
        [String] $Name
    )
    {
        $this.ID = $ID
        $this.Name = $Name
    }
}