class RelativityInfrastructureV1ResourceServerModelsServerTypeResponse
{
    <#
        .SYNOPSIS
            Represents a full list of resource server types.
        .PARAMETER Types
            List of [ [Int32] ArtifactID, [String] Name, [String] Url ]
    #>
    [Collections.Generic.List[PSCustomObject]] $Types

    RelativityInfrastructureV1ResourceServerModelsServerTypeResponse (
        [PSCustomObject] $ApiResponse
    )
    {
        $this.Types = @()
        $ApiResponse | ForEach-Object {
            $this.Types.Add([PSCustomObject]@{
                    ArtifactID = $_.ArtifactID
                    Name = $_.Name
                    SystemArtifactIdentifier = $_.SystemArtifactIdentifier
                    Url = $_.Url
                }
            )
        }
    }
}