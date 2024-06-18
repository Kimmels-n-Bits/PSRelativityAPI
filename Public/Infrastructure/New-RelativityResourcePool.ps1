function New-RelativityResourcePool
{
    <#
        .SYNOPSIS
            Function creates a NEW resource pool.
        .DESCRIPTION
            This function constructs the required request, 
            calls Relativity's REST API, 
            creates a resource pool, 
            and returns a [RelativityInfrastructureV1ResourcePoolModelsResponse].

        .PARAMETER ClientID
            Client ID to associate with the Resource Pool
        .PARAMETER IsVisible
            Gets or sets a value indicating whether the resource pool should be available for selection in the workspace creation workflow.
        .PARAMETER Keywords
            Gets or sets the keywords associated with the artifact.
        .PARAMETER Name
            Resource Pool name.
        .PARAMETER Notes
            Gets or sets an optional description or other information about the artifact.


        .EXAMPLE
            New-RelativityResourcePool -ClientID 1234567 -Name "myPool" -IsVisible -Keywords "test, black, blue" -Notes ""
                This example will CREATE a new resource pool named "myPool", visibility enabled.
                It also includes optional keywords and notes.

        .NOTES
            HTTP Response will be a [RelativityInfrastructureV1ResourcePoolModelsResponse] object.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $ClientID,
        [Switch] $IsVisible,
        [String] $Keywords,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [String] $Name,
        [string] $Notes
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
                resourcePoolRequest = @{
                    Client = @{
                        Value = @{
                            ArtifactID = $ClientID
                        }
                    }
                    IsVisible = $IsVisible.IsPresent
                    Keywords = $Keywords
                    Name = $Name
                    Notes = $Notes
                }
            }

            $Resources = @("workspaces", "-1", "resource-pools")

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-infrastructure" `
                -Version "v1" `
                -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"

            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody
            $Response = [RelativityInfrastructureV1ResourcePoolModelsResponse]::New($ApiResponse)

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