class RelativityArmRestoreJobMigratorsDestinationOptions
{
    [Int32] $StructuredAnalyticsServerID
    [Int32] $ConceptualAnalyticsServerID
    [Int32] $DtSearchLocationID

    RelativityArmRestoreJobMigratorsDestinationOptions([Int32] $structuredAnalyticsServerID, [Int32] $conceptualAnalyticsServerID, [Int32] $dtSearchLocationID)
    {
        $this.StructuredAnalyticsServerID = $structuredAnalyticsServerID
        $this.ConceptualAnalyticsServerID = $conceptualAnalyticsServerID
        $this.DtSearchLocationID = $dtSearchLocationID
    }

    [Hashtable] ToHashTable()
    {
        return @{
            StructuredAnalyticsServerID = $this.StructuredAnalyticsServerID
            ConceptualAnalyticsServerID = $this.ConceptualAnalyticsServerID
            DtSearchLocationID = $this.DtSearchLocationID
        }
    }
}

