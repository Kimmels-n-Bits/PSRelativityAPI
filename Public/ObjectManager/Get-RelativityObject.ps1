function Get-RelativityObject
{
    <#
        .SYNOPSIS
            Returns a [RelativityServicesObjectsDataContractsQueryResult] or [RelativityServicesObjectsDataContractsQuerySlimResult] response object.
            This is based on the presense of the -Full Parameter.

        .PARAMETER ActiveArtifactID
        .PARAMETER Condition
        .PARAMETER ExecutingSavedSearchID
        .PARAMETER ExecutingViewID
        .PARAMETER Fields
        .PARAMETER Full
            When present, returns [RelativityServicesObjectsDataContractsQueryResult]
            If not present, returns [RelativityServicesObjectsDataContractsQuerySlimResult]
        .PARAMETER IncludeIDWindow
        .PARAMETER IncludeNameInQueryResult
        .PARAMETER IsAdhocQuery
        .PARAMETER Length
        .PARAMETER LongTextBehavior
        .PARAMETER MaxCharactersForLongTextValues
        .PARAMETER ObjectType
            (Required)
        .PARAMETER QueryHint
        .PARAMETER RankSortOrder
        .PARAMETER RelationalField
        .PARAMETER RowCondition
        .PARAMETER SampleParameterSet
        .PARAMETER SearchProviderCondition
        .PARAMETER Sorts
        .PARAMETER Start
        .PARAMETER WorkspaceID
            (Required)

        .EXAMPLE
            This will return a [RelativityServicesObjectsDataContractsQuerySlimResult] object.
            It will contain 10 (default) results, starting at index 0 (default).
            Get-RelativityObject `
                -IncludeIDWindow `
                -IncludeNameInQueryResult `
                -IsAdhocQuery `
                -ObjectType 8 `
                -WorkspaceID -1

        .EXAMPLE
            This will return a [RelativityServicesObjectsDataContractsQueryResult] object (Notice -Full Flag).
            It will contain 5 results, starting at index 11.
            Get-RelativityObject `
                -Full `
                -Length 5 `
                -ObjectType 8 `
                -Start 11 `
                -WorkspaceID -1
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $false)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ActiveArtifactID,
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [RelativityObjectQueryCondition] $Condition,
        [Parameter(Mandatory = $false)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ExecutingSavedSearchID,
        [Parameter(Mandatory = $false)]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ExecutingViewID,
        [Parameter(Mandatory = $false)]
        [ValidateScript({
                [Object[]] $AllowedTypes = @(
                    [Int32],
                    [String],
                    [Guid]
                )

                [Boolean] $IsValidType = $false

                foreach ($Type in $AllowedTypes)
                {
                    if ($_ -is $Type)
                    {
                        return $true
                    }
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
        [Switch] $Full,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeIDWindow,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeNameInQueryResult,
        [Parameter(Mandatory = $false)]
        [Switch] $IsAdhocQuery,
        [Parameter(Mandatory = $false)]
        [ValidateRange(0, [Int32]::MaxValue)]
        [Int32] $Length = 10,
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [RelativityObjectManagerV1ModelsLongTextBehavior] $LongTextBehavior = 0,
        [Parameter(Mandatory = $false)]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $MaxCharactersForLongTextValues,
        [Parameter(Mandatory = $true)]
        [ValidateScript({
                [Object[]] $AllowedTypes = @(
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
        [RelativityObjectManagerV1ModelsSortEnum] $RankSortOrder = 0,
        [Parameter(Mandatory = $false)]
        [ValidateScript({
                [Object[]] $AllowedTypes = @(
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
        [ValidateScript({
                [Boolean] $IsValidType = $false

                if ($_ -is [RelativityObjectManagerV1ModelsSort])
                {
                    $IsValidType = $true
                }

                if (-not $IsValidType)
                {
                    throw "Sorts must be of the type RelativityObjectManagerV1ModelsSort or an IEnumerable " +
                    "containing only objects of that type. Use the function New-RelativityObjectQuerySort to " +
                    "generate one or more sorting objects."
                }

                return $IsValidType
            })]
        [Object] $Sorts,
        [Parameter(Mandatory = $false)]
        [ValidateRange(0, [Int32]::MaxValue)]
        [Int32] $Start = 0,
        [Parameter(Mandatory = $true)]
        [ValidateScript({
                $IsValidValue = $false

                if ($_ -eq -1 -or ($_ -ge 1000000 -and $_ -le [Int32]::MaxValue))
                {
                    $IsValidValue = $true
                }

                if (-not $IsValidValue)
                {
                    throw "WorkspaceID must be either -1 or greater than 1000000."
                }
                return $IsValidValue
            })]
        [Int32] $WorkspaceID
    )

    Begin
    {
        Write-Verbose "Starting $($MyInvocation.MyCommand.Name)"

        # Since we accept [Object] type in the parameters above for $ObjectType and $RelationalField we want to
        # validate that passed values in the ValidateScript() block are of the types we're expecting to work with.
        # However, ValidateScript() runs per item of an enumerable that is passed as the parameter and not on the
        # collection itself. So, to ensure we weren't provided enumerable types we're double checking below and
        # throwing an error in the event of an issue.
        if ($ObjectType -is [System.Collections.IEnumerable] -and $ObjectType -isnot [String])
        {
            throw "ObjectType must be one of the following types: Int32, String, Guid. If you are certain " +
            "the value matches one of these types, try explicitly casting the value to that type, e.g., " +
            "[Int32] `$ObjectType = 1234567."
        }

        if ($RelationalField -is [System.Collections.IEnumerable] -and $RelationalField -isnot [String])
        {
            throw "RelationalField must be one of the following types: Int32, String, Guid. If you are " +
            "certain the value matches one of these types, try explicitly casting the value to that type, " +
            "e.g., [Int32] `$RelationalField = 1234567."
        }
    }
    Process
    {
        try
        {
            [String[]] $NonRequestParameters = @("Full", "WorkspaceID")
            [Hashtable] $Parameters = @{}

            (Get-Command -Name $PSCmdlet.MyInvocation.InvocationName).Parameters | ForEach-Object {
                $_.Values | ForEach-Object {
                    $Parameter = Get-Variable -Name $_.Name -ErrorAction SilentlyContinue

                    if ($Parameter.Name -notin $NonRequestParameters -and $null -ne $Parameter.Value)
                    {
                        Write-Verbose "$($Parameter.Name): $($Parameter.Value)"
                        $Parameters.Add($Parameter.Name, $Parameter.Value)
                    }
                }
            }

            $Request = Get-RelativityObjectReadRequest @Parameters
            $RequestBody = $Request.ToHashTable()

            [String[]] $Resources = @("workspace", $WorkspaceID.ToString(), "object")

            if ($Full) { $Resources = $Resources += "query" }
            else { $Resources = $Resources += "queryslim" }

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "Relativity.ObjectManager" -Version "v1" -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndPoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndPoint)"
            
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody

            if ($Full)
            { 
                $Response = [RelativityServicesObjectsDataContractsQueryResult]::New($ApiResponse)
            }
            else
            {
                $Response = [RelativityServicesObjectsDataContractsQuerySlimResult]::New($ApiResponse)
            }

            Write-Verbose "Objects retrieved successfully"

            return $Response
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

            Write-Verbose "API Endpoint: $($ApiEndpoint)"

            throw
        }
    }
    End
    {
        Write-Verbose "Completed $($MyInvocation.MyCommand.Name)"
    }
}