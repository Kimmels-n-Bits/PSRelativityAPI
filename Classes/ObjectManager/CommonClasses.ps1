#https://platform.relativity.com/Server2023/Content/BD_Object_Manager/Object_Manager_service.htm

#TODO Implement RelativityObjectTypeRef class
<#
    [Int32] $ArtifactTypeID
#>

#TODO Implement RelativityObjectTypeBase class
<#
    Inherit from RelativityObjectTypeRef
    [Int32] $ArtifactID
    [String] $Name
    [Guid[]] $Guids
#>

#TODO Implement RelativityFieldCategory enum
<#
    Generic = 0
    FullText = 1
    Identifier = 2
    Reflected = 3
    Comments = 4
    Relational = 5
    ProductionMarker = 6
    AutoCreate = 7
    FileSize = 8
    FolderName = 9
    FileInfo = 10
    ParentArtifact = 11
    MarkupSetMarker = 12
    GenericSystem = 13
    MultiReflected = 14
    Batch = 15
#>

#TODO Implemenet RelativityFieldType enum
<#
    Empty = -1
    FixedLengthText = 0
    WholeNumber = 1
    Date = 2
    YesNo = 3
    LongText = 4
    SingleChoice = 5
    Decimal = 6
    Currency = 7
    MultipleChoice = 8
    File = 9
    SingleObject = 10
    User = 11
    MultipleObject = 13
#>

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

#TODO Implement RelativityObjectQueryCondition class
enum RelativityObjectQueryConditionComparisonOperator
{
    Eq
    Ne
    Gt
    Ge
    Lt
    Le
    In
    MonthOf
    StartsWith
    EndsWith
    Like
    Contains
    Intersect
    IsSet
}

enum RelativityObjectQueryConditionKeyword
{
    SavedSearch
    View
    Object
    MultiObject
    Choice
    MultiChoice
    User
}

enum RelativityObjectQueryConditionMonthOf
{
    January = 1
    February = 2
    March = 3
    April = 4
    May = 5
    June = 6
    July = 7
    August = 8
    September = 9
    October = 10
    November = 11
    December = 12
}

enum RelativityObjectQueryConditionCombinationOperator
{
    And
    Or
}

class RelativityObjectQueryCondition
{
    [String] $Condition

    RelativityObjectQueryCondition (
        [Boolean] $Negated,
        [String] $Field,
        [RelativityObjectQueryConditionComparisonOperator] $ActiveOperator,
        [Nullable[RelativityObjectQueryConditionKeyword]] $ActiveKeyword,
        [Object] $Value
    )
    {
        $this.Condition = "("

        if ($Negated)
        {
            $this.Condition += "NOT "
        }

        $this.Condition += "'$($Field)' "

        switch ($ActiveOperator)
        {
            Eq { $this.Condition += "== " }
            Ne { $this.Condition += "<> " }
            Gt { $this.Condition += "> " }
            Ge { $this.Condition += ">= " }
            Lt { $this.Condition += "< " }
            Le { $this.Condition += "<= " }
            In { $this.Condition += "IN " }
            MonthOf
            {
                $this.Condition += "in MonthOf "
                [RelativityObjectQueryConditionMonthOf] $Value = $Value
            }
            StartsWith { $this.Condition += "STARTSWITH " }
            EndsWith { $this.Condition += "ENDSWITH " }
            Like { $this.Condition += "LIKE " }
            Contains { $this.Condition += "CONTAINS " }
            Intersect { $this.Condition += "INTERSECTS " }
            IsSet { $this.Condition += "ISSET" }
        }

        switch ($ActiveKeyword)
        {
            SavedSearch { $this.Condition += "SAVEDSEARCH " }
            View { $this.Condition += "VIEW " }
            Object { $this.Condition += "OBJECT " }
            MultiObject { $this.Condition += "MULTIOBJECT " }
            Choice { $this.Condition += "CHOICE " }
            MultiChoice { $this.Condition += "MULTICHOICE " }
            User { $this.Condition += "USER " }
        }

        $NonArrayKeywords = @(
            [RelativityObjectQueryConditionKeyword]::SavedSearch
            [RelativityObjectQueryConditionKeyword]::View
        )

        if (($ActiveOperator -eq [RelativityObjectQueryConditionComparisonOperator]::In -and
                $ActiveKeyword -notin $NonArrayKeywords) -or
                ($ActiveOperator -eq [RelativityObjectQueryConditionComparisonOperator]::Contains -and -not
                ($null -eq $ActiveKeyword)) -or
                ($ActiveOperator -eq [RelativityObjectQueryConditionComparisonOperator]::Intersect))
        {
            $this.Condition += "["

            switch ($true)
            {
                { $Value -is [Int32] } { $this.Condition += $Value.ToString() }
                { $Value -is [Int32[]] } { $this.Condition += ($Value | ForEach-Object { $_.ToString() }) -join ", " }
                { $Value -is [Decimal] } { $this.Condition += $Value.ToString() }
                { $Value -is [Decimal[]] } { $this.Condition += ($Value | ForEach-Object { $_.ToString() }) -join ", " }
                { $Value -is [String] } { $this.Condition += "'$($Value)'" }
                { $Value -is [String[]] } { $this.Condition += "'$($Value -join "', '")'" }
                { $Value -is [Guid] } { $this.Condition += $Value.ToString().ToUpper() }
                { $Value -is [Guid[]] } { $this.Condition += ($Value | ForEach-Object { $_.ToString().ToUpper() }) -join ", " }
            }

            $this.Condition += "]"
        }
        else
        {
            switch ($true)
            {
                { $Value -is [Int32] } { $this.Condition += $Value.ToString() }
                { $Value -is [DateTime] } { $this.Condition += "$($Value.ToString("yyyy-MM-ddTHH:mm:ss.ff"))Z" }
                { $Value -is [Boolean] } { $this.Condition += $Value.ToString().ToLower() }
                { $Value -is [Decimal] } { $this.Condition += $Value.ToString() }
                { $Value -is [RelativityObjectQueryConditionMonthOf] } { $this.Condition += $Value.ToString() }
                { $Value -is [String] } { $this.Condition += "'$($Value)'" }
                { $Value -is [Guid] } { $this.Condition += $Value.ToString().ToUpper() }
            }
        }

        $this.Condition += ")"
    }

    RelativityObjectQueryCondition (
        [RelativityObjectQueryCondition] $LeftCondition,
        [RelativityObjectQueryConditionCombinationOperator] $ActiveOperator,
        [Boolean] $Negated,
        [RelativityObjectQueryCondition] $RightCondition
    )
    {
        $this.Condition = "("
        $this.Condition += $LeftCondition.ToString()

        switch ($ActiveOperator)
        {
            And { $this.Condition += " AND " }
            Or { $this.Condition += " OR " }
        }

        if ($Negated)
        {
            $this.Condition += "NOT "
        }

        $this.Condition += $RightCondition.ToString()
        $this.Condition += ")"
    }

    [String] ToString()
    {
        return $this.Condition
    }
}

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