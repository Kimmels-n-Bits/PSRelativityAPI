class RelativityClientReadResponse : RelativityObjectBase
{
    [String] $Number
    [RelativityObjectBase] $Status
    [Boolean] $IsClientDomain
    [String] $Keywords
    [String] $Notes
    [DateTime] $CreatedOnDate
    [RelativityObjectBase] $CreatedBy
    [RelativityObjectBase] $LastModifiedBy
    [DateTime] $LastModifiedOnDate
    [RelativityClientMeta] $Meta
    [RelativityObjectAction[]] $Actions

    RelativityClientReadResponse (
        [PSCustomObject] $ApiResponse
    ) : base ($ApiResponse.ArtifactID, $ApiResponse.Name, $ApiResponse.Guids)
    {
        $this.Number = $ApiResponse.Number
        
        $this.Status = [RelativityObjectBase]::New(
            $ApiResponse.Status.ArtifactID,
            $ApiResponse.Status.Name,
            $ApiResponse.Status.Guids
        )

        $this.IsClientDomain = $ApiResponse.IsClientDomain
        $this.Keywords = $ApiResponse.Keywords
        $this.Notes = $ApiResponse.Notes
        $this.CreatedOnDate = $ApiResponse.CreatedOnDate
        
        $this.CreatedBy = [RelativityObjectBase]::New(
            $ApiResponse.CreatedBy.ArtifactID,
            $ApiResponse.CreatedBy.Name,
            $ApiResponse.CreatedBy.Guids
        )

        $this.LastModifiedBy = [RelativityObjectBase]::New(
            $ApiResponse.LastModifiedBy.ArtifactID,
            $ApiResponse.LastModifiedBy.Name,
            $ApiResponse.LastModifiedBy.Guids
        )

        $this.LastModifiedOnDate = $ApiResponse.LastModifiedOnDate

        $this.Meta = [RelativityClientMeta]::New(
            $ApiResponse.Meta.Unsupported,
            $ApiResponse.Meta.ReadOnly
        )

        $ActionsValue = New-Object "System.Collections.Generic.List[RelativityObjectAction]"

        $ApiResponse.Actions | ForEach-Object {
            $ActionsValue.Add([RelativityObjectAction]::New(
                    $_.Name,
                    $_.IsAvailable,
                    $_.Reason
                ))
        }
    }
}