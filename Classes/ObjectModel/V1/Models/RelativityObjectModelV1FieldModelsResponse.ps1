class RelativityObjectModelV1FieldModelsResponse
{
    <#
        .SYNOPSIS
            Represents the results of a read operation on a Field Object.
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
    [Boolean] $AllowGroupBy
    [Boolean] $AllowHtml
    [Boolean] $AllowPivot
    [Boolean] $AllowSortTally
    [RelativitySharedV1ModelsSecurable] $AssociativeObjectType
    [Boolean] $AutoAddChoices
    [Boolean] $AvailableInFieldTree
    [Boolean] $AvailableInViewer
    [RelativitySharedV1ModelsSecurable] $CreatedBy
    [DateTime] $CreatedOn
    [String] $DisplayValueFalse
    [String] $DisplayValueTrue
    [Boolean] $EnableDataGrid
    [RelativitySharedV1ModelsSecurable] $FieldTreeView
    [RelativityObjectModelV1FieldModelsFieldType] $FieldType
    [RelativityObjectModelV1FieldModelsFilterType] $FilterType
    [RelativityObjectModelV1FieldModelsFormatting] $Formatting
    [String] $FriendlyName
    [Boolean] $HasUnicode
    [RelativityObjectModelV1FieldModelsImportBehavior] $ImportBehavior
    [Boolean] $IncludeInTextIndex
    [Boolean] $IsIdentifier
    [Boolean] $IsLinked
    [Boolean] $IsRelational
    [Boolean] $IsRequired
    [String] $Keywords
    [RelativitySharedV1ModelsSecurable] $LastModifiedBy
    [DateTime] $LastModifiedOn
    [Int32] $Length
    [RelativitySharedV1ModelsMeta] $Meta
    [String] $Notes
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $ObjectIdentifier
    [RelativitySharedV1ModelsSecurable] $ObjectType
    [Boolean] $OpenToAssociations
    [Int32] $Order
    [RelativityObjectModelV1FieldModelsOverlayBehavior] $OverlayBehavior
    [RelativityObjectModelV1FieldModelsPaneIcon] $PaneIcon
    [RelativitySharedV1ModelsSecurable] $PopupPickerView
    [RelativitySharedV1ModelsSecurableList] $PropagateTo
    [RelativitySharedV1ModelsSecurable] $RelationalView
    [RelativitySharedV1ModelsSecurableList] $RelativityApplications
    [RelativityObjectModelV1SharedModelsShortcut] $Shortcut
    [RelativityObjectModelV1FieldModelsFieldSource] $Source
    [Nullable[Int32]] $Width
    [Boolean] $Wrapping

    RelativityObjectModelV1FieldModelsResponse (
        [PSCustomObject] $ApiResponse
    )
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
        
        $this.AllowGroupBy = $ApiResponse.AllowGroupBy

        $this.AllowHtml = $ApiResponse.AllowHtml

        $this.AllowPivot = $ApiResponse.AllowPivot

        $this.AllowSortTally = $ApiResponse.AllowSortTally

        #region AssociativeObjectType
        if($ApiResponse.AssociativeObjectType.Value -ne $null)
        {
            $_guids = @()
            $ApiResponse.AssociativeObjectType.Value.Guids | ForEach-Object {
                $_guids.Add($_)
            }

            $this.AssociativeObjectType = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.AssociativeObjectType.Secured,
                [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                    $ApiResponse.AssociativeObjectType.Value.ArtifactID, 
                    $_guids,
                    $ApiResponse.AssociativeObjectType.Value.Name
                )
            )
        }
        else
        {
            $this.AssociativeObjectType = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.AssociativeObjectType.Secured,
                $null
            )
        }
        #endregion AssociativeObjectType
        
        $this.AutoAddChoices = $ApiResponse.AutoAddChoices

        $this.AvailableInFieldTree = $ApiResponse.AvailableInFieldTree

        $this.AvailableInViewer = $ApiResponse.AvailableInViewer

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

        $this.CreatedOn = $ApiResponse.CreatedOn

        $this.DisplayValueFalse = $ApiResponse.DisplayValueFalse

        $this.DisplayValueTrue = $ApiResponse.DisplayValueTrue

        $this.EnableDataGrid = $ApiResponse.EnableDataGrid

        #region FieldTreeView
        # This object is not always returned
        if($ApiResponse.FieldTreeView -ne $null)
        {
            if($ApiResponse.FieldTreeView.Value -ne $null)
            {
                $_guids = @()
                $ApiResponse.FieldTreeView.Value.Guids | ForEach-Object {
                    $_guids.Add($_)
                }

                $this.FieldTreeView = [RelativitySharedV1ModelsSecurable]::New(
                    $ApiResponse.FieldTreeView.Secured,
                    [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                        $ApiResponse.FieldTreeView.Value.ArtifactID, 
                        $_guids,
                        $ApiResponse.FieldTreeView.Value.Name
                    )
                )
            }
            else
            {
                $this.FieldTreeView = [RelativitySharedV1ModelsSecurable]::New(
                    $ApiResponse.FieldTreeView.Secured, 
                    $null)
            }
        }
        #endregion FieldTreeView

        if ([Enum]::IsDefined([RelativityObjectModelV1FieldModelsFieldType], $ApiResponse.FieldType)) {
            $this.FieldType = [Enum]::Parse([RelativityObjectModelV1FieldModelsFieldType], $ApiResponse.FieldType)
        } else {
            throw "Invalid enum [RelativityObjectModelV1FieldModelsFieldType] = $($ApiResponse.FieldType)"
        }

        if ([Enum]::IsDefined([RelativityObjectModelV1FieldModelsFilterType], $ApiResponse.FilterType)) {
            $this.FilterType = [Enum]::Parse([RelativityObjectModelV1FieldModelsFilterType], $ApiResponse.FilterType)
        } else {
            throw "Invalid enum [RelativityObjectModelV1FieldModelsFilterType] = $($ApiResponse.FilterType)"
        }

        if ([Enum]::IsDefined([RelativityObjectModelV1FieldModelsFormatting], $ApiResponse.Formatting)) {
            $this.Formatting = [Enum]::Parse([RelativityObjectModelV1FieldModelsFormatting], $ApiResponse.Formatting)
        } else {
            throw "Invalid enum [RelativityObjectModelV1FieldModelsFormatting] = $($ApiResponse.Formatting)"
        }
        
        $this.FriendlyName = $ApiResponse.FriendlyName

        $this.HasUnicode = $ApiResponse.HasUnicode

        if ([Enum]::IsDefined([RelativityObjectModelV1FieldModelsImportBehavior], $ApiResponse.ImportBehavior)) {
            $this.ImportBehavior = [Enum]::Parse([RelativityObjectModelV1FieldModelsImportBehavior], $ApiResponse.ImportBehavior)
        } else {
            throw "Invalid enum [RelativityObjectModelV1FieldModelsImportBehavior] = $($ApiResponse.ImportBehavior)"
        }

        $this.IncludeInTextIndex = $ApiResponse.IncludeInTextIndex

        $this.IsIdentifier = $ApiResponse.IsIdentifier

        $this.IsLinked = $ApiResponse.IsLinked

        $this.IsRelational = $ApiResponse.IsRelational

        $this.IsRequired = $ApiResponse.IsRequired

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

        $this.LastModifiedOn = $ApiResponse.LastModifiedOn

        $this.Length = $ApiResponse.Length

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

        $_guids = @()
        $ApiResponse.ObjectIdentifier.Guids | ForEach-Object {
            $_guids.Add($_)
        }
        $this.ObjectIdentifier = [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                $ApiResponse.ObjectIdentifier.ArtifactID, 
                $_guids,
                $ApiResponse.ObjectIdentifier.Name
            )
        

        #region ObjectType
        if($ApiResponse.ObjectType.Value -ne $null)
        {
            $_guids = @()
            $ApiResponse.ObjectType.Value.Guids | ForEach-Object {
                $_guids.Add($_)
            }
            $this.ObjectType = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.ObjectType.Secured,
                [RelativitySharedV1ModelsDisplayableObjectTypeIdentifier]::New(
                    $ApiResponse.ObjectType.Value.ArtifactTypeID,
                    $ApiResponse.ObjectType.Value.ArtifactID, 
                    $_guids,
                    $ApiResponse.ObjectType.Value.Name
                )
            )
        }
        else
        {
            $this.ObjectType = [RelativitySharedV1ModelsSecurable]::New($ApiResponse.ObjectType.Secured, $null)
        }
        #endregion ObjectType

        $this.OpenToAssociations = $ApiResponse.OpenToAssociations

        $this.Order = $ApiResponse.Order

        if ([Enum]::IsDefined([RelativityObjectModelV1FieldModelsOverlayBehavior], $ApiResponse.OverlayBehavior)) {
            $this.OverlayBehavior = [Enum]::Parse([RelativityObjectModelV1FieldModelsOverlayBehavior], $ApiResponse.OverlayBehavior)
        } else {
            throw "Invalid enum [RelativityObjectModelV1FieldModelsOverlayBehavior] = $($ApiResponse.OverlayBehavior)"
        }

        if($ApiResponse.PaneIcon -ne $null)
        {
            $this.PaneIcon = [RelativityObjectModelV1FieldModelsPaneIcon]::New(
                $ApiResponse.PaneIcon.FileName, 
                $ApiResponse.PaneIcon.ImageBase64
            )
        }
        
        #region PopupPickerView
        if($ApiResponse.PopupPickerView -ne $null)
        {
            if($ApiResponse.PopupPickerView.Value -ne $null)
            {
                $_guids = @()
                $ApiResponse.PopupPickerView.Value.Guids | ForEach-Object {
                    $_guids.Add($_)
                }
                $this.PopupPickerView = [RelativitySharedV1ModelsSecurable]::New(
                    $ApiResponse.PopupPickerView.Secured,
                    [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                        $ApiResponse.PopupPickerView.Value.ArtifactID, 
                        $_guids,
                        $ApiResponse.PopupPickerView.Value.Name
                    )
                )
            }
            else
            {
                $this.PopupPickerView = [RelativitySharedV1ModelsSecurable]::New(
                    $ApiResponse.PopupPickerView.Secured, 
                    $null)
            }
        }
        #endregion PopupPickerView

        #region PropagateTo
        if($ApiResponse.PropagateTo -ne $null)
        {
            [Collections.Generic.List[RelativitySharedV1ModelsDisplayableObjectIdentifier]] $_viewableItems = @()
            $ApiResponse.PropagateTo.ViewableItems | ForEach-Object {
                
                $_guids = @()
                $_.Guids | ForEach-Object {
                    $_guids.Add($_)
                }

                $_viewableItems.Add([RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                    $_.ArtifactID, 
                    $_guids,
                    $_.Name
                ))
            }

            $this.PropagateTo = [RelativitySharedV1ModelsSecurableList]::New(
                    $ApiResponse.PropagateTo.HasSecuredItems,
                    $_viewableItems 
                )
        }
        #endregion PropagateTo

        #region RelationalView
        if($ApiResponse.RelationalView -ne $null)
        {
            if($ApiResponse.RelationalView.Value -ne $null)
            {
                $_guids = @()
                $ApiResponse.RelationalView.Value.Guids | ForEach-Object {
                    $_guids.Add($_)
                }
                $this.RelationalView = [RelativitySharedV1ModelsSecurable]::New(
                    $ApiResponse.RelationalView.Secured,
                    [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                        $ApiResponse.RelationalView.Value.ArtifactID, 
                        $_guids,
                        $ApiResponse.RelationalView.Value.Name
                    )
                )
            }
            else
            {
                $this.RelationalView = [RelativitySharedV1ModelsSecurable]::New(
                    $ApiResponse.RelationalView.Secured, 
                    $null)
            }
        }
        #endregion RelationalView

        #region RelativityApplications
        [Collections.Generic.List[RelativitySharedV1ModelsDisplayableObjectIdentifier]] $_viewableItems = @()
        $ApiResponse.RelativityApplications.ViewableItems | ForEach-Object {
            
            $_guids = @()
            $_.Guids | ForEach-Object {
                $_guids.Add($_)
            }

            $_viewableItems.Add([RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                $_.ArtifactID, 
                $_guids,
                $_.Name
            ))
        }

        $this.RelativityApplications = [RelativitySharedV1ModelsSecurableList]::New(
                $ApiResponse.RelativityApplications.HasSecuredItems,
                $_viewableItems 
            )
        #endregion RelativityApplications

        #region Shortcut
        [Collections.Generic.List[RelativityObjectModelV1SharedModelsModifierKey]] $_modifierKeys = @()
        $ApiResponse.Shortcut.ModifierKeys | ForEach-Object {
            if ([Enum]::IsDefined([RelativityObjectModelV1SharedModelsModifierKey], $_)) {
                $_modifierKeys.Add([Enum]::Parse([RelativityObjectModelV1SharedModelsModifierKey], $_))
            } else {
                throw "Invalid enum [RelativityObjectModelV1SharedModelsModifierKey] = $_"
            }
        }

        $this.Shortcut = [RelativityObjectModelV1SharedModelsShortcut]::New(
                $ApiResponse.Shortcut.MainKey, 
                $_modifierKeys
            )
        #endregion Shortcut

        
        if($ApiResponse.Source -ne $null)
        {
            $this.Source = [RelativityObjectModelV1FieldModelsFieldSource]::New(
                $ApiResponse.Source.FriendlyName, 
                $ApiResponse.Source.SourceName
            )
        }

        if($ApiResponse.Width -ne $null)
        {
            $this.Width = $ApiResponse.Width
        }

        $this.Wrapping = $ApiResponse.Wrapping
    }
}