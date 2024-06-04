function New-RelativityCacheLocation
{
    <#
        .SYNOPSIS
            Function creates a NEW Relativity cache-location.
        .DESCRIPTION
            This function constructs the required request, 
            calls Relativity's REST API, 
            creates a cache-location, 
            and returns a [RelativityInfrastructureV1CacheLocationServersNewResponse].

        .PARAMETER IsVisible
            na
        .PARAMETER Keywords
            optional words or phrase used to describe the cache-location.
        .PARAMETER Name
            user-friendly name of the cache-location.
        .PARAMETER Notes
            additional information about the cache-location.
        .PARAMETER UncPath
            A valid UNC Path with a trailing slash at the end.
            Path must be accessible to realtivity at time of creation.

        .EXAMPLE
            New-RelativityCacheLocation -verbose -Name "myCacheLoc" -UncPath "\\HOST-FS001\DevRepo\013\" -IsVisible
                This example will CREATE a new cache-location named "myCacheLoc".

        .NOTES
            HTTP Response will be a [RelativityInfrastructureV1CacheLocationServersNewResponse] object.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Switch] $IsVisible,
        [String] $Keywords,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [String] $Name,
        [string] $Notes,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateScript({
                $_ -match '^\\\\[^\\\/]+(\\[^\\\/]+)*\\$'
            })]
        [String] $UncPath
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
                request = @{
                    IsVisible = $IsVisible.IsPresent
                    Keywords = $Keywords
                    Name = $Name
                    Notes = $Notes
                    UncPath = [Management.Automation.WildcardPattern]::Escape($UncPath)
                }
            }

            $Resources = @("workspace", "-1", "cache-location-servers")

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "Relativity.ResourceServers" `
                -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"

            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody
            Write-Debug $ApiResponse

            $Response = [RelativityInfrastructureV1CacheLocationServersNewResponse]::New($ApiResponse)

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