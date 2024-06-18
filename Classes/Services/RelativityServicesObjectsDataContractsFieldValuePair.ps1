class RelativityServicesObjectsDataContractsFieldValuePair
{
    <#
        .SYNOPSIS
            Part of a QueryResult object.

        .PARAMETER Field
            none
        .PARAMETER Value
            none
    #>
    [RelativityServicesObjectsDataContractsField] $Field
    [PSCustomObject] $Value

    
    RelativityServicesObjectsDataContractsFieldValuePair()
    {
    }

    RelativityServicesObjectsDataContractsFieldValuePair(
        [RelativityServicesObjectsDataContractsField] $Field,
        [PSCustomObject] $Value 
    )
    {
        $this.Field = $Field
        $this.Value = $Value
    }

    RelativityServicesObjectsDataContractsFieldValuePair([PSCustomObject] $FieldValuePair)
    {
        $this.Field = [RelativityServicesObjectsDataContractsField]::New($FieldValuePair.Field)
        $this.Value = $FieldValuePair.Value
    }
}