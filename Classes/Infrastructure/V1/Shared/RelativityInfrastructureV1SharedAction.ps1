class RelativityInfrastructureV1SharedAction
{
    [String] $Href
    [Boolean] $IsAvailable
    [String] $Name
    [Collections.Generic.List[String]] $Reason
    [String] $Verb

    RelativityInfrastructureV1SharedAction()
    {
    }

    RelativityInfrastructureV1SharedAction(
        [String] $Href,
        [Boolean] $IsAvailable,
        [String] $Name,
        [Collections.Generic.List[String]] $Reason,
        [String] $Verb
    )
    {
        $this.Href = $Href
        $this.IsAvailable = $IsAvailable
        $this.Name = $Name
        $this.Reason = $Reason
        $this.Verb = $Verb
    }
}