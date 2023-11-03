function Remove-RelativityAgent
{
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [Int32] $AgentID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $True)]
        [Switch] $Force
    )
    Process
    {
        try 
        {
            $Request = [RelativityagentDeleteRequest]::New($Force)

            $RequestBody = $Request.ToHashTable()

            [String[]] $Resources = @("workspace", "-1", "agents", $AgentID.ToString())

            $ApiEndpoint = Get-RelativityApiEndpoint -BusinessDomain "relativity.agents" -Resources $Resources

            Write-Debug "Prepaparing to invoke method with RequestBody $($RequestBody | ConvertTo-Json -Depth 3)"
            Write-Verbose "Invoking DELETE method at Relativity API endpoint: $($ApiEndpoint)"
            if ($PSCmdlet.ShouldProcess($ApiEndpoint))
            {
                $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Delete" -RequestBody $RequestBody
                Write-Verbose "Successfully deleted agent."
            }
            
            return $ApiResponse
        }
        catch 
        {
            Write-Debug "API Endpoint: $($ApiEndpoint)"
            Write-Debug "AgentID: $($AgentID)"
            Write-Debug "Force: $($Force)"
            throw
        }
    }
}