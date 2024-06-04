class RelativityInfrastructureV1CacheLocationServersNewResponse : RelativitySharedV1ModelsDisplayableObjectIdentifier
{
    <#
        .SYNOPSIS
            Response from a create New operation on a file repository server.
            (very similar to [RelativityInfrastructureV1FileRespositoryServerModelsResponse] object)

        .PARAMETER Actions
            Gets or sets a list of RESTful operations that a user has permissions to perform on the artifact.
        .PARAMETER CacheLocationCapacityInGigabytes
            na
        .PARAMETER CacheLocationFreeSpaceInGigabytes
            na
        .PARAMETER CacheLocationFreeSpaceInPercents
            na
        .PARAMETER CacheLocationUpperThresholdInPercents
            na
        .PARAMETER CacheLocationLowerThresholdInPercents
            na            
        .PARAMETER CreatedBy
            Gets or sets the ID and name of the user who created the artifact.
        .PARAMETER CreatedOn
            Gets or sets the date and time when the artifact was added to Relativity.
        .PARAMETER FileAccessCredentials
            Gets or sets the information about file access credentials object.
            Field may be not be needed. (unconfirmed)
        .PARAMETER IsDocumentCacheTimeBased
            na
        .PARAMETER IsVisible
            Gets or sets a value indicating whether the file repository server should be available for selection while creating a workspace.
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
            Gets or sets the UNC path of the file repository server.
    #>
    [Collections.Generic.List[RelativitySharedV1ModelsAction]] $Actions
    [Int32] $CacheLocationCapacityInGigabytes
    [Int32] $CacheLocationFreeSpaceInGigabytes
    [Int32] $CacheLocationFreeSpaceInPercents
    [Int32] $CacheLocationUpperThresholdInPercents
    [Int32] $CacheLocationLowerThresholdInPercents
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $CreatedBy
    [DateTime] $CreatedOn
    [RelativitySharedV1ModelsSecurable] $FileAccessCredentials
    [Boolean] $IsDocumentCacheTimeBased
    [Boolean] $IsVisible
    [String] $Keywords
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $LastModifiedBy
    [DateTime] $LastModifiedOn
    [RelativitySharedV1ModelsMeta] $Meta
    [String] $Notes
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $Type
    [String] $UncPath

    RelativityInfrastructureV1CacheLocationServersNewResponse (
        [PSCustomObject] $ApiResponse
    ):base ($ApiResponse.ArtifactID, $ApiResponse.Guids, $ApiResponse.Name)
    {
        $this.Actions = $ApiResponse.Actions

        $this.CacheLocationCapacityInGigabytes = $ApiResponse.CacheLocationCapacityInGigabytes
        $this.CacheLocationFreeSpaceInGigabytes = $ApiResponse.CacheLocationFreeSpaceInGigabytes
        $this.CacheLocationFreeSpaceInPercents = $ApiResponse.CacheLocationFreeSpaceInPercents
        $this.CacheLocationUpperThresholdInPercents = $ApiResponse.CacheLocationUpperThresholdInPercents
        $this.CacheLocationLowerThresholdInPercents = $ApiResponse.CacheLocationLowerThresholdInPercents

        $this.CreatedBy = $ApiResponse.CreatedBy

        $this.CreatedOn = $ApiResponse.CreatedOn

        #region FileAccessCredentials
        if ($ApiResponse.FileAccessCredentials -ne $null)
        {
            if ($ApiResponse.FileAccessCredentials.Value -ne $null)
            {
                $this.FileAccessCredentials = [RelativitySharedV1ModelsSecurable]::New(
                    $ApiResponse.FileAccessCredentials.Secured,
                    [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                        $ApiResponse.FileAccessCredentials.Value
                    )
                )
            }
            else
            {
                $this.FileAccessCredentials = [RelativitySharedV1ModelsSecurable]::New($ApiResponse.FileAccessCredentials.Secured, $null)
            }
        }
        #endregion FileAccessCredentials

        $this.IsDocumentCacheTimeBased = $ApiResponse.IsDocumentCacheTimeBased

        $this.IsVisible = $ApiResponse.IsVisible

        $this.Keywords = $ApiResponse.Keywords

        $this.LastModifiedBy = $ApiResponse.LastModifiedBy
        
        $this.LastModifiedOn = $ApiResponse.LastModifiedOn

        $this.Meta = $ApiResponse.Meta

        $this.Notes = $ApiResponse.Notes

        $this.Type = [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
            $ApiResponse.Type
        )

        $this.UncPath = $ApiResponse.UncPath
    }
}