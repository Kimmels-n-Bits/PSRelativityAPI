class RelativityInfrastructureV1CacheLocationServerModelsResponse : RelativitySharedV1ModelsDisplayableObjectIdentifier
{
    <#
        .SYNOPSIS
            Represents the results of a read operation on a cache location server.
        .PARAMETER Actions
            Gets or sets a list of RESTful operations that a user has permissions to perform on the artifact.
        .PARAMETER CacheLocationCapacityInGigabytes
            Gets or sets the capacity in gigabytes of the cache location server.
        .PARAMETER CacheLocationCleanUpStatus
            Gets or sets the status of the cache location cleanup process.
        .PARAMETER CacheLocationFreeSpaceInGigabytes
            Gets or sets the free space in gigabytes of the cache location server.
        .PARAMETER CacheLocationFreeSpaceInPercents
            Gets or sets the free space in percents of the cache location server.
        .PARAMETER CacheLocationLowerThresholdInPercents
            Gets or sets the lower threshold in percents of the cache location server.
        .PARAMETER CacheLocationUpperThresholdInPercents
            Gets or sets the upper threshold in percents of the cache location server.
        .PARAMETER CreatedBy
            Gets or sets the ID and name of the user who created the artifact.
        .PARAMETER CreatedOn
            Gets or sets the date and time when the artifact was added to Relativity.
        .PARAMETER FileAccessCredentials
            Gets or sets the information about file access credentials object.
        .PARAMETER IsDocumentCacheTimeBased
            Gets or sets a value indicating whether the system is configured to use a time based document cache.
        .PARAMETER IsVisible
            Gets or sets a value indicating whether the cache location server should be available for selection while creating a workspace.
        .PARAMETER Keywords
            Gets or sets the keywords associated with the artifact.
        .PARAMETER LastModifiedBy
            Gets or sets the ID and name of the user who recently updated the artifact.
        .PARAMETER LastModifiedOn
            Gets or sets the date and time when the artifact was most recently updated.
        .PARAMETER Meta
            Gets or sets a list of unsupported and read-only properties on the current artifact.
        .PARAMETER Notes
            Gets or sets an optional description or other information about the artifact.
        .PARAMETER Type
            Gets or sets the type of the server.
        .PARAMETER UncPath
            Gets or sets the UNC path of the cache location server.
    #>
    [Collections.Generic.List[RelativitySharedV1ModelsAction]] $Actions
    [Int32] $CacheLocationCapacityInGigabytes
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $CacheLocationCleanUpStatus
    [Int32] $CacheLocationFreeSpaceInGigabytes
    [Int32] $CacheLocationFreeSpaceInPercents
    [Int32] $CacheLocationLowerThresholdInPercents
    [Int32] $CacheLocationUpperThresholdInPercents
    [RelativitySharedV1ModelsSecurable] $CreatedBy
    [DateTime] $CreatedOn
    [RelativitySharedV1ModelsSecurable] $FileAccessCredentials
    [Boolean] $IsDocumentCacheTimeBased
    [Boolean] $IsVisible
    [String] $Keywords
    [RelativitySharedV1ModelsSecurable] $LastModifiedBy
    [DateTime] $LastModifiedOn
    [RelativitySharedV1ModelsMeta] $Meta
    [String] $Notes
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $Type
    [String] $UncPath

    RelativityInfrastructureV1CacheLocationServerModelsResponse (
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

        # TODO consider that this object is not present in json response
        <#
        $this.CacheLocationCleanUpStatus = [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
            $ApiResponse.CacheLocationCleanUpStatus.ArtifactId, 
            $ApiResponse.CacheLocationCleanUpStatus.Guids,
            $ApiResponse.CacheLocationCleanUpStatus.Name
        )
        #>

        $this.CacheLocationFreeSpaceInGigabytes = $ApiResponse.CacheLocationFreeSpaceInGigabytes

        $this.CacheLocationFreeSpaceInPercents = $ApiResponse.CacheLocationFreeSpaceInPercents

        # TODO make this a nullable value
        $this.CacheLocationLowerThresholdInPercents = $ApiResponse.CacheLocationLowerThresholdInPercents

        # TODO make this a nullable value
        $this.CacheLocationUpperThresholdInPercents = $ApiResponse.CacheLocationUpperThresholdInPercents

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