#https://platform.relativity.com/Server2023/Content/BD_Object_Manager/Object_Manager_service.htm#QueryforRelativityobjects
#TODO : Create RelativityObjectQueryRequestBase class
<#
    [RelativityObjectTypeBase] $ObjectType
    [RelativityObjectBase[]] $Fields
    [RelativityObjectQueryCondition] $Condition
    [Boolean] $LongTextBehavior
    [RelativityObjectQuerySort[]] $Sorts

#>

#TODO: Create RelativityObjectQueryRequest class
<#
    [RelativityObjectQueryRequestBase] $Request
    [Int32] $Start
    [Int32] $Length
#>