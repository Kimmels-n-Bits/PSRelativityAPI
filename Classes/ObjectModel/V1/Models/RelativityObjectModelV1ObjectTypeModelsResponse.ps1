class RelativityObjectModelV1ObjectTypeModelsResponse
{
    <# TODO
        .SYNOPSIS
            Represents the results of a read operation on a cache location server.
        .PARAMETER Actions
            Gets or sets a list of RESTful operations that a user has permissions to perform on the artifact.
        .PARAMETER 
    #>
    [Collections.Generic.List[RelativitySharedV1ModelsAction]] $Actions
    [Int32] $ArtifactTypeID
    [Boolean] $CopyInstancesOnCaseCreation
    [Boolean] $CopyInstancesOnParentCopy
    [RelativitySharedV1ModelsSecurable] $CreatedBy
    [DateTime] $CreatedOn
    [Boolean] $EnableSnapshotAuditingOnDelete
    [Int32] $FieldByteUsage
    [Boolean] $IsDynamic
    [Boolean] $IsExtensible
    [Boolean] $IsSystem
    [Boolean] $IsViewEnabled
    [String] $Keywords
    [RelativitySharedV1ModelsSecurable] $LastModifiedBy
    [DateTime] $LastModifiedOn
    [RelativitySharedV1ModelsMeta] $Meta
    [String] $Notes
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $ObjectIdentifier
    [RelativitySharedV1ModelsSecurable] $ParentObjectType
    [Boolean] $PersistentListsEnabled
    [Boolean] $PivotEnabled
    [System.Object] $RelativityApplications # TODO create type [SecurableList<DisplayableObjectIdentifier]
    [Boolean] $SamplingEnabled
    [Nullable[Boolean]] $UseRelativityForms

    RelativityObjectModelV1ObjectTypeModelsResponse (
        [PSCustomObject] $ApiResponse
    ):base ($ApiResponse.ArtifactID, $ApiResponse.Guids, $ApiResponse.Name)
    {
        $this.Actions = @()
        $ApiResponse.Actions | ForEach-Object {
            [Collections.Generic.List[String]] $ActionReasons = @()
            
            $_.Reason | ForEach-Object {
                $ActionReasons.Add($_)
            }
            
            $this.Actions.Add([RelativitySharedV1ModelsAction]::New(
                    $_.Href,
                    $_.IsAvailable,
                    $_.Name,
                    $ActionReasons,
                    $_.Verb
                ))
        }

        
        $this.CacheLocationCapacityInGigabytes = $ApiResponse.CacheLocationCapacityInGigabytes

        if($ApiResponse.CacheLocationCleanUpStatus -ne $null)
        {
            $this.CacheLocationCleanUpStatus = [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                $ApiResponse.CacheLocationCleanUpStatus.ArtifactId, 
                $ApiResponse.CacheLocationCleanUpStatus.Guids,
                $ApiResponse.CacheLocationCleanUpStatus.Name
            )
        }

        $this.CacheLocationFreeSpaceInGigabytes = $ApiResponse.CacheLocationFreeSpaceInGigabytes

        $this.CacheLocationFreeSpaceInPercents = $ApiResponse.CacheLocationFreeSpaceInPercents

        if($ApiResponse.CacheLocationLowerThresholdInPercents -ne $null)
        {
            $this.CacheLocationLowerThresholdInPercents = $ApiResponse.CacheLocationLowerThresholdInPercents
        }

        if($ApiResponse.CacheLocationUpperThresholdInPercents -ne $null)
        {
            $this.CacheLocationUpperThresholdInPercents = $ApiResponse.CacheLocationUpperThresholdInPercents
        }

        $this.CreatedBy = [RelativitySharedV1ModelsSecurable]::New(
            $ApiResponse.CreatedBy.Secured,
            $ApiResponse.CreatedBy.Value
        )

        $this.CreatedOn = $ApiResponse.CreatedOn

        if (-not($ApiResponse.Meta.Unsupported -contains "FileAccessCredentials"))
        {
            $this.FileAccessCredentials = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.FileAccessCredentials.Secured,
                $ApiResponse.FileAccessCredentials.Value
            )
        }

        $this.IsDocumentCacheTimeBased = $ApiResponse.IsDocumentCacheTimeBased

        $this.IsVisible = $ApiResponse.IsVisible

        $this.Keywords = $ApiResponse.Keywords

        $this.LastModifiedBy = [RelativitySharedV1ModelsSecurable]::New(
            $ApiResponse.LastModifiedBy.Secured,
            $ApiResponse.LastModifiedBy.Value
        )

        $this.LastModifiedOn = $ApiResponse.LastModifiedOn

        [Collections.Generic.List[String]] $MetaReadOnly = @()
        $ApiResponse.Meta.ReadOnly | ForEach-Object {
            $MetaReadOnly.Add($_)
        }

        [Collections.Generic.List[String]] $MetaUnsupported = @()
        $ApiResponse.Meta.Unsupported | ForEach-Object {
            $MetaUnsupported.Add($_)
        }
        
        $this.Meta = [RelativitySharedV1ModelsMeta]::New(
            $MetaReadOnly,
            $MetaUnsupported
        )

        $this.Notes = $ApiResponse.Notes

        $this.Type = [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
            $ApiResponse.Type.ArtifactId, 
            $ApiResponse.Type.Guids,
            $ApiResponse.Type.Name
        )

        $this.UncPath = $ApiResponse.UncPath
    }
}