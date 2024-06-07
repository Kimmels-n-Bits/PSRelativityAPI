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

    RelativityObjectModelV1ChoiceModelsColor(
        [PSCustomObject] $ApiResponse
    )
    {
        $this.ID = $ApiResponse.ID
        $this.Name = $ApiResponse.Name
    }
}