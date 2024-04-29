#https://platform.relativity.com/Server2023/Content/BD_Object_Manager/Object_Manager_service.htm#UpdatefieldsonaDocumentobjectorRDO

#TODO: Implement RelativityObjectUpdateCallingContext
<#
    [RelativityObjectRef] $Layout
#>

#TODO: Implement RelativityObjectUpdateOperationOptions
<#
    [String] $UpdateBehavior
    [RelativityObjectUpdateCallingContext] $CallingContext
#>

#TODO: Implement RelativityObjectUpdateRequestBase class
<#
    [RelativityObjectRef] $Object
    [RelativityFieldValuePair[]] $FieldValues

    Note the API call for updating a File field doesn't appear to fit in the FieldValuePair structure per the API
    documentation but this may just be incorrect documentation. Test and confirm.

    Note the API call for this breaks the format of prior work by having two top-level entries, "Request" and
    "OperationOptions". May need to refactor - instead of assembling a $Request variable in the various Get-Request
    functions we'll need to do something like a ToRequestBody() method in each Request class that assembles
    the request in the appropriate JSON format.
#>

#TODO: Implement RelativityObjectUpdateRequest class
<#
    [RelativityObjectUpdateRequestBase] $Request
    [RelativityObjectUpdateOperationOptions] $OperationOptions
#>