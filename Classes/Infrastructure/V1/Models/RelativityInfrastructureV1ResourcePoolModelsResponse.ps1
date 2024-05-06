class RelativityInfrastructureV1ResourcePoolModelsResponse : RelativityInfrastructureV1SharedDisplayableObjectIdentifier
{
    [Collections.Generic.List[RelativityInfrastructureV1SharedAction]] $Actions
    [RelativitySharedV1ModelsSecurable] $Client
    [RelativitySharedV1ModelsSecurable] $CreatedBy
    [DateTime] $CreatedOnDate
    [Boolean] $IsVisible
    [String] $Keywords
    [RelativitySharedV1ModelsSecurable] $LastModifiedBy
    [DateTime] $LastModifiedOnDate
    [RelativityInfrastructureV1SharedMeta] $Meta
    [String] $Notes

    RelativityInfrastructureV1ResourcePoolModelsResponse (
        [PSCustomObject] $ApiResponse
    ):base ($ApiResponse.ArtifactID, $ApiResponse.Guids, $ApiResponse.Name)
    {
        $this.Actions = @()
        $ApiResponse.Actions | ForEach-Object {
            [Collections.Generic.List[String]] $ActionReasons = @()
            
            $_.Reason | ForEach-Object {
                $ActionReasons.Add($_)
            }

            $this.Actions.Add([RelativityInfrastructureV1SharedAction]::New(
                    $_.Href,
                    $_.IsAvailable,
                    $_.Name,
                    $ActionReasons,
                    $_.Verb
                ))
        }

        $this.Client = [RelativitySharedV1ModelsSecurable]::New(
            $ApiResponse.Client.Secured,
            $ApiResponse.Client.Value
        )

        $this.CreatedBy = [RelativitySharedV1ModelsSecurable]::New(
            $ApiResponse.CreatedBy.Secured,
            $ApiResponse.CreatedBy.Value
        )

        $this.CreatedOnDate = $ApiResponse.CreatedOn

        $this.IsVisible = $ApiResponse.IsVisible

        $this.Keywords = $ApiResponse.Keywords

        $this.LastModifiedBy = [RelativitySharedV1ModelsSecurable]::New(
            $ApiResponse.LastModifiedBy.Secured,
            $ApiResponse.LastModifiedBy.Value
        )

        $this.LastModifiedOnDate = $ApiResponse.LastModifiedOn


        [Collections.Generic.List[String]] $MetaReadOnly = @()
        $ApiResponse.Meta.ReadOnly | ForEach-Object {
            $MetaReadOnly.Add($_)
        }

        [Collections.Generic.List[String]] $MetaUnsupported = @()
        $ApiResponse.Meta.Unsupported | ForEach-Object {
            $MetaUnsupported.Add($_)
        }

        $this.Meta = [RelativityInfrastructureV1SharedMeta]::New(
            $MetaReadOnly,
            $MetaUnsupported
        )

        $this.Notes = $ApiResponse.Notes
    }
}