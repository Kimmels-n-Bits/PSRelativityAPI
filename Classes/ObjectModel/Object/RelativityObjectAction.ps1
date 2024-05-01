#TODO: Modify the Relativity AgentManager class structure to use the RelativityObjectAction class as a base class.
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