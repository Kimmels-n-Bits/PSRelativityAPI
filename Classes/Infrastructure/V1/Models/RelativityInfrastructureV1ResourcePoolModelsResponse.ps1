class RelativityInfrastructureV1ResourcePoolModelsResponse : RelativitySharedV1ModelsDisplayableObjectIdentifier
{
    <#
        .SYNOPSIS
            Represents the results of a read operation on a Resource Pool.
        .PARAMETER Actions
            Gets or sets a list of RESTful operations that a user has permissions to perform on the artifact.
        .PARAMETER Client
            Gets or sets the identifier for the client associated with the resource pool.
        .PARAMETER CreatedBy
            Gets or sets the ID and name of the user who created the artifact.
        .PARAMETER CreatedOnDate
            Gets or sets the date and time when the artifact was added to Relativity.
        .PARAMETER IsVisible
            Gets or sets a value indicating whether the resource pool should be available for selection in the workspace creation workflow.
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
    #>
    [Collections.Generic.List[RelativitySharedV1ModelsAction]] $Actions
    [RelativitySharedV1ModelsSecurable] $Client
    [RelativitySharedV1ModelsSecurable] $CreatedBy
    [DateTime] $CreatedOnDate
    [Boolean] $IsVisible
    [String] $Keywords
    [RelativitySharedV1ModelsSecurable] $LastModifiedBy
    [DateTime] $LastModifiedOnDate
    [RelativitySharedV1ModelsMeta] $Meta
    [String] $Notes

    RelativityInfrastructureV1ResourcePoolModelsResponse (
        [PSCustomObject] $ApiResponse
    ):base ($ApiResponse.ArtifactID, $ApiResponse.Guids, $ApiResponse.Name)
    {
        [Collections.Generic.List[Guid]] $_guids = @() # Ephemeral Data

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

        #region Client
        if($ApiResponse.Client.Value -ne $null)
        {
            $_guids = @()
            $ApiResponse.Client.Value.Guids | ForEach-Object {
                $_guids.Add($_)
            }

            $this.Client = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.Client.Secured,
                [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                    $ApiResponse.Client.Value.ArtifactID, 
                    $_guids,
                    $ApiResponse.Client.Value.Name
                )
            )
        }
        else
        {
            $this.Client = [RelativitySharedV1ModelsSecurable]::New($ApiResponse.Client.Secured, $null)
        }
        #endregion Client

        #region CreatedBy
        if($ApiResponse.CreatedBy.Value -ne $null)
        {
            $_guids = @()
            $ApiResponse.CreatedBy.Value.Guids | ForEach-Object {
                $_guids.Add($_)
            }

            $this.CreatedBy = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.CreatedBy.Secured,
                [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                    $ApiResponse.CreatedBy.Value.ArtifactID, 
                    $_guids,
                    $ApiResponse.CreatedBy.Value.Name
                )
            )
        }
        else
        {
            $this.CreatedBy = [RelativitySharedV1ModelsSecurable]::New($ApiResponse.CreatedBy.Secured, $null)
        }
        #endregion CreatedBy

        $this.CreatedOnDate = $ApiResponse.CreatedOn

        $this.IsVisible = $ApiResponse.IsVisible

        $this.Keywords = $ApiResponse.Keywords

        #region LastModifiedBy
        if($ApiResponse.LastModifiedBy.Value -ne $null)
        {
            $_guids = @()
            $ApiResponse.LastModifiedBy.Value.Guids | ForEach-Object {
                $_guids.Add($_)
            }
            $this.LastModifiedBy = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.LastModifiedBy.Secured,
                [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                    $ApiResponse.LastModifiedBy.Value.ArtifactID, 
                    $_guids,
                    $ApiResponse.LastModifiedBy.Value.Name
                )
            )
        }
        else
        {
            $this.LastModifiedBy = [RelativitySharedV1ModelsSecurable]::New($ApiResponse.LastModifiedBy.Secured, $null)
        }
        #endregion LastModifiedBy

        $this.LastModifiedOnDate = $ApiResponse.LastModifiedOn

        #region Meta
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
        #endregion Meta

        $this.Notes = $ApiResponse.Notes
    }
}