function Get-RelativityObject
{
    Param
    (
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ActiveArtifactID,
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [RelativityObjectQueryCondition] $Condition,
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ExecutingSavedSearchID,
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ExecutingViewID,
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                $AllowedTypes = @(
                    [Int32],
                    [String],
                    [Guid]
                )

                function Confirm-ValidType
                {
                    Param
                    (
                        [Parameter(Mandatory = $true)]
                        [Object] $Item
                    )

                    foreach ($Type in $AllowedTypes)
                    {
                        if ($Item -is $Type)
                        {
                            return $true
                        }
                    }

                    return $false
                }

                [Boolean] $IsValidType = $false

                if ($_ -is [System.Collections.IEnumerable] -and ($_ -isnot [String]))
                {
                    $IsValidType = $true
                    foreach ($Item in $_)
                    {
                        if (-not (Confirm-ValidType -Item $Item))
                        {
                            $IsValidType = $false
                            break
                        }
                    }
                }
                else
                {
                    $IsValidType = Confirm-ValidType -Item $_
                }

                if (-not $IsValidType)
                {
                    throw "Fields must be one of the following types: Int32, String, Guid or an IEnumerable " +
                    "containing only objects of those types. If you are certain the value matches one of " +
                    "those types, try explicitly casting the value to that type, e.g., [Int32[]] `$Fields " +
                    "= @(42, 53)."
                }

                return $IsValidType
            })]
        [Object] $Fields = [String] "*",
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [Boolean] $IncludeIDWindow,
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [Boolean] $IncludeNameInQueryResult,
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [Boolean] $IsAdhocQuery,
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [RelativityObjectManagerV1ModelsLongTextBehavior] $LongTextBehavior = 0,
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $MaxCharactersForLongTextValues,
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [ValidateScript({
                $AllowedTypes = @(
                    [Int32],
                    [String],
                    [Guid]
                )
                [Boolean] $IsValidType = $false

                foreach ($Type in $AllowedTypes)
                {
                    if ($_ -is $Type)
                    {
                        $IsValidType = $true
                        break
                    }
                }

                if (-not $IsValidType)
                {
                    throw "ObjectType must be one of the following types: Int32, String, Guid. If you are certain " +
                    "the value matches one of these types, try explicitly casting the value to that type, e.g., " +
                    "[Int32] `$ObjectType = 1234567."
                }

                return $IsValidType
            })]
        [Object] $ObjectType,
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String] $QueryHint,
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [RelativityObjectManagerV1ModelsSortEnum] $RankSortOrder,
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [ValidateScript({
                $AllowedTypes = @(
                    [Int32],
                    [String],
                    [Guid]
                )
                [Boolean] $IsValidType = $false

                foreach ($Type in $AllowedTypes)
                {
                    if ($_ -is $Type)
                    {
                        $IsValidType = $true
                        break
                    }
                }

                if (-not $IsValidType)
                {
                    throw "RelationalField must be one of the following types: Int32, String, Guid. If you are " +
                    "certain the value matches one of these types, try explicitly casting the value to that type, " +
                    "e.g., [Int32] `$RelationalField = 1234567."
                }

                return $IsValidType
            })]
        [Object] $RelationalField,
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String] $RowCondition,
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [RelativityObjectManagerV1ModelsSampleParameters] $SampleParameterSet,
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [RelativityObjectManagerV1ModelsSearchProviderConditions] $SearchProviderCondition,
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                [Boolean] $IsValidType = $false

                if ($_ -is [System.Collections.IEnumerable] -and ($_ -isnot [String]))
                {
                    $IsValidType = $true
                    foreach ($Item in $_)
                    {
                        if (-not $_ -is [RelativityObjectManagerV1ModelsSort])
                        {
                            $IsValidType = $false
                            break
                        }
                    }
                }
                else
                {
                    if ($_ -is [RelativityObjectManagerV1ModelsSort])
                    {
                        $IsValidType = $true
                    }
                }

                if (-not $IsValidType)
                {
                    throw "Sorts must be of the type RelativityObjectManagerV1ModelsSort or an IEnumerable " +
                    "containing only objects of that type. Use the function New-RelativityObjectQuerySort to " +
                    "generate one or more sorting objects."
                }

                return $IsValidType
            })]
        [Object] $Sorts
    )

    Begin
    {

    }
    Process
    {

    }
    End
    {
        
    }
}