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
function New-RelativityObjectQueryCondition
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ParameterSetName = "FieldAndValue")]
        [ValidateNotNullOrEmpty()]
        [String] $Field,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [ValidateScript({
                $AllowedTypes = @(
                    [Int32],
                    [Int32[]],
                    [DateTime],
                    [Boolean],
                    [Decimal],
                    [Decimal[]]
                    [String],
                    [String[]],
                    [Guid],
                    [Guid[]]
                )
                [Boolean] $IsValidType = $false

                if (-not ($_ -is [Array] -and $_.GetType() -eq [Object[]]))
                {
                    foreach ($Type in $AllowedTypes)
                    {
                        if ($_ -is $Type)
                        {
                            $IsValidType = $true
                            break
                        }
                    }
                }

                if (-not $IsValidType)
                {
                    throw "Value must be one of the following types: Int32, Int32[], DateTime, Boolean, Decimal, " +
                    "String, String[], Guid, Guid[]. If you are certain the value matches one of these types, try" +
                    " explicitly casting the value to that type, e.g., [Int32[]] `$Value = @(42, 53)."
                }

                return $IsValidType
            })]
        [Object] $Value,
        [Parameter(Mandatory = $true, ParameterSetName = "ConditionAndCondition")]
        [ValidateNotNullOrEmpty()]
        [RelativityObjectQueryCondition] $LeftCondition,
        [Parameter(Mandatory = $true, ParameterSetName = "ConditionAndCondition")]
        [ValidateNotNullOrEmpty()]
        [RelativityObjectQueryCondition] $RightCondition,
        [Parameter(Mandatory = $false, ParameterSetName = "ConditionAndCondition")]
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $Not,
        [Parameter(Mandatory = $false, ParameterSetName = "ConditionAndCondition")]
        [Switch] $And,
        [Parameter(Mandatory = $false, ParameterSetName = "ConditionAndCondition")]
        [Switch] $Or,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $Eq,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $Ne,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $Gt,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $Ge,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $Lt,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $Le,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $In,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $MonthOf,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $StartsWith,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $EndsWith,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $Like,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $Contains,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $Intersect,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $IsSet,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $SavedSearch,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $View,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $Object,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $MultiObject,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $Choice,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $MultiChoice,
        [Parameter(Mandatory = $false, ParameterSetName = "FieldAndValue")]
        [Switch] $User
    )

    Begin
    {
        Write-Verbose "Starting New-RelativityObjectQueryCondition"

        if ($PSCmdlet.ParameterSetName -eq "FieldAndValue")
        {
            # Validate that one comparison operator switch has been specified.
            [Boolean[]] $Operators = @(
                $Eq,
                $Ne,
                $Gt,
                $Ge,
                $Lt,
                $Le,
                $In,
                $MonthOf,
                $StartsWith,
                $EndsWith,
                $Like,
                $Contains,
                $Intersect,
                $IsSet
            )

            [Int32] $TrueOperatorCount = ($Operators | Where-Object { $_ }).Count

            if ($TrueOperatorCount -ne 1)
            {
                throw "Exactly one comparison operator switch must be specified when using the Field and Value " +
                "parameter set."
            }

            # Validate that zero or one keyword switch has been specified.
            [Boolean[]] $Keywords = @(
                $SavedSearch,
                $View,
                $Object,
                $MultiObject,
                $Choice,
                $MultiChoice,
                $User
            )

            [Int32] $TrueKeywordCount = ($Keywords | Where-Object { $_ }).Count

            if ($TrueKeywordCount -gt 1)
            {
                throw "Zero or one keyword switch must be specified when using the Field and Value parameter set."
            }
        }

        if ($PSCmdlet.ParameterSetName -eq "ConditionAndCondition")
        {
            # Validate that one combination operator switch has been specified.
            [Boolean[]] $Operators = @(
                $And,
                $Or
            )

            [Int32] $TrueOperatorCount = ($Operators | Where-Object { $_ }).Count

            if ($TrueOperatorCount -ne 1)
            {
                throw "Exactly one combination operator switch must be specified when using the Condition and " +
                "Condition parameter set."
            }
        }
    }
    Process
    {
        $QueryCondition = $null

        if ($PSCmdlet.ParameterSetName -eq "FieldAndValue")
        {
            # Map the selected comparison operator to an enum we can feed to the RelativityObjectQueryCondition
            # constructor.
            Write-Verbose "Identifying active operator."

            $OperatorMap = @{
                Eq = [RelativityObjectQueryConditionComparisonOperator]::Eq
                Ne = [RelativityObjectQueryConditionComparisonOperator]::Ne
                Gt = [RelativityObjectQueryConditionComparisonOperator]::Gt
                Ge = [RelativityObjectQueryConditionComparisonOperator]::Ge
                Lt = [RelativityObjectQueryConditionComparisonOperator]::Lt
                Le = [RelativityObjectQueryConditionComparisonOperator]::Le
                In = [RelativityObjectQueryConditionComparisonOperator]::In
                MonthOf = [RelativityObjectQueryConditionComparisonOperator]::MonthOf
                StartsWith = [RelativityObjectQueryConditionComparisonOperator]::StartsWith
                EndsWith = [RelativityObjectQueryConditionComparisonOperator]::EndsWith
                Like = [RelativityObjectQueryConditionComparisonOperator]::Like
                Contains = [RelativityObjectQueryConditionComparisonOperator]::Contains
                Intersect = [RelativityObjectQueryConditionComparisonOperator]::Intersect
                IsSet = [RelativityObjectQueryConditionComparisonOperator]::IsSet
            }

            $ActiveOperator = $null
            foreach ($Key in $OperatorMap.Keys)
            {
                if ((Get-Variable -Name $Key -ValueOnly))
                {
                    [RelativityObjectQueryConditionComparisonOperator] $ActiveOperator = $OperatorMap[$Key]
                    break
                }
            }

            Write-Verbose "Active operator == '$($ActiveOperator)'."

            # Map the selected keyword to an enum we can feed to the RelativityObjectQueryCondition constructor.
            Write-Verbose "Identifying active keyword."

            $KeywordMap = @{
                SavedSearch = [RelativityObjectQueryConditionKeyword]::SavedSearch
                View = [RelativityObjectQueryConditionKeyword]::View
                Object = [RelativityObjectQueryConditionKeyword]::Object
                MultiObject = [RelativityObjectQueryConditionKeyword]::MultiObject
                Choice = [RelativityObjectQueryConditionKeyword]::Choice
                MultiChoice = [RelativityObjectQueryConditionKeyword]::MultiChoice
                User = [RelativityObjectQueryConditionKeyword]::User
            }

            $ActiveKeyword = $null
            foreach ($Key in $KeywordMap.Keys)
            {
                if ((Get-Variable -Name $Key -ValueOnly))
                {
                    [RelativityObjectQueryConditionKeyword] $ActiveKeyword = $KeywordMap[$Key]
                    break
                }
            }

            if ($null -eq $ActiveKeyword)
            {
                Write-Verbose "Active keyword == null."
            }
            else
            {
                Write-Verbose "Active keyword == '$($ActiveKeyword)'."

                # Map each keyword to the valid comparison operators associated with it.
                $VerboseMessage = "Validating '$($ActiveOperator)' is a valid comparison operator for keyword " +
                "'$($ActiveKeyword)'."
                Write-Verbose $VerboseMessage

                $KeywordValidOperators = @{
                    SavedSearch = @([RelativityObjectQueryConditionComparisonOperator]::In)
                    View = @([RelativityObjectQueryConditionComparisonOperator]::In)
                    Object = @(
                        [RelativityObjectQueryConditionComparisonOperator]::Eq,
                        [RelativityObjectQueryConditionComparisonOperator]::Ne,
                        [RelativityObjectQueryConditionComparisonOperator]::In
                    )
                    MultiObject = @(
                        [RelativityObjectQueryConditionComparisonOperator]::Contains,
                        [RelativityObjectQueryConditionComparisonOperator]::Intersect
                    )
                    Choice = @(
                        [RelativityObjectQueryConditionComparisonOperator]::Eq,
                        [RelativityObjectQueryConditionComparisonOperator]::Ne,
                        [RelativityObjectQueryConditionComparisonOperator]::In
                    )
                    MultiChoice = @(
                        [RelativityObjectQueryConditionComparisonOperator]::Contains,
                        [RelativityObjectQueryConditionComparisonOperator]::Intersect
                    )
                    User = @(
                        [RelativityObjectQueryConditionComparisonOperator]::Eq,
                        [RelativityObjectQueryConditionComparisonOperator]::Ne,
                        [RelativityObjectQueryConditionComparisonOperator]::Like
                    )
                }

                # Validate the comparison operator associated with the provided keyword.
                [Boolean] $IsValidOperatorForKeyword = $false
                [Boolean] $IsValidOperatorForKeyword = ($KeywordValidOperators[$ActiveKeyword.ToString()] |
                        Where-Object { $_ -eq $ActiveOperator }).Count

                if (-not $IsValidOperatorForKeyword)
                {
                    [String] $ErrorString = ""
                    $ErrorString += "Comparison operator must be one of the following for the selected keyword: " +
                    (($KeywordValidOperators[$ActiveKeyword.ToString()] | ForEach-Object { $_.ToString() }) -join ", ") + "."

                    throw $ErrorString
                }

                Write-Verbose "'$($ActiveOperator)' is a valid comparison operator for the selected keyword."
            }

            # Map each comparison operator to the valid types associated with it.
            $VerboseMessage = "Validating '$($Value.GetType().Name)' is a valid type for operator " +
            "'$($ActiveOperator)'."
            Write-Verbose $VerboseMessage

            $OperatorValidTypes = @{
                Eq = @([Int32], [DateTime], [Boolean], [Decimal], [String], [Guid])
                Ne = @([Int32], [DateTime], [Boolean], [Decimal], [String], [Guid])
                Gt = @([Int32], [DateTime], [Decimal], [String])
                Ge = @([Int32], [DateTime], [Decimal], [String])
                Lt = @([Int32], [DateTime], [Decimal], [String])
                Le = @([Int32], [DateTime], [Decimal], [String])
                In = @([Int32], [Int32[]], [Decimal], [Decimal[]], [String], [String[]], [Guid], [Guid[]])
                MonthOf = @([Int32], [String])
                StartsWith = @([String])
                EndsWith = @([String])
                Like = @([String])
                Contains = @([Int32], [Int32[]], [String], [Guid], [Guid[]])
                Intersect = @([Int32], [Int32[]])
            }

            # Validate that the type associated with the provided value is an approved type for the operator.
            [Boolean] $IsValidTypeForOperator = $false

            if ($ActiveOperator -ne [RelativityObjectQueryConditionComparisonOperator]::IsSet)
            {
                [Boolean] $IsValidTypeForOperator = ($OperatorValidTypes[$ActiveOperator.ToString()] |
                        Where-Object { $Value.GetType() -eq $_ }).Count
            }
            elseif ($null -eq $Value)
            {
                $IsValidTypeForOperator = $true
            }

            if (-not $IsValidTypeForOperator)
            {
                [String] $ErrorString = ""
                if ($ActiveOperator -ne [RelativityObjectQueryConditionComparisonOperator]::IsSet)
                {
                    $ErrorString += "Value must be one of the following types for the selected comparison operator: " +
                    (($OperatorValidTypes[$ActiveOperator.ToString()] | ForEach-Object { $_ }) -join ", ") + "."
                }
                else
                {
                    $ErrorString += "Value must be null for the selected comparison operator."
                }

                throw $ErrorString
            }

            Write-Verbose "'$($Value.GetType().Name)' is a valid type for the selected operator."

            if ($null -ne $ActiveKeyword)
            {
                # Map each keyword to the valid types associated with it.
                $VerboseMessage = "Validating '$($Value.GetType().Name)' is a valid type for keyword " +
                "'$($ActiveKeyword)'."
                Write-Verbose $VerboseMessage

                $KeywordValidTypes = @{
                    SavedSearch = @([Int32])
                    View = @([Int32])
                    Object = @([Int32], [Int32[]])
                    MultiObject = @([Int32], [Int32[]])
                    Choice = @([Int32], [Int32[]], [Guid], [Guid[]])
                    MultiChoice = @([Int32], [Int32[]], [Guid], [Guid[]])
                    User = @([String])
                }

                # Validate that the type associated with the provided value is an approved type for the keyword.
                [Boolean] $IsValidTypeForKeyword = $false

                if ($null -eq $ActiveKeyword)
                {
                    $IsValidTypeForKeyword = $true
                }
                else
                {
                    [Boolean] $IsValidTypeForKeyword = ($KeywordValidTypes[$ActiveKeyword.ToString()] |
                            Where-Object { $Value.GetType() -eq $_ }).Count
                }

                if (-not $IsValidTypeForKeyword)
                {
                    [String] $ErrorString = ""
                    $ErrorString += "Value must be one of the following types for the selected keyword: " +
                    (($KeywordValidTypes[$ActiveKeyword.ToString()] | ForEach-Object { $_ }) -join ", ") + "."

                    throw $ErrorString
                }

                Write-Verbose "'$($Value.GetType().Name)' is a valid type for the selected keyword."

                # Map each keyword to the valid field names associated with it.
                $VerboseMessage = "Validating '$($Field)' is a valid field name for keyword " +
                "'$($ActiveKeyword)'."
                Write-Verbose $VerboseMessage

                $KeywordValidFields = @{
                    SavedSearch = @("ArtifactID")
                    View = @("ArtifactID")
                }

                # Validate that the field name provided is an approved field name for the keyword.
                [Boolean] $IsValidFieldForKeyword = $false

                if ($null -eq $ActiveKeyword -or -not ($KeywordValidFields.ContainsKey($ActiveKeyword.ToString())))
                {
                    $IsValidFieldForKeyword = $true
                }
                else
                {
                    [Boolean] $IsValidFieldForKeyword = ($KeywordValidFields[$ActiveKeyword.ToString()] |
                            Where-Object { $Field -eq $_ }).Count
                }

                if (-not $IsValidFieldForKeyword)
                {
                    [String] $ErrorString = ""
                    $ErrorString += "Field name must be one of the following for the selected keyword: " +
                    (($KeywordValidFields[$ActiveKeyword.ToString()] | ForEach-Object { $_ }) -join ", ") + "."

                    throw $ErrorString
                }

                Write-Verbose "'$($Field)' is a valid field name for the selected keyword."
            }

            #Map each operator to the valid values associated with it.
            $VerboseMessage = "Validating Value is valid for operator '$($ActiveOperator)'."
            Write-Verbose $VerboseMessage

            $OperatorValidValues = @{
                MonthOf = @(
                    [RelativityObjectQueryConditionMonthOf]::January,
                    [RelativityObjectQueryConditionMonthOf]::February,
                    [RelativityObjectQueryConditionMonthOf]::March,
                    [RelativityObjectQueryConditionMonthOf]::April,
                    [RelativityObjectQueryConditionMonthOf]::May,
                    [RelativityObjectQueryConditionMonthOf]::June,
                    [RelativityObjectQueryConditionMonthOf]::July,
                    [RelativityObjectQueryConditionMonthOf]::August,
                    [RelativityObjectQueryConditionMonthOf]::September,
                    [RelativityObjectQueryConditionMonthOf]::October,
                    [RelativityObjectQueryConditionMonthOf]::November,
                    [RelativityObjectQueryConditionMonthOf]::December
                )
            }

            # Validate that the value provided is an approved value for the operator.
            [Boolean] $IsValidValueForOperator = $false

            if (-not $OperatorValidValues.ContainsKey($ActiveOperator.ToString()))
            {
                $IsValidValueForOperator = $true
            }
            else
            {
                [Boolean] $IsValidValueForOperator = ($OperatorValidValues[$ActiveOperator.ToString()] |
                        Where-Object { $Value -eq $_ }).Count
            }

            if (-not $IsValidValueForOperator)
            {
                [String] $ErrorString = ""
                $ErrorString += "Value must be one of the following for the selected operator: " +
                (($OperatorValidValues[$ActiveOperator.ToString()] | ForEach-Object { $_ }) -join ", ") + "."

                throw $ErrorString
            }

            Write-Verbose "Value is valid for the selected operator."

            # Validation checks are passed, construct the RelativityObjectQueryCondition
            $QueryCondition = [RelativityObjectQueryCondition]::New(
                $Not,
                $Field,
                $ActiveOperator,
                $ActiveKeyword,
                $Value
            )
        }
        elseif ($PSCmdlet.ParameterSetName -eq "ConditionAndCondition")
        {
            # Map the selected combination operator to an enum we can feed to the RelativityObjectQueryCondition
            # constructor.
            $OperatorMap = @{
                And = [RelativityObjectQueryConditionCombinationOperator]::And
                Or = [RelativityObjectQueryConditionCombinationOperator]::Or
            }

            $ActiveOperator = $null
            foreach ($Key in $OperatorMap.Keys)
            {
                if ((Get-Variable -Name $Key -ValueOnly) -eq $true)
                {
                    [RelativityObjectQueryConditionCombinationOperator] $ActiveOperator = $OperatorMap[$Key]
                    break
                }
            }

            $QueryCondition = [RelativityObjectQueryCondition]::New(
                $LeftCondition,
                $ActiveOperator,
                $Not,
                $RightCondition
            )
        }

        return $QueryCondition
    }
    End
    {
        Write-Verbose "Completed New-RelativityObjectQueryCondtion"
    }
}