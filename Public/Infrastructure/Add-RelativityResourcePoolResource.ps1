function Add-RelativityResourcePoolResource
{
    <#
        .SYNOPSIS
            Function to add resource objects to a resource pool.
        .DESCRIPTION
            This function constructs the required request, calls Relativity's REST API, adds resources, and returns an HTTP Status Code.

        .PARAMETER ArtifactID
            ArtifactID for the Resource pool being added to.
        .PARAMETER ResourceArtifactIDs
            Comma Delimited list of artifact IDs to be added. These must be of the same resource type.
        .PARAMETER ResourceType
            Identifies 1 of 8 ResourceTypes that [ResourceArtifactIDs] will be added to.
                "agent-worker-servers"
                "analytics-servers"
                "cache-location-servers"
                "dt-search-index-locations"
                "file-repositories"
                "processing-source-locations"
                "sql-servers"
                "worker-manager-servers"

        .EXAMPLE
            Add-RelativityResourcePoolResource -ArtifactID 1234567 -ResourceType "file-repositories" -ResourceArtifactIDs 1058334, 1058335
            Add-RelativityResourcePoolResource -ArtifactID 1234567 -ResourceType "file-repositories" -ResourceArtifactIDs @(1058334, 1058335)
                This example will ADD list of file repositories resources to the Resource Pool ID 1234567.

        .NOTES
            na
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $ArtifactID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32[]] $ResourceArtifactIDs,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateSet('file-repositories',
            'cache-location-servers',
            'agent-worker-servers',
            'sql-servers',
            'analytics-servers',
            'dt-search-index-locations',
            'processing-source-locations',
            'worker-manager-servers', IgnoreCase = $true)]
        [String] $ResourceType
    )

    Begin
    {
        Write-Verbose "Starting $($MyInvocation.MyCommand.Name)"
    }
    Process
    {
        try
        {
            [Hashtable]$RequestBody = @{
                resources = @()
            }

            foreach($resourceID in $ResourceArtifactIDs){
                $RequestBody.resources += @{
                    ArtifactID = $resourceID
                }
            }

            $Resources = @("workspace", "-1", "resource-pools", $ArtifactID.ToString(), $ResourceType.ToString(), "add")

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "Relativity.ResourcePools" `
                -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"

            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody
            return $ApiResponse
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "Logging parameter values:"

            (Get-Command -Name $PSCmdlet.MyInvocation.InvocationName).Parameters | ForEach-Object {
                $_.Values | ForEach-Object {
                    $Parameter = Get-Variable -Name $_.Name -ErrorAction SilentlyContinue

                    if ($null -ne $Parameter)
                    {
                        Write-Verbose "$($Parameter.Name): $($Parameter.Value)"
                    }
                }
            }

            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed $($MyInvocation.MyCommand.Name)"
    }
}