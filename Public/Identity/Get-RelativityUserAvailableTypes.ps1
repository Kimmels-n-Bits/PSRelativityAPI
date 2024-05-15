function Get-RelativityUserAvailableTypes
{
    <#
        .SYNOPSIS
            Returns a Rlist of available user types.
        .DESCRIPTION
            Get-RelativityUserAvailableTypes returns the properties of a Relativity User object using Relativity's REST API.
        .EXAMPLE
            Get-RelativityUserAvailableTypes 
    #>
    [CmdletBinding()]
    Param ( )

    Begin
    {
        Write-Verbose "Starting $($MyInvocation.MyCommand.Name)"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("users", "available-types")

            [String] $QueryString = ""

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-identity" `
                -Version "v1" `
                -Resources $Resources `
                -QueryString $QueryString

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = [RelativityIdentityV1UserModelsUserAvailableTypesResponse]::New($ApiResponse)

            Write-Verbose "REST call details retrieved successfully."
            return $Response.Types
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