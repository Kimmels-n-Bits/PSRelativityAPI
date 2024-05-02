class RelativityInfrastructureV1ResourcePoolModelsResponse : RelativityInfrastructureV1SharedObjectIdentifier
{
    [Collections.Generic.List[RelativityInfrastructureV1SharedAction]] $Actions
    [RelativityInfrastructureV1SharedDisplayableObjectIdentifier] $Client
    [RelativityInfrastructureV1SharedDisplayableObjectIdentifier] $CreatedBy
    [DateTime] $CreatedOnDate
    [Boolean] $IsVisible
    [String] $Keywords
    [RelativityInfrastructureV1SharedDisplayableObjectIdentifier] $LastModifiedBy
    [DateTime] $LastModifiedOnDate
    [RelativityInfrastructureV1SharedMeta] $Meta
    [String] $Notes

    RelativityInfrastructureV1ResourcePoolModelsResponse (
        [PSCustomObject] $ApiResponse
    ):base ($ApiResponse)
    {
        $this.Actions = @()
        $ApiResponse.Actions | ForEach-Object {
            [Collections.Generic.List[String]] $ActionReasons = @()
            
            $_.Reason | ForEach-Object {
                $ActionReasons.Add($_)
            }

            $this.Actions.Add([RelativityIdentityV1SharedAction]::New(
                    $_.Href,
                    $_.IsAvailable,
                    $_.Name,
                    $ActionReasons,
                    $_.Verb
                ))
        }

        [Collections.Generic.List[Guid]] $CreatedByGuids = @()

        $ApiResponse.CreatedBy.Guids | ForEach-Object {
            $CreatedByGuids.Add($_)
        }

        $this.CreatedBy = [RelativityIdentityV1SharedDisplayableObjectIdentifier]::New(
            $ApiResponse.CreatedBy.ArtifactID,
            $CreatedByGuids,
            $ApiResponse.CreatedBy.Name
        )

        $this.CreatedOnDate = $ApiResponse.CreatedOnDate

        $this.IsClientDomain = $ApiResponse.IsClientDomain

        $this.Keywords = $ApiResponse.Keywords

        [Collections.Generic.List[Guid]] $LastModifiedByGuids = @()

        $ApiResponse.LastModifiedBy.Guids | ForEach-Object {
            $LastModifiedByGuids.Add($_)
        }

        $this.LastModifiedBy = [RelativityIdentityV1SharedDisplayableObjectIdentifier]::New(
            $ApiResponse.LastModifiedBy.ArtifactID,
            $LastModifiedByGuids,
            $ApiResponse.LastModifiedBy.Name
        )

        $this.LastModifiedOnDate = $ApiResponse.LastModifiedOnDate

        [Collections.Generic.List[String]] $MetaReadOnly = @()

        $ApiResponse.Meta.ReadOnly | ForEach-Object {
            $MetaReadOnly.Add($_)
        }

        [Collections.Generic.List[String]] $MetaUnsupported = @()

        $ApiResponse.Meta.Unsupported | ForEach-Object {
            $MetaUnsupported.Add($_)
        }

        $this.Meta = [RelativityIdentityV1SharedMeta]::New(
            $MetaReadOnly,
            $MetaUnsupported
        )

        $this.Name = $ApiResponse.Name

        $this.Notes = $ApiResponse.Notes

        $this.Number = $ApiResponse.Number
        
        [Collections.Generic.List[Guid]] $StatusGuids = @()

        $ApiResponse.Status.Guids | ForEach-Object {
            $StatusGuids.Add($_)
        }

        $this.Status = [RelativityIdentityV1SharedDisplayableObjectIdentifier]::New(
            $ApiResponse.Status.ArtifactID,
            $StatusGuids,
            $ApiResponse.Status.Name
        )
    }
}