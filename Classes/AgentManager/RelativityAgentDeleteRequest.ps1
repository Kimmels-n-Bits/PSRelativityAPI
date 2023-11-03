class RelativityAgentDeleteRequest
{
    [Boolean] $Force

    RelativityAgentDeleteRequest([Boolean] $force)
    {
        $this.Force = $force
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("Force", $this.Force)

        return $ReturnValue
    }
}