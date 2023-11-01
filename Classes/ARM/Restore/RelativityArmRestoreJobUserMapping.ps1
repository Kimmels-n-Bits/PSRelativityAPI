class RelativityArmRestoreJobUserMapping
{
    [ValidateNotNull()]
    [Boolean] $AutoMapUsers
    [ValidateNotNull()]
    [Hashtable[]] $UserMappings

    RelativityArmRestoreJobUserMapping([Boolean] $autoMapUsers, [Hashtable[]] $userMappings)
    {
        $this.AutoMapUsers = $autoMapUsers
        $this.UserMappings = $userMappings
    }

    [Hashtable] ToHashTable()
    {
        return @{
            AutoMapUsers = $this.AutoMapUsers
            UserMappings = $this.UserMappings
        }
    }
}

