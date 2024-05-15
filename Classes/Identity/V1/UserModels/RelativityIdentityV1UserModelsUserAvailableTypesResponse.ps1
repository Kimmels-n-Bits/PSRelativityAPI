class RelativityIdentityV1UserModelsUserAvailableTypesResponse
{
    <#
        .SYNOPSIS
            Represents a full list of available user types.
        .PARAMETER Types
            List of [ [Int32] ArtifactID, [String] Name, [Collections.Generic.List[Guid]] Guids ]
    #>
    [Collections.Generic.List[PSCustomObject]] $Types

    RelativityIdentityV1UserModelsUserAvailableTypesResponse (
        [PSCustomObject] $ApiResponse
    )
    {
        $this.Types = @()
        [Collections.Generic.List[Guid]] $_guids = @()
        
        $ApiResponse | ForEach-Object {
            $_guids = @()
            if ($_.Guids -ne $null)
            {
                $_.Guids | ForEach-Object {
                    $_guids.Add($_)
                }
            }
            $this.Types.Add([PSCustomObject]@{
                    ArtifactID = $_.ArtifactID
                    Name = $_.Name
                    Guids = $_guids
                }
            )
        }
    }
}