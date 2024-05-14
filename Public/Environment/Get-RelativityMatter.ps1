function Get-RelativityMatter
{
    <#
        .SYNOPSIS
            Returns a Relativity RelativityEnvironmentV1MatterModelsResponse Object
        .DESCRIPTION
            Get-RelativityMatter returns the properties of a Relativity [RelativityEnvironmentV1MatterModelsResponse] object using Relativity's REST API.
        .PARAMETER ArtifactID
            {Artifact ID} to the specific matter.
        .PARAMETER IncludeMetadata
            Determines whether to include extended metadata for the returned MatterResponse object.
        .PARAMETER IncludeActions
            Determines whether to include actions associated with the returned MatterResponse object.
        .EXAMPLE
            Get-RelativityMatter -ArtifactID 1234567 -IncludeMetadata -IncludeActions
            This returns a Relativity RelativityEnvironmentV1MatterModelsResponse with the -ArtifactID value 1234567 and includes extended metadata and
            actions.
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateScript({ $_ -is [Int32] })]
        [Int32] $ArtifactID,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeMetadata,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeActions
    )

    Begin
    {
        Write-Verbose "Starting $($MyInvocation.MyCommand.Name)"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("workspaces", "-1", "matters", $ArtifactID.ToString(), $IncludeMetadata, $IncludeActions)

            #[String] $QueryString = "$IncludeMetadata/$IncludeActions"

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-environment" `
                -Version "v1" `
                -Resources $Resources `
                -QueryString ""

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"
            Write-Debug "ApiResponse`n$($ApiResponse)"

            $Response = [RelativityEnvironmentV1MatterModelsResponse]::New($ApiResponse)

            Write-Verbose "REST call details retrieved successfully."
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