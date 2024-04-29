<#
.SYNOPSIS
Makes an API request to the specified Relativity endpoint.

.DESCRIPTION
Constructs and sends an API request to the given Relativity endpoint, using the specified HTTP method and request body.

.PARAMETER ApiEndpoint
The specific API endpoint to which the request is to be made.

.PARAMETER HttpMethod
The HTTP method to use for the API request.

.PARAMETER RequestBody
A hashtable containing the request body to be sent with the API request.

.NOTES
This function is internal and is the primary method for making API calls to the Relativity system.
#>
function Invoke-RelativityApiRequest
{
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $ApiEndpoint,
        [Parameter(Mandatory = $true)]
        [ValidateSet("Post", "Get", "Put", "Delete")]
        [String] $HttpMethod,
        [Parameter(Mandatory = $false)]
        [Hashtable] $RequestBody
    )

    Begin
    {
        Write-Verbose "Starting Invoke-RelativityApiRequest"
    }
    Process
    {
        if ($null -eq $script:RelativityBaseUri)
        {
            throw "RelativityBaseUri is not set. Please run Set-RelativityBaseUri before proceeding."
        }

        if ($null -eq $script:RelativityCredential)
        {
            throw "RelativityCredential is not set. Please run Set-RelativityCredential before proceeding."
        }

        $RequestHeader = Get-RelativityApiRequestHeader

        try
        {
            $RequestBodyJson = $RequestBody | ConvertTo-Json -Depth 10
        }
        catch
        {
            throw "Error parsing request body to JSON: $($_.Exception.Message)"
        }

        try
        {
            $Response = switch ($HttpMethod)
            {
                "Post"
                {
                    Invoke-WebRequest `
                        -Uri $ApiEndpoint `
                        -Method Post `
                        -Headers $RequestHeader `
                        -Body $RequestBodyJson `
                        -ContentType "application/json"
                }
                "Get"
                {
                    Invoke-WebRequest `
                        -Uri $ApiEndpoint `
                        -Method Get `
                        -Headers $RequestHeader
                }
                "Put"
                {
                    Invoke-WebRequest `
                        -Uri $ApiEndpoint `
                        -Method Put `
                        -Headers $RequestHeader `
                        -Body $RequestBodyJson `
                        -ContentType "application/json"
                }
                "Delete"
                {
                    if ($null -eq $RequestBody)
                    {
                        Invoke-WebRequest `
                            -Uri $ApiEndpoint `
                            -Method Delete `
                            -Headers $RequestHeader
                    }
                    else
                    {
                        Invoke-WebRequest `
                            -Uri $ApiEndpoint `
                            -Method Delete `
                            -Headers $RequestHeader `
                            -Body $RequestBody `
                            -ContentType "application/json"
                    }
                }
            }
        }
        catch [System.Net.WebException]
        {
            if ($null -ne $_.Exception.Response)
            {
                $ResponseStream = $_.Exception.Response.GetResponseStream()

                if ($null -ne $ResponseStream)
                {
                    try
                    {
                        $StreamReader = [System.IO.StreamReader]::New($ResponseStream)
                        $ErrorMessage = $StreamReader.ReadToEnd()

                        if ($ErrorMessage)
                        {
                            try
                            {
                                $ErrorObject = $ErrorMessage | ConvertFrom-Json
                                Write-Error "API Error: $($ErrorObject.Message)"
                            }
                            catch
                            {
                                Write-Error "API Error: $($ErrorMessage)"
                            }
                        }
                        else
                        {
                            Write-Error "API Error: No message was provided."
                        }
                    }
                    finally
                    {
                        if ($null -ne $StreamReader)
                        {
                            $StreamReader.Close()
                            $StreamReader.Dispose()
                        }
                    }
                }
                else
                {
                    Write-Error "API Error: No response stream available."
                }
            }
            else
            {
                Write-Error "An unexpected error occurred: $($_)"
            }

            throw
        }
        catch
        {
            throw
        }

        try
        {
            $ApiResponse = $Response.Content | ConvertFrom-Json
        }
        catch
        {
            throw "Error parsing API response: $($_.Exception.Message)"
        }

        if (-not $ApiResponse)
        {
            $ApiResponse = [PSCustomObject]@{ Success = $true }
        }

        return $ApiResponse
    }
    End
    {
        Write-Verbose "Completed Invoke-RelativityApiRequest"
    }
}