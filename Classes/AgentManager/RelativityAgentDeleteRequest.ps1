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

        if ($this.Force -eq $false)
        {
            return $ReturnValue
        }
        else
        {
            $ReturnValue.Add("force", $this.Force)

            return $ReturnValue
        }
    }
}