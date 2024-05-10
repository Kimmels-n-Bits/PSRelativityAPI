class RelativityObjectModelV1FieldModelsPaneIcon
{
    <#
        .SYNOPSIS
            FieldModels class to hold image data
        .PARAMETER FileName
            
        .PARAMETER ImageBase64
            
    #>
    [String] $FileName
    [String] $ImageBase64

    RelativityObjectModelV1FieldModelsPaneIcon()
    {
    }

    RelativityObjectModelV1FieldModelsPaneIcon(
        [String] $FileName,
        [String] $ImageBase64
    )
    {
        $this.FileName = $FileName
        $this.ImageBase64 = $ImageBase64
    }

    RelativityObjectModelV1FieldModelsPaneIcon(
        [PSCustomObject] $ApiResponse
    )
    {
        $this.FileName = $ApiResponse.FileName
        $this.ImageBase64 = $ApiResponse.ImageBase64
    }
}