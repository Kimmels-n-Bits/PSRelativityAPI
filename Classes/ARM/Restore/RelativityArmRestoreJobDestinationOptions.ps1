class RelativityArmRestoreJobDestinationOptions 
{
    [ValidateNotNull()]
    [Int32] $DatabaseServerID
    [ValidateNotNull()]
    [Int32] $ResourcePoolID
    [ValidateNotNull()]
    [Int32] $MatterID
    [ValidateNotNull()]
    [Int32] $CacheLocationID
    [ValidateNotNull()]
    [Int32] $FileRepositoryID

    RelativityArmRestoreJobDestinationOptions([Int32] $databaseServerID, [Int32] $resourcePoolID, [Int32] $matterID, [Int32] $cacheLocationID, [Int32] $fileRepositoryID)
    {
        $this.DatabaseServerID = $databaseServerID
        $this.ResourcePoolID = $resourcePoolID
        $this.MatterID = $matterID
        $this.CacheLocationID = $cacheLocationID
        $this.FileRepositoryID = $fileRepositoryID
    }

    [Hashtable] ToHashTable()
    {
        return @{
            DatabaseServerID = $this.DatabaseServerID
            ResourcePoolID = $this.ResourcePoolID
            MatterID = $this.MatterID
            CacheLocationID = $this.CacheLocationID
            FileRepositoryID = $this.FileRepositoryID
        }
    }
}

