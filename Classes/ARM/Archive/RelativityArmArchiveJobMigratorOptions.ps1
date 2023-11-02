<#
.SYNOPSIS
Represents migrator options for an ARM archive job.

.DESCRIPTION
This class defines various options related to what data migrators should be included in the archive.

.PARAMETER IncludeDatabaseBackup
Indicates if the workspace database backup is included in the archive.

.PARAMETER IncludeDtSearch
Indicates whether dtSearch indices will be included in the archive directory.

.PARAMETER IncludeConceptualAnalytics
Indicates whether Conceptual Analytics indices will be included in the archive directory.

.PARAMETER IncludeStructuredAnalytics
Indicates whether Structured Analytics sets will be included in the archive directory.

.PARAMETER IncludeDataGrid
Indicates whether Data Grid application data will be present in the archive directory.
#>
class RelativityArmArchiveJobMigratorOptions
{
    [ValidateNotNull()]
    [Boolean] $IncludeDatabaseBackup
    [ValidateNotNull()]
    [Boolean] $IncludeDtSearch
    [ValidateNotNull()]
    [Boolean] $IncludeConceptualAnalytics
    [ValidateNotNull()]
    [Boolean] $IncludeStructuredAnalytics
    [ValidateNotNull()]
    [Boolean] $IncludeDataGrid

    RelativityArmArchiveJobMigratorOptions([Boolean] $includeDatabaseBackup, [Boolean] $includeDtSearch, [Boolean] $includeConceptualAnalytics, [Boolean] $includeStructuredAnalytics, [Boolean] $includeDataGrid)
    {
        $this.IncludeDatabaseBackup = $includeDatabaseBackup
        $this.IncludeDtSearch = $includeDtSearch
        $this.IncludeConceptualAnalytics = $includeConceptualAnalytics
        $this.IncludeStructuredAnalytics = $includeStructuredAnalytics
        $this.IncludeDataGrid = $includeDataGrid
    }

    [Hashtable] ToHashTable()
    {
        return @{
            IncludeDatabaseBackup = $this.IncludeDatabaseBackup
            IncludeDtSearch = $this.IncludeDtSearch
            IncludeConceptualAnalytics = $this.IncludeConceptualAnalytics
            IncludeStructuredAnalytics = $this.IncludeStructuredAnalytics
            IncludeDataGrid = $this.IncludeDataGrid
        }
    }
}