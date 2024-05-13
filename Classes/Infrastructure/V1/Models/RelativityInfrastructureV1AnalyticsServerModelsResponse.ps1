class RelativityInfrastructureV1AnalyticsServerModelsResponse : RelativitySharedV1ModelsDisplayableObjectIdentifier
{
    <# 
        .SYNOPSIS
            Represents results of a read operation on an analytics server.
        .PARAMETER Actions
            Gets or sets a list of RESTful operations that a user has permissions to perform on the artifact.
        .PARAMETER AnalyticsOperations
            Gets or sets the identifier for the client associated with the resource pool.
        .PARAMETER CreatedBy
            Gets or sets the ID and name of the user who created the artifact.
        .PARAMETER CreatedOn
            Gets or sets the date and time when the artifact was added to Relativity.
        .PARAMETER Keywords
            Gets or sets the keywords associated with the artifact.
        .PARAMETER LastModifiedBy
            Gets or sets the ID and name of the user who recently updated the artifact.
        .PARAMETER LastModifiedOn
            Gets or sets the date and time when the artifact was most recently updated.
        .PARAMETER MaximumConnectors
            Gets or sets count of maximum connectors of the analytics server.
        .PARAMETER MaximumTotalConnectors
            Gets or sets total count of maximum connectors.
        .PARAMETER Meta
            Gets or sets a list of unsupported and read-only properties on the current artifact.
        .PARAMETER Notes
            Gets or sets an optional description or other information about the artifact.
        .PARAMETER RestApiUsername
            Gets or sets the username for the REST API of the analytics server.
        .PARAMETER Status
            Gets or sets status of the analytics server.
        .PARAMETER Type
            Gets or sets type of the server.
        .PARAMETER Url
            Gets or sets URL of the analytics server.
        .PARAMETER Version
            Gets or sets version of the analytics server.
        .PARAMETER WindowsServiceStatus
            Gets or sets status of the Windows service this analytics server is hosting.
    #>
    [Collections.Generic.List[RelativitySharedV1ModelsAction]] $Actions
    [Collections.Generic.List[RelativitySharedV1ModelsDisplayableObjectIdentifier]] $AnalyticsOperations
    [RelativitySharedV1ModelsSecurable] $CreatedBy
    [DateTime] $CreatedOn
    [String] $Keywords
    [RelativitySharedV1ModelsSecurable] $LastModifiedBy
    [DateTime] $LastModifiedOn
    [Int32] $MaximumConnectors
    [Int32] $MaximumTotalConnectors
    [RelativitySharedV1ModelsMeta] $Meta
    [String] $Notes
    [String] $RestApiUsername
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $Status
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $Type
    [String] $Url
    [String] $Version
    [String] $WindowsServiceStatus

    RelativityInfrastructureV1AnalyticsServerModelsResponse (
        [PSCustomObject] $ApiResponse
    ):base ($ApiResponse.ArtifactID, $ApiResponse.Guids, $ApiResponse.Name)
    {
        $this.Actions = $ApiResponse.Actions

        if ($ApiResponse.AnalyticsOperations -ne $null)
        {
            $ApiResponse.AnalyticsOperations | ForEach-Object {
                [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New($_)
            }
        }

        #region CreatedBy
        if ($ApiResponse.CreatedBy.Value -ne $null)
        {
            $this.CreatedBy = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.CreatedBy.Secured,
                [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                    $ApiResponse.CreatedBy.Value
                )
            )
        }
        else
        {
            $this.CreatedBy = [RelativitySharedV1ModelsSecurable]::New($ApiResponse.CreatedBy.Secured, $null)
        }
        #endregion CreatedBy

        $this.CreatedOn = $ApiResponse.CreatedOn

        $this.Keywords = $ApiResponse.Keywords

        #region LastModifiedBy
        if ($ApiResponse.LastModifiedBy.Value -ne $null)
        {
            $this.LastModifiedBy = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.LastModifiedBy.Secured,
                [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                    $ApiResponse.LastModifiedBy.Value
                )
            )
        }
        else
        {
            $this.LastModifiedBy = [RelativitySharedV1ModelsSecurable]::New($ApiResponse.LastModifiedBy.Secured, $null)
        }
        #endregion LastModifiedBy

        $this.LastModifiedOn = $ApiResponse.LastModifiedOn

        $this.MaximumConnectors = $ApiResponse.MaximumConnectors

        $this.MaximumTotalConnectors = $ApiResponse.MaximumTotalConnectors

        $this.Meta = $ApiResponse.Meta

        $this.Notes = $ApiResponse.Notes

        $this.RestApiUsername = $ApiResponse.RestApiUsername

        $this.Status = $ApiResponse.Status

        $this.Type = $ApiResponse.Type

        $this.Url = $ApiResponse.Url

        $this.Version = $ApiResponse.Version

        $this.WindowsServiceStatus = $ApiResponse.WindowsServiceStatus
    }
}