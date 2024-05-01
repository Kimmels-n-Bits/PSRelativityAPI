class RelativityObjectManagerV1ModelsSearchProviderConditions
{
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