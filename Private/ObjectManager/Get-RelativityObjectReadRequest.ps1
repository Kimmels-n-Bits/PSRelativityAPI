function Get-RelativityObjectReadRequest
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $false)]
        [Int32] $ActiveArtifactID,
        [Parameter(Mandatory = $false)]
        [RelativityObjectQueryCondition] $Condition,
        [Parameter(Mandatory = $false)]
        [Int32] $ExecutingSavedSearchID,
        [Parameter(Mandatory = $false)]
        [Int32] $ExecutingViewID,
        [Parameter(Mandatory = $true)]
        [Object] $Fields,
        [Parameter(Mandatory = $false)]
        [Boolean] $IncludeIDWindow,
        [Parameter(Mandatory = $false)]
        [Boolean] $IncludeNameInQueryResult,
        [Parameter(Mandatory = $false)]
        [Boolean] $IsAdhocQuery,
        [Parameter(Mandatory = $true)]
        [Int32] $Length,
        [Parameter(Mandatory = $false)]
        [RelativityObjectManagerV1ModelsLongTextBehavior] $LongTextBehavior,
        [Parameter(Mandatory = $false)]
        [Int32] $MaxCharactersForLongTextValues,
        [Parameter(Mandatory = $true)]
        [Object] $ObjectType,
        [Parameter(Mandatory = $false)]
        [String] $QueryHint,
        [Parameter(Mandatory = $false)]
        [RelativityObjectManagerV1ModelsSortEnum] $RankSortOrder,
        [Parameter(Mandatory = $false)]
        [Object] $RelationalField,
        [Parameter(Mandatory = $false)]
        [String] $RowCondition,
        [Parameter(Mandatory = $false)]
        [RelativityObjectManagerV1ModelsSampleParameters] $SampleParameterSet,
        [Parameter(Mandatory = $false)]
        [RelativityObjectManagerV1ModelsSearchProviderConditions] $SearchProviderCondition,
        [Parameter(Mandatory = $false)]
        [Object] $Sorts,
        [Parameter(Mandatory = $true)]
        [Int32] $Start
    )

    Begin
    {
        Write-Verbose "Starting Get-RelativityObjectReadRequest"
    }
    Process
    {
        [Collections.Generic.List[RelativityObjectManagerV1ModelsFieldRef]] $FieldsValue = @()
        $Fields | ForEach-Object {
            $Field = [RelativityObjectManagerV1ModelsFieldRef]::New()

            if ($_ -Is [Int32]) { $Field.ArtifactID = $_ }
            elseif ($_ -Is [String]) { $Field.Name = $_ }
            elseif ($_ -Is [Guid]) { $Field.Guid = $_ }

            $FieldsValue.Add($Field)
        }

        $ObjectTypeValue = [RelativityObjectManagerV1ModelsObjectTypeRef]::New()

        if ($ObjectType -Is [Int32]) { $ObjectTypeValue.ArtifactTypeID = $ObjectType }
        elseif ($ObjectType -Is [String]) { $ObjectTypeValue.Name = $ObjectType }
        elseif ($ObjectType -Is [Guid]) { $ObjectTypeValue.Guid = $ObjectType }

        $RelationalFieldValue = [RelativityObjectManagerV1ModelsFieldRef]::New()

        if ($RelationalField -Is [Int32]) { $RelationalFieldValue.ArtifactID = $RelationalField }
        elseif ($RelationalField -Is [String]) { $RelationalFieldValue.Name = $RelationalField }
        elseif ($RelationalField -Is [Guid]) { $RelationalFieldValue.Guid = $RelationalField }

        [Collections.Generic.List[RelativityObjectManagerV1ModelsSort]] $SortsValue = @()

        $Sorts | ForEach-Object {
            $SortsValue.Add($Sort)
        }

        $Request = [RelativityObjectManagerV1ModelsQueryRequest]::New()
        $Request.ActiveArtifactID = $ActiveArtifactID
        $Request.Condition = $Condition
        $Request.ConvertNumberFieldValuesToString = $ConvertNumberFieldValuesToString
        $Request.ExecutingSavedSearchID = $ExecutingSavedSearchID
        $Request.ExecutingViewID = $ExecutingViewID
        $Request.Fields = $FieldsValue
        $Request.IncludeIDWindow = $IncludeIDWindow
        $Request.IncludeNameInQueryResult = $IncludeNameInQueryResult
        $Request.IsAdhocQuery = $IsAdhocQuery
        $Request.Length = $Length
        $Request.LongTextBehavior = $LongTextBehavior
        $Request.MaxCharactersForLongTextValues = $MaxCharactersForLongTextValues
        $Request.ObjectType = $ObjectTypeValue
        $Request.QueryHint = $QueryHint
        $Request.RankSortOrder = $RankSortOrder
        $Request.RelationalField = $RelationalFieldValue
        $Request.RowCondition = $RowCondition
        $Request.SampleParameters = $SampleParameterSet
        $Request.SearchProviderConditions = $SearchProviderConditions
        $Request.Sorts = $SortsValue
        $Request.Start = $Start
 
        return $Request
    }
    End
    {
        Write-Verbose "Completed Get-RelativityObjectReadRequest"
    }
}