#https://platform.relativity.com/Server2023/Content/BD_Object_Manager/Object_Manager_service.htm#MasscreateRDOs
#TODO Implement RelativityObjectMassCreateRequest class
<#
    [RelativityObjectRef] $ParentObject
    [RelativityObjectTypeRef] $ObjectType
    [RelativityObjectRef[]] $Fields
    [RelativityFieldValueList[]] $ValueLists

    Note this API call breaks the previous convention of having all requests wrapped in a Request {}
    JSON object and instead uses a "MassRequest" JSON object. May need to refactor,
    instead of assembling a $Request variable in the various Get-Request functions we'll need to do something
    like a ToRequestBody() method in each Request class that assembles the request in the appropriate
    JSON format.
#>