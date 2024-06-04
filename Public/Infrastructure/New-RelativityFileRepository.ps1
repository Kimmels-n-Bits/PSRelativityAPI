function New-RelativityFileRepository
{
    <#
        .SYNOPSIS
            Function creates a NEW Relativity file repository.
        .DESCRIPTION
            This function constructs the required request, 
            calls Relativity's REST API, 
            creates a file-respository, 
            and returns a [RelativityInfrastructureV1FileRespositoryNewResponse].

        .PARAMETER IsVisible
            na
        .PARAMETER Keywords
            optional words or phrase used to describe the file-respository.
        .PARAMETER Name
            user-friendly name of the file-respository.
        .PARAMETER Notes
            additional information about the file-respository.
        .PARAMETER UncPath
            A valid UNC Path with a trailing slash at the end.
            Path must be accessible to realtivity at time of creation.

        .EXAMPLE
            New-RelativityFileRepository -verbose -Name "myFileRepo" -UncPath "\\HOST-FS001\DevRepo\013\" -IsVisible
                This example will CREATE a new file-respository named "myFileRepo".

        .NOTES
            HTTP Response will be a [RelativityInfrastructureV1FileRespositoryNewResponse] object.
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
            $_path = [Management.Automation.WildcardPattern]::Escape($UncPath)

            [Hashtable]$RequestBody = @{
                request = @{
                    IsVisible = $IsVisible.IsPresent
                    Keywords = $Keywords
                    Name = $Name
                    Notes = $Notes
                    UncPath = $_path
                }
            }

            $Resources = @("workspace", "-1", "file-repository-servers")

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "Relativity.ResourceServers" `
                -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"

            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody
            Write-Debug $ApiResponse

            $Response = [RelativityInfrastructureV1FileRespositoryNewResponse]::New($ApiResponse)

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