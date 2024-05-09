class RelativityInfrastructureV1FileRespositoryServerModelsResponse : RelativitySharedV1ModelsDisplayableObjectIdentifier
{
    <#
        .SYNOPSIS
            Represents results of a read operation on a file repository server.
        .PARAMETER Actions
            Gets or sets a list of RESTful operations that a user has permissions to perform on the artifact.
        .PARAMETER CreatedBy
            Gets or sets the ID and name of the user who created the artifact.
        .PARAMETER CreatedOn
            Gets or sets the date and time when the artifact was added to Relativity.
        .PARAMETER FileAccessCredentials
            Gets or sets the information about file access credentials object.
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
    [RelativitySharedV1ModelsSecurable] $CreatedBy
    [DateTime] $CreatedOn
    [RelativitySharedV1ModelsSecurable] $FileAccessCredentials
    [Boolean] $IsVisible
    [String] $Keywords
    [RelativitySharedV1ModelsSecurable] $LastModifiedBy
    [DateTime] $LastModifiedOn
    [RelativitySharedV1ModelsMeta] $Meta
    [String] $Notes
    [RelativitySharedV1ModelsDisplayableObjectIdentifier] $Type
    [String] $UncPath

    RelativityInfrastructureV1FileRespositoryServerModelsResponse (
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


        #region FileAccessCredentials
        if($ApiResponse.FileAccessCredentials -ne $null)
        {
            if($ApiResponse.FileAccessCredentials.Value -ne $null)
            {
                $_guids = @()
                $ApiResponse.FileAccessCredentials.Value.Guids | ForEach-Object {
                    $_guids.Add($_)
                }

                $this.FileAccessCredentials = [RelativitySharedV1ModelsSecurable]::New(
                    $ApiResponse.FileAccessCredentials.Secured,
                    [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                        $ApiResponse.FileAccessCredentials.Value.ArtifactID, 
                        $_guids,
                        $ApiResponse.FileAccessCredentials.Value.Name
                    )
                )
            }
            else
            {
                $this.FileAccessCredentials = [RelativitySharedV1ModelsSecurable]::New($ApiResponse.FileAccessCredentials.Secured, $null)
            }
        }
        #endregion FileAccessCredentials

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

        $this.LastModifiedOn = $ApiResponse.LastModifiedOn

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
        $ApiResponse.Type.Guids | ForEach-Object {
            $_guids.Add($_)
        }
        $this.Type = [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
            $ApiResponse.Type.ArtifactId, 
            $_guids,
            $ApiResponse.Type.Name
        )

        $this.UncPath = $ApiResponse.UncPath
    }
}