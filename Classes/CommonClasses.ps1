#TODO: Implement RelativityObjectSecuredValue class
<#
    This replaces the RelativityAgentRequestSecuredValue class and classes dependent on that class will need to be
    refactored. This needs to support, at minimum, Int32, String, and RelativityObjectRef as types for the Value
    property.
    [Boolean] $Secured
    [Object] $Value
#>

class RelativityObjectRef
{
    [Int32] $ArtifactID

    RelativityObjectRef([Int32] $ArtifactID)
    {
        $this.ArtifactID = $ArtifactID
    }
}

class RelativityObjectBase : RelativityObjectRef
{
    [String] $Name
    [Guid[]] $Guids

    RelativityObjectBase(
        [Int32] $ArtifactID,
        [String] $Name,
        [Guid[]] $Guids
    ) : base ($ArtifactID)
    {
        $this.Name = $Name
        $this.Guids = $Guids
    }
}

#TODO: Modify the Relativity AgentManager class structure to use the RelativityObjectAction class instead of its own.
class RelativityObjectAction
{
    [String] $Name
    [Boolean] $IsAvailable
    [String[]] $Reason

    RelativityObjectAction([String] $Name, [Boolean] $IsAvailable, [String[]] $Reason)
    {
        $this.Name = $Name
        $this.IsAvailable = $IsAvailable
        $this.Reason = $Reason
    }
}

#TODO Implement RelativityObject class
<#
    Inherit from RelativityObjectBase
    [RelativityObjectRef] $ParentObject
    [RelativityFieldValuePair[]] $FieldValues
#>