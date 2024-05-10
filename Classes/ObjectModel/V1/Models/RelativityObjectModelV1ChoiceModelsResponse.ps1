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
        
        $this.Color = [RelativityObjectModelV1ChoiceModelsColor]::New(
                            $ApiResponse.Color.ID,
                            $ApiResponse.Color.Name
                        )

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

        $_guids = @()
        $ApiResponse.Field.Guids | ForEach-Object {
            $_guids.Add($_)
        }
        $this.Field = [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                        $ApiResponse.Field.ArtifactID, 
                        $_guids,
                        $ApiResponse.Field.Name
                    )

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

        #region Meta
        Write-Verbose "Processing [Meta]"
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
        
        $this.ObjectVersionToken = $ApiResponse.ObjectVersionToken

        $this.Order = $ApiResponse.Order

        $this.Parent = $ApiResponse.Parent

        #region RelativityApplications
        Write-Verbose "Processing [RelativityApplications]"
        if($ApiResponse.RelativityApplications -ne $null)
        {
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
        }
        #endregion RelativityApplications

        #region Shortcut
        Write-Verbose "Processing [Shortcut]"
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
    }
}