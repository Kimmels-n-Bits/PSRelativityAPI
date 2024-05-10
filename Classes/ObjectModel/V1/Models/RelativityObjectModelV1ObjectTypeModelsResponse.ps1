class RelativityObjectModelV1ObjectTypeModelsResponse
{
    <# Partial parameter list - This assembly is poorly documented.
        .SYNOPSIS
            Represents the results of a read operation on an ObjectType.
        .PARAMETER Actions
            Gets or sets a list of RESTful operations that a user has permissions to perform on the artifact.
        .PARAMETER ArtifactTypeID
            ID for the artifact type.
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
    [RelativitySharedV1ModelsSecurableList] $RelativityApplications
    [Boolean] $SamplingEnabled
    [Nullable[Boolean]] $UseRelativityForms

    RelativityObjectModelV1ObjectTypeModelsResponse (
        [PSCustomObject] $ApiResponse
    )
    {
        $this.Actions = $ApiResponse.Actions
        
        $this.ArtifactTypeID = $ApiResponse.ArtifactTypeID

        $this.CopyInstancesOnCaseCreation = $ApiResponse.CopyInstancesOnCaseCreation

        $this.CopyInstancesOnParentCopy = $ApiResponse.CopyInstancesOnParentCopy

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

        $this.EnableSnapshotAuditingOnDelete = $ApiResponse.EnableSnapshotAuditingOnDelete

        $this.FieldByteUsage = $ApiResponse.FieldByteUsage

        $this.IsDynamic = $ApiResponse.IsDynamic

        $this.IsExtensible = $ApiResponse.IsExtensible

        $this.IsSystem = $ApiResponse.IsSystem

        $this.IsViewEnabled = $ApiResponse.IsViewEnabled

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

        $this.ObjectIdentifier = $ApiResponse.ObjectIdentifier

        #region ParentObjectType
        if($ApiResponse.ParentObjectType.Value -ne $null)
        {
            $this.ParentObjectType = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.ParentObjectType.Secured,
                [RelativitySharedV1ModelsDisplayableObjectTypeIdentifier]::New(
                    $ApiResponse.ParentObjectType.Value
                )
            )
        }
        else
        {
            $this.ParentObjectType = [RelativitySharedV1ModelsSecurable]::New($ApiResponse.ParentObjectType.Secured, $null)
        }
        #endregion ParentObjectType
        
        $this.PersistentListsEnabled = $ApiResponse.PersistentListsEnabled

        $this.PivotEnabled = $ApiResponse.PivotEnabled

        #region RelativityApplications
        [Collections.Generic.List[RelativitySharedV1ModelsDisplayableObjectIdentifier]] $_viewableItems = @()
        $ApiResponse.RelativityApplications.ViewableItems | ForEach-Object {
            $_viewableItems.Add([RelativitySharedV1ModelsDisplayableObjectIdentifier]::New($_))
        }

        $this.RelativityApplications = [RelativitySharedV1ModelsSecurableList]::New(
                $ApiResponse.RelativityApplications.HasSecuredItems,
                $_viewableItems 
            )
        #endregion RelativityApplications

        $this.SamplingEnabled = $ApiResponse.SamplingEnabled

        if($ApiResponse.UseRelativityForms -ne $null)
        {
            $this.UseRelativityForms = $ApiResponse.UseRelativityForms
        }
    }
}