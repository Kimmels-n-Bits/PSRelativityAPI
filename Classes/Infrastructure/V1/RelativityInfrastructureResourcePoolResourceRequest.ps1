class RelativityInfrastructureResourcePoolResourceRequest
{
    <#
    .SYNOPSIS
        Request body for Get-RelativityResourcePoolResource

    .DESCRIPTION
        This function constructs the required request and returns a valid body.

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
    #>
    [Collections.Generic.List[String]] $Fields
    [Int32] $Length
    [String] $ResourceType
    [Int32] $Start
    
    RelativityInfrastructureResourcePoolResourceRequest()
    {

    }

    RelativityInfrastructureResourcePoolResourceRequest([String] $ResourceType, [Int32] $Start, [Int32] $Length)
    {
        $this.ResourceType = $ResourceType.ToLower()
        switch ($this.ResourceType) {
            "file-repositories" {
                $this.Fields = @('Name', 'URL')
            }
            "cache-location-servers" {
                $this.Fields = @('Name', 'URL')
            }
            "agent-worker-servers" {
                $this.Fields = @('Name', 'Type', 'Status', 'Version')
            }
            "sql-servers" {
                $this.Fields = @('Name', 'Type', 'Status', 'Version')
            }
            "analytics-servers" {
                $this.Fields = @('Name', 'Type', 'Status', 'Analytics operation', 'URL', 'Version')
            }
            "dt-search-index-locations" {
                $this.Fields = @('Name')
            }
            "processing-source-locations" {
                $this.Fields = @('Name')
            }
            "worker-manager-servers" {
                $this.Fields = @('Name', 'URL', 'Version')
            }
            Default {
                $this.Fields = @('Name', 'Type', 'Status', 'Analytics operation', 'URL', 'Version')
            }
        }

        $this.Start = $Start
        $this.Length = $Length
    }

    [Hashtable] ToHashTable()
    {
        $hashtable = @{}

        $request = @{}
        $request["condition"] = ""
        $request["convertNumberFieldValuesToString"] = $true
        $request["fields"] = @()

        $this.Fields | ForEach-Object {
            $_field = @{}
            Write-Verbose "Creating Field: $_"
            $_field["Name"] = $_
            $request["fields"] += $_field
        }

        $request["rowCondition"] = ""
        $request["sorts"] = @()


        $hashtable["request"] += $request
        $hashtable["start"] += $this.Start
        $hashtable["length"] += $this.Length

        return $hashtable
    }
}
