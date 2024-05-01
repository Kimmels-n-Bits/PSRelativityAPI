#https://platform.relativity.com/Server2023/Content/BD_Object_Manager/Object_Manager_service.htm#QueryforRelativityobjects
#TODO: Implement RelativityObjectQuerySlimObject class
<#
    [Int32] $ArtifactID
    [RelativityFieldValue[]] $Values
#>

#TODO: Implement RelativityObjectQueryResponse class
<#
    Inherit from RelativityObjectQueryResponseBase
    [RelativityObjectQuerySlimObject[]] $Objects
    [RelativityObjectField[]] $Fields
#>