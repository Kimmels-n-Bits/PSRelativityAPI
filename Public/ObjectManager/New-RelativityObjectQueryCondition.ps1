function New-RelativityObjectQueryCondition
{
    <#
    .SYNOPSIS
    Creates a new query condition for use in Relativity's ObjectManager API based on fields or combined conditions.

    .DESCRIPTION
    The New-RelativityObjectQueryCondition function allows for the creation of query conditions to filter data in
    Relativity's ObjectManager API. It supports constructing conditions based on field comparisons or the combination
    of other conditions. The function offers flexibility in specifying the type of comparison for field-based
    conditions and logical operators for combining conditions.

    .PARAMETER Field
    Specifies the field name on which the condition will be applied. This parameter is mandatory in the FieldAndValue
    parameter set.

    .PARAMETER Value
    Specifies the value to compare against the field. The type of the value must be one of the supported types: Int32,
    Int32[], DateTime, Boolean, Decimal, Decimal[], String, String[], Guid, or Guid[]. This parameter is used in the
    FieldAndValue parameter set.

    .PARAMETER LeftCondition
    Specifies the left-hand side condition when combining two conditions. This parameter is mandatory in the
    ConditionAndCondition parameter set.

    .PARAMETER RightCondition
    Specifies the right-hand side condition when combining two conditions. This parameter is mandatory in the
    ConditionAndCondition parameter set.

    .PARAMETER Not
    A switch parameter that negates the condition. This switch is optional and can be used in both parameter sets.

    .PARAMETER And
    A switch parameter that specifies the logical AND operator when combining two conditions. This switch is mandatory
    when combining conditions in the ConditionAndCondition parameter set.

    .PARAMETER Or
    A switch parameter that specifies the logical OR operator when combining two conditions. This switch is mandatory
    when combining conditions in the ConditionAndCondition parameter set.

    .PARAMETER Eq
    A switch parameter that specifies an equality comparison operator. This switch is used in the FieldAndValue
    parameter set.

    .PARAMETER Ne
    A switch parameter that specifies a non-equality comparison operator. This switch is used in the FieldAndValue
    parameter set.

    .PARAMETER Gt
    A switch parameter that specifies a greater-than comparison operator. This switch is used in the FieldAndValue
    parameter set.

    .PARAMETER Ge
    A switch parameter that specifies a greater-than-or-equal-to comparison operator. This switch is used in the
    FieldAndValue parameter set.

    .PARAMETER Lt
    A switch parameter that specifies a less-than comparison operator. This switch is used in the FieldAndValue
    parameter set.

    .PARAMETER Le
    A switch parameter that specifies a less-than-or-equal-to comparison operator. This switch is used in the
    FieldAndValue parameter set.

    .PARAMETER In
    A switch parameter that specifies that the field's value must be within a specified set. This switch is used in
    the FieldAndValue parameter set.

    .PARAMETER MonthOf
    A switch parameter that specifies a comparison to a specific month. This switch is used in the FieldAndValue
    parameter set.

    .PARAMETER StartsWith
    A switch parameter that specifies that the field's value must start with a specified string. This switch is used
    in the FieldAndValue parameter set.

    .PARAMETER EndsWith
    A switch parameter that specifies that the field's value must end with a specified string. This switch is used in
    the FieldAndValue parameter set.

    .PARAMETER Like
    A switch parameter that allows for text content searching. This switch is used in the FieldAndValue parameter set.

    .PARAMETER Contains
    A switch parameter that specifies that either a text field's value must contain the specified string or that a
    multiobject or multichoice field value must be within a specified set. This switch is used in the FieldAndValue
    parameter set.

    .PARAMETER Intersect
    A switch parameter used to specify that the field's value must intersect with a specified set. This switch is used
    in the FieldAndValue parameter set.

    .PARAMETER IsSet
    A switch parameter used to specify that the field must be populated. This switch is used in the FieldAndValue
    parameter set.

    .PARAMETER SavedSearch
    A switch parameter used to modify the query to return document objects that are returned by a given saved search.
    This switch is used in the FieldAndValue parameter set.

    .PARAMETER View
    A switch parameter used to modify the query to return objects that are returned by a given view. This switch is
    used in the FieldAndValue parameter set.

    .PARAMETER Object
    A switch parameter used to modify the query to explicitly search single-object type fields. This switch is used in
    the FieldAndValue parameter set.

    .PARAMETER MultiObject
    A switch parameter used to modify the query to explicitly search multi-object type fields. This switch is used in
    the FieldAndValue parameter set.

    .PARAMETER Choice
    A switch parameter used to modify the query to explicitly search single-choice type fields. This switch is used in
    the FieldAndValue parameter set.

    .PARAMETER MultiChoice used to modify the query to explicitly search multi-choice type fields. This switch is used
    in the FieldAndValue parameter set.

    .PARAMETER User
    A switch parameter used to modify the query to explicitly search user type fields. This switch is used in the
    FieldAndValue parameter set.

    .EXAMPLE
    $Condition = New-RelativityObjectQueryCondition -Field "ArtifactID" -Eq -Value 1234567
    Creates a condition that checks if the ArtifactID field is equal to 1234567.

    .EXAMPLE
    $Condition1 = New-RelativityObjectQueryCondition -Field "SentDate" -Ge -Value ([DateTime] "2021-01-01")
    $Condition2 = New-RelativityObjectQueryCondition -Field "SentDate" -Le -Value ([DateTime] "2021-12-31")
    $Combined = New-RelativityObjectQueryCondition -LeftCondition $Condition1 -RightCondition -And $Condition2
    Combines two conditions to check if the SentDate field falls within the year 2021 using a logical AND.

    .EXAMPLE
    $Condition = New-RelativityObjectQueryCondition -Field "Name" -BeginsWith -Value "John%"
    Creates a condition to find records where the Name field starts with "John".

    .EXAMPLE
    $Condition1 = New-RelativityObjectQueryCondition -Field "Status" -Eq -Value "Active"
    $Condition2 = New-RelativityObjectQueryCondition -Field "Role" -Eq -Value "Administrator"
    $Combined = New-RelativityObjectQueryCondition -LeftCondition $Condition1 -Or -Not -RightCondition $Condition2
    Creates a condition that checks if either the Status is not 'Active' or the Role is not 'Administrator'.
    #>
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
        try
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
                    (($KeywordValidOperators[$ActiveKeyword.ToString()] |
                                ForEach-Object { $_.ToString() }) -join ", ") + "."

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
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "Logging parameter values:"

            (Get-Command -Name $PSCmdlet.MyInvocation.InvocationName).Parameters | ForEach-Object {
                $_.Values | ForEach-Object {
                    $Parameter = Get-Variable -Name $_.Name -ErrorAction SilentlyContinue

                    if ($null -ne $Parameter)
                    {
                        Write-Verbose "$($Parameter.Name): $($Parameter.Value)"
                    }
                }
            }

            throw
        }
    }
    End
    {
        Write-Verbose "Completed New-RelativityObjectQueryCondtion"
    }
}