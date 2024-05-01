#https://platform.relativity.com/Server2023/Content/BD_Object_Manager/Object_Manager_service.htm

#TODO Implement RelativityField class
<#
    Inherit from RelativityObjectBase
    [RelativityFieldCategory] $FieldCategory
    [RelativityFieldType] $FieldType
    [Int32] $ViewFieldID

#>

#TODO Implement RelativityFile class
<#
    [RelativityObjectRef] $Field
    [RelativityObjectRef] $ObjectRef
    [String] $FileName

    Note that there may be other "RelativityFile" types in the API and so this may need to be renamed.
#>

#TODO Implement RelativityFieldValue class
<#
    [Object] $Value

    Add validation to ensure $Value is a String, a DateTime, a Decimal, a RelativityFile object, an array
    of RelativityObjectRef, a single RelativityObjectRef, an Int32, a Boolean, an array of RelativityObjectBase,
    or a single RelativityObjectBase.

    The ToHashValue() method for this class should properly return either the value directly or call
    the appropriate ToHashValue() methods of custom objects.

    I imagine this would be used by things other than the ObjectManager API. If so, move this to the
    CommonClasses.ps1 at the root of the "Classes" folder.
#>

#TODO Implement RelativityFieldValueList class
<#
    [RelativityFieldValue[]] $Values
#>

#TODO Implement RelativityFieldValuePair class
<#
    [RelativityObjectRef] $Field
    [RelativityFieldValue] $Value

    By inheriting from [RelativityObjectRef] we can support RelativityObjectRef or RelativityField
    as objects for this. In order to ensure we don't allow other object types that inherit from
    RelativityObjectRef we'll want to add validation. Something like the below should work if added
    to the constructor:

    $AllowedTypes = @([RelativityObjectRef], [RelativityField])
    if ($AllowedTypes -contains $Field.GetType())
    {
        $this.Field = $Field
    }
    else
    {
        throw some kind of exception
    }
#>

#TODO Implement RelativityEventHandlerStatus class
<#
    [Boolean] $Success
    [String] $Message
#>

#TODO: Implement RelativityObjectIdentificationCriteria class
<#
    [RelativityObjectTypeRef] $ObjectType
    [RelativityObjectQueryCondition] $Condition
#>

#TODO Implement RelativityObjectMassRequestByCriteriaBase class
<#
    [RelativityObjectIdentificationCriteria] $ObjectIdentificationCriteria
#>

#TODO Implement RelativityObjectMassRequestByObjectBase class
<#
    [RelativityObjectBase[]] $Objects
#>

#TODO: Implement RelativityObjectDeletedItem class
<#
    [String] $ObjectTypeName
    [String] $Action
    [Int32] $Count
    [String] $Connection
#>

#TODO: Implement RelativityObjectDeletedItemReport class
<#
    [RelativityObjectDeletedItem[]] $DeletedItems
#>

#TODO: Implement RelativityObjectQueryResponseBase class
<#
    [Int32] $TotalCount
    [Int32] $CurrentStartIndex
    [Int32] $ResultCount
    [RelativityObjectTypeBase] $ObjectType
#>