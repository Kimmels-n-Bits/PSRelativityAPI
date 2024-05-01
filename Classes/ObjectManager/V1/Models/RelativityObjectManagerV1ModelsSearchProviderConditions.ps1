class RelativityObjectManagerV1ModelsSearchProviderConditions
{
    <#
        .SYNOPSIS
            Contains the parameters used to execute a query through a search provider.
        .PARAMETER Input
            Gets or sets a string containing the parameters used for a search provider, which were entered by a user.
        .PARAMETER SearchIndex
            Gets or sets the Artifact ID of the search provider.
    #>
    [String] $Input
    [RelativityObjectManagerV1ModelsSearchIndexRef] $SearchIndex

    RelativityObjectManagerV1ModelsSearchProviderConditions()
    {
    }

    RelativityObjectManagerV1ModelsSearchProviderConditions(
        [String] $Input,
        [RelativityObjectManagerV1ModelsSearchIndexRef] $SearchIndex
    )
    {
        $this.Input = $Input
        $this.SearchIndex = $SearchIndex
    }
}