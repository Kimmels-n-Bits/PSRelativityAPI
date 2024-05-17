function Get-RelativityResourceServerType
{
    <#
        .SYNOPSIS
            Returns a list of all Relativity Resource Server Types
        .EXAMPLE
            Get-RelativityResourceServerType
            This returns a Relativity ServerTypeResponse.
    #>
    [CmdletBinding()]
    Param()

    Begin
    {
        Write-Verbose "Starting $($MyInvocation.MyCommand.Name)"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("workspaces", "-1", "resource-servers", "types")

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-infrastructure" `
                -Version "v1" `
                -Resources $Resources `
                -QueryString ""

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = [RelativityInfrastructureV1ResourceServerModelsServerTypeResponse]::New($ApiResponse)

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