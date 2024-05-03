class RelativityInfrastructureV1SharedAction
{
    <#
        .SYNOPSIS
            An action that can be performed on the given static object.
        .PARAMETER Href
            The url for the Kepler service that performs this action.
        .PARAMETER IsAvailable
            Whether or not the action is available on the given static object.
        .PARAMETER Name
            The action the user has permission to perform on the given static object.
        .PARAMETER Reason
            Reasons the action may not be available.
        .PARAMETER Verb
            The HTTP verb to use when calling the Kepler service to perform the action.
    #>
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