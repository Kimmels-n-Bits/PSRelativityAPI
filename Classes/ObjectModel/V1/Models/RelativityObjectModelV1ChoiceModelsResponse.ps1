class RelativityObjectModelV1ChoiceModelsResponse
{
    <#
        .SYNOPSIS
            Represents the results of a read operation on a Choice Object.
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
    [RelativityObjectModelV1ChoiceModelsColor] $Color
    [RelativitySharedV1ModelsSecurable] $CreatedBy
    [DateTime] $CreatedOn
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $Field
    [String] $Keywords
    [RelativitySharedV1ModelsSecurable] $LastModifiedBy
    [DateTime] $LastModifiedOn
    [RelativitySharedV1ModelsMeta] $Meta
    [String] $Notes
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $ObjectIdentifier
    [String] $ObjectVersionToken
    [Int32] $Order
    [RelativitySharedV1ModelsObjectIdentifier] $Parent
    [RelativitySharedV1ModelsSecurableList] $RelativityApplications
    [RelativityObjectModelV1SharedModelsShortcut] $Shortcut
    
    RelativityObjectModelV1ChoiceModelsResponse (
        [PSCustomObject] $ApiResponse
    )
    {
        $this.Actions = $ApiResponse.Actions
        
        $this.Color = $ApiResponse.Color

        #region CreatedBy
        if($ApiResponse.CreatedBy.Value -ne $null)
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

        $this.Field = [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                        $ApiResponse.Field
                    )

        $this.Keywords = $ApiResponse.Keywords

        #region LastModifiedBy
        if($ApiResponse.LastModifiedBy.Value -ne $null)
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

        $this.Meta = $ApiResponse.Meta

        $this.Notes = $ApiResponse.Notes

        $this.ObjectIdentifier = [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                $ApiResponse.ObjectIdentifier
            )
        
        $this.ObjectVersionToken = $ApiResponse.ObjectVersionToken

        $this.Order = $ApiResponse.Order

        $this.Parent = $ApiResponse.Parent

        #region RelativityApplications
        if($ApiResponse.RelativityApplications -ne $null)
        {
            [Collections.Generic.List[RelativitySharedV1ModelsDisplayableObjectIdentifier]] $_viewableItems = @()
            $ApiResponse.RelativityApplications.ViewableItems | ForEach-Object {
                $_viewableItems.Add([RelativitySharedV1ModelsDisplayableObjectIdentifier]::New($_))
            }

            $this.RelativityApplications = [RelativitySharedV1ModelsSecurableList]::New(
                    $ApiResponse.RelativityApplications.HasSecuredItems,
                    $_viewableItems 
                )
        }
        #endregion RelativityApplications

        $this.Shortcut = $ApiResponse.Shortcut
    }
}