#https://platform.relativity.com/Server2023/Content/BD_Object_Manager/Object_Manager_service.htm#MassupdateDocumentobjectsorRDOs

#TODO: Implement RelativityObjectValue class
<#
    [RelativityObjectRef] $Object
    [RelativityObjectFieldValue[]] $Values
#>

#TODO: Implement RelativityObjcetMassUpdateRequestPerObject class
<#
    [RelativityObjectRef[]] $Fields
    [RelativityObjectValue[]] $ObjectValues

    Note this API call breaks the previous convention of having all requests wrapped in a Request {}
    JSON object and instead uses either a "MassRequestByCriteria", "MassRequestByObjectIdentifiers", or
    "MassRequestPerObjects" JSON object. May need to refactor,
    instead of assembling a $Request variable in the various Get-Request functions we'll need to do something
    like a ToRequestBody() method in each Request class that assembles the request in the appropriate
    JSON format.
#>