#https://platform.relativity.com/Server2023/Content/REST_API/Resource_Tasks/Querying_for_resources.htm#Syntaxforqueryconditions
#TODO: Implement New-RelativityObjectQueryCondition
<#
    This one is going to be complex, with multiple mutually exclusive parameters and extensive validation.

    Parameters:
    [RelativityObjectQueryCondition] $Condition #If a condition passed don't allow the "FieldName" parameter.
    [String] $FieldName #If a fieldname is passed don't allow the "Condition" parameter
    [Object] $Value #Must support all data types referenced below, in specific circumstances. Must also support the RelativityObjectQueryCondition object but only if $Condition is also passed in.

    #Combination Switches. These are mutually exclusive and $Condition should be passed in as a parameter instead of $FieldName
    [Switch] $And #Combines $Condition with the new RelativityObjectQueryCondition in the $Value parameter. Example: "(('Foo' == 1) AND ('Bar' IN ["String1", "String2"]))"
    [Switch] $Or #Combines $Condition with the new RelativityObjectQueryCondition in the $Value parameter. Example: "(('Foo' == 1) OR ('Bar' IN ["String1", "String2"]))"

    #Negation Switch
    [Switch] $Not # Prefixes condition with NOT. Example: "NOT 'Foo' == {Value}"

    #Comparison Switches. These are all mutually exclusive with each other. Use Parameter Sets?
    #Below comments define the type and name, then a comment showing how we'll interpret it in our condition string
    #followed by what Types each comparison needs to support.
    [Switch] $Eq # == #Support Int32, DateTime, Boolean, Decimal, String
    [Switch] $Ne # <> #Support Int32, DateTime, Boolean, Decimal, String
    [Switch] $Gt # > #Support Int32, DateTime, Decimal, String
    [Switch] $Ge # >= #Support Int32, DateTime, Decimal, String
    [Switch] $Lt # < #Support Int32, DateTime, Decimal, String
    [Switch] $Le # <= #Support Int32, DateTime, Decimal, String
    [Switch] $In # IN [] #Support Int32, Int32[], Decimal, Decimal[], String, String[]. Support Guid, Guid[] values when combined with the -Choice switch
    [Switch] $MonthOf # in MonthOf #Support Int32 of 1 through 12 or String of January through December
    [Switch] $StartsWith # STARTSWITH #Support String
    [Switch] $EndsWith # ENDSWITH #Support String
    [Switch] $Like # LIKE #Support String
    [Switch] $Contains # CONTAINS #Support String unless accompanied by the -MultiObject switch in which support Int32, Int32[]
    [Switch] $Intersect # INTERSECT #Support Int32, Int32[]
    [Switch] $IsSet # ISSET

    #Keyword Switches. These are all mutually exclusive with each other and must be accompanied by
    #one of the supported comparison switches.
    [Switch] $SavedSearch # Combine with the $In parameter and support only Int32 and an 'ArtifactID' field name. Should end up being "('ArtifactID' IN SAVEDSEARCH {Int32})"
    [Switch] $View # Combine with the $In parameter and support only Int32 and an 'ArtifactID' field name. Should end up being "('ArtifactID' IN VIEW {Int32})"
    [Switch] $Object #Combine with the $Eq, $Ne, or $In parameters and support only Int32 values. Example: "('Foo' == OBJECT {Int32})"
    [Switch] $MultiObject #Combine with the $Contains or $Intersect parameters and support only Int32 or Int32[] values. Example: "('Foo' CONTAINS MULTIOBJECT [{Int32}, {Int32}])"
    [Switch] $Choice #Combine with the $Eq, $Ne, or $In parameters and support either Int32, Int32[], Guid, or Guid[] values. Example: "('Foo' IN CHOICE [{Guid}, {Guid}])"
    [Switch] $MultiChoice #Combine with the $Contains or $Intersect parameters and support Int32, Int32[], Guid, or Guid[] values. Example: "('Foo' INTERSECTS MULTICHOICE [{Int32}, {Guid}])"
    [Switch] $User #Combine with the $Eq, $Ne, $Like parameters and support only String values. Example: "('Foo' LIKE USER 'UserName')"

    #The end result of all of this should be a RelativityObjectQueryCondition and you should be able to call this multiple times with nested RelativityObjectQueryCondition inputs
    #for truly complex search criteria.

    #An example of how this could be used is below:
    $Condition1 = New-RelativityObjectQueryCondition -FieldName "Field1" -In -Object -Value @(1234567, 2345678)
    $Condition2 = New-RelativityObjectQueryCondition -FieldName "Field2" -Not -Eq -Value "IgnoreMe"
    $Condition3 = New-RelativityObjectQueryCondition -FieldName "Field3" -Ne -Choice -Value 3456789
    $CombinedCondition1And2 = New-RelativityObjectQueryCondition -Condition $Condition1 -And -Value $Condition2
    $CompleteCombinedCondition = New-RelativityObjectQueryCondition -Condition $CombinedCondition1And2 -Or -Value $Condition3

    #This results in the final RelativityObjectQueryCondition object value below:
    ((('Field1' IN OBJECT [1234567, 2345678]) AND (NOT 'Field2' == "IgnoreMe")) OR ('Field3' <> CHOICE 3456789))
#>