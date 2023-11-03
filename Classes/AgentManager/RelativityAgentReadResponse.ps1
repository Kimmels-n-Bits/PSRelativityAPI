class RelativityAgentReadResponseValue
{
    [Int32] $ArtifactID    
    [String] $Name

    RelativityAgentReadResponseValue([Int32] $artifactID, [String] $name)
    {
        $this.ArtifactID = $artifactID
        $this.Name = $name
    }
}

class RelativityAgentReadResponseSecuredValue
{
    [Boolean] $Secured    
    [RelativityAgentReadResponseValue] $Value

    RelativityAgentReadResponseSecuredValue([Boolean] $secured, [RelativityAgentReadResponseValue] $value)
    {
        $this.Secured = $secured
        $this.Value = $value
    }
}

class RelativityAgentReadResponseMeta
{
    [String[]] $Unsupported
    [String[]] $ReadOnly
    
    RelativityAgentReadResponseMeta([String[]] $unsupported, [String[]] $readOnly)
    {
        $this.Unsupported = $unsupported
        $this.ReadOnly = $readOnly
    }
}

class RelativityAgentReadResponseAction
{
    [String] $Name
    [String] $Href
    [String] $Verb
    [Boolean] $IsAvailable
    [String[]] $Reason

    RelativityAgentReadResponseAction([String] $name, [String] $href, [String] $verb, [Boolean] $isAvailable, [String[]] $reason)
    {
        $this.Name = $name
        $this.Href = $href
        $this.Verb = $verb
        $this.IsAvailable = $isAvailable
        $this.Reason = $reason
    }
}

class RelativityAgentReadResponse
{
    [RelativityAgentReadResponseSecuredValue] $AgentType
    [RelativityAgentReadResponseSecuredValue] $AgentServer
    [Boolean] $Enabled
    [Double] $Interval
    [DateTime] $LastUpdate
    [Int32] $LoggingLevel
    [String] $Message
    [String] $DetailMessage
    [String] $EventLevel
    [DateTime] $CreatedOn
    [RelativityAgentReadResponseValue] $CreatedBy
    [RelativityAgentReadResponseValue] $LastModifiedBy
    [DateTime] $LastModifiedOn
    [String] $Keywords
    [String] $Notes
    [RelativityAgentReadResponseMeta] $Meta
    [RelativityAgentReadResponseAction[]] $Actions
    [Int32] $ArtifactID
    [String] $Name

    RelativityAgentReadResponse([PSCustomObject] $ApiResponse)
    {
        [RelativityAgentReadResponseValue] $AgentTypeValue = [RelativityAgentReadResponseValue]::New(
            $ApiResponse.AgentType.Value.ArtifactID,
            $ApiResponse.AgentType.Value.Name
        )

        $this.AgentType = [RelativityAgentReadResponseSecuredValue]::New(
            $ApiResponse.AgentType.Secured,
            $AgentTypeValue
        )

        [RelativityAgentReadResponseValue] $AgentServerValue = [RelativityAgentReadResponseValue]::New(
            $ApiResponse.AgentServer.Value.ArtifactID,
            $ApiResponse.AgentServer.Value.Name
        )

        $this.AgentServer = [RelativityAgentReadResponseSecuredValue]::New(
            $ApiResponse.AgentServer.Secured,
            $AgentServerValue
        )

        $this.Enabled = $ApiResponse.Enabled
        $this.Interval = [Double]::Parse($ApiResponse.Interval)
        $this.LastUpdate = [DateTime]::Parse($ApiResponse.LastUpdate)
        $this.LoggingLevel = $ApiResponse.LoggingLevel
        $this.Message = $ApiResponse.Message
        $this.DetailMessage = $ApiResponse.DetailMessage
        $this.EventLevel = $ApiResponse.EventLevel
        $this.CreatedOn = [DateTime]::Parse($ApiResponse.CreatedOn)
        
        $this.CreatedBy = [RelativityAgentReadResponseValue]::New(
            $ApiResponse.CreatedBy.ArtifactID,
            $ApiResponse.CreatedBy.Name
        )

        $this.LastModifiedBy = [RelativityAgentReadResponseValue]::New(
            $ApiResponse.LastModifiedBy.ArtifactID,
            $ApiResponse.LastModifiedBy.Name
        )

        $this.LastModifiedOn = [DateTime]::Parse($ApiResponse.LastModifiedOn)
        $this.Keywords = $ApiResponse.Keywords
        $this.Notes = $ApiResponse.Notes

        if ($null -ne $ApiResponse.Meta)
        {
            $this.Meta = [RelativityAgentReadResponseMeta]::New(
                $ApiResponse.Meta.Unsupported,
                $ApiResponse.Meta.ReadOnly
            )
        }

        $this.Actions = @()
        
        $ApiResponse.Actions | ForEach-Object {
            $this.Actions += [RelativityAgentReadResponseAction]::New($_.Name, $_.Href, $_.Verb, $_.IsAvailable, $_.Reason)
        }

        $this.ArtifactID = $ApiResponse.ArtifactID
        $this.Name = $ApiResponse.Name
    }
}
