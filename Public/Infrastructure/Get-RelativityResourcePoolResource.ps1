function Get-RelativityResourcePoolResource
{
    <#
    .SYNOPSIS
        Function to query resource pool resources using Relativity's REST API.

    .DESCRIPTION
        This function constructs the required request, calls Relativity's REST API, and returns a QuerySlim Response.

    .PARAMETER ArtifactID
        Switch to indicate if the current user has permission to view the setting in the Value field for AgentType.
    .PARAMETER Length
        Array length for number of rows returned by query.
    .PARAMETER ResourceType
        Identifies 1 of 8 ResourceTypes that can be queried.
            "agent-worker-servers"
            "analytics-servers"
            "cache-location-servers"
            "dt-search-index-locations"
            "file-repositories"
            "processing-source-locations"
            "sql-servers"
            "worker-manager-servers"
    .PARAMETER Start
        Array Index for query return.

    .EXAMPLE
        Get-RelativityResourcePoolResource -verbose -ArtifactID 1234567 -Start 1 -Length 10 -ResourceType "file-repositories"
            This example will return a list of file repositories for Resource Pool ID 1234567.
            It will contain ('Name', 'URL') fields.

    .NOTES
        At this time, returned [Fields] are statically defined in [RelativityInfrastructureResourcePoolResourceRequest].
        They will have slight differences based on [ResourceType]
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
        [Int32] $Start,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $Length,
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
            $Request = [RelativityInfrastructureResourcePoolResourceRequest]::New($ResourceType, $Start, $Length)
            $RequestBody = $Request.ToHashTable()

            $Resources = @("workspaces", "-1", "resource-pools", $ArtifactID.ToString(), $ResourceType.ToString(), "query-associated")

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-infrastructure" `
                -Version "v1" `
                -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"

            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody
            $Response = [RelativityInfrastructureV1SharedQueryResultSlim]::New($ApiResponse)

            return $Response
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