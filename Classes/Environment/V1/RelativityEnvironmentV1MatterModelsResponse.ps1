class RelativityEnvironmentV1MatterModelsResponse
{
    <#
        .SYNOPSIS
            Represents the results of a read operation on a Matter Object.
        .PARAMETER Actions
            Gets or sets a list of RESTful operations that a user has permissions to perform on the artifact.
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
        .PARAMETER Meta
            Gets or sets a list of unsupported and read-only properties on the current artifact.
        .PARAMETER Notes
            Gets or sets an optional description or other information about the artifact.
    #>
    [Collections.Generic.List[RelativitySharedV1ModelsAction]] $Actions
    [RelativitySharedV1ModelsSecurable] $Client
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $CreatedBy
    [DateTime] $CreatedOn
    [String] $Keywords
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $LastModifiedBy
    [DateTime] $LastModifiedOn
    [RelativitySharedV1ModelsMeta] $Meta
    [String] $Notes
    [String] $Number
    [RelativitySharedV1ModelsSecurable] $Status
    
    RelativityEnvironmentV1MatterModelsResponse (
        [PSCustomObject] $ApiResponse
    )
    {
        $this.Actions = $ApiResponse.Actions
        
        #region Client
        if ($ApiResponse.Client.Value -ne $null)
        {
            $this.Client = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.Client.Secured,
                [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                    $ApiResponse.Client.Value
                )
            )
        }
        else
        {
            $this.Client = [RelativitySharedV1ModelsSecurable]::New($ApiResponse.Client.Secured, $null)
        }
        #endregion Client

        $this.CreatedBy = $ApiResponse.CreatedBy

        $this.CreatedOn = $ApiResponse.CreatedOn

        $this.Keywords = $ApiResponse.Keywords

        $this.LastModifiedBy = $ApiResponse.LastModifiedBy

        $this.LastModifiedOn = $ApiResponse.LastModifiedOn

        $this.Meta = $ApiResponse.Meta

        $this.Notes = $ApiResponse.Notes

        $this.Number = $ApiResponse.Number

        #region Status
        if ($ApiResponse.Status.Value -ne $null)
        {
            $this.Status = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.Status.Secured,
                [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                    $ApiResponse.Status.Value
                )
            )
        }
        else
        {
            $this.Status = [RelativitySharedV1ModelsSecurable]::New($ApiResponse.Status.Secured, $null)
        }
        #endregion Status
    }
}