class RelativityArmRestoreJobApplication 
{
    [ValidateNotNull()]
    [Guid] $Guid
    [ValidateNotNull()]
    [Boolean] $ShouldRestore

    RelativityArmRestoreJobApplication([Guid] $guid, [Boolean] $shouldRestore)
    {
        $this.Guid = $guid
        $this.ShouldRestore = $shouldRestore
    }

    [Hashtable] ToHashTable()
    {
        return @{
            Guid = $this.Guid
            ShouldRestore = $this.ShouldRestore
        }
    }
}

