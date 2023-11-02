class RelativityArmRestoreJobGroupMapping
{
    [ValidateNotNull()]
    [Boolean] $AutoMapGroups
    [ValidateNotNull()]
    [Hashtable[]] $GroupMappings

    RelativityArmRestoreJobGroupMapping([Boolean] $autoMapGroups, [Hashtable[]] $groupMappings)
    {
        $this.AutoMapGroups = $autoMapGroups
        $this.GroupMappings = $groupMappings
    }

    [Hashtable] ToHashTable()
    {
        return @{
            AutoMapGroups = $this.AutoMapGroups
            GroupMappings = $this.GroupMappings
        }
    }
}

