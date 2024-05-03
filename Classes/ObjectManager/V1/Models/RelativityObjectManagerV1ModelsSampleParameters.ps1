class RelativityObjectManagerV1ModelsSampleParameters
{
    <#
        .SYNOPSIS
            Contains information about how the sampling is performed.
        .PARAMETER ConfidenceLevel
            Gets or sets a value for confidence level required for a sample set.
        .PARAMETER ExistingToken
            Gets or sets the identifier for a sample set.
        .PARAMETER FixedSampleSize
            Gets or sets a value representing a specific number of items from a group used to create a randomized
            sample set.
        .PARAMETER MarginOfError
            Gets or sets a value for the margin of error allowable in sample results.
        .PARAMETER SamplingPercentage
            Gets or sets a value representing the percentage of items from a group used to create a randomized sample
            set.
    #>
    [Decimal] $ConfidenceLevel
    [Guid] $ExistingToken
    [Int32] $FixedSampleSize
    [Decimal] $MarginOfError
    [Decimal] $SamplingPercentage

    RelativityObjectManagerV1ModelsSampleParameters()
    {
    }

    RelativityObjectManagerV1ModelsSampleParameters(
        [Decimal] $ConfidenceLevel,
        [Guid] $ExistingToken,
        [Int32] $FixedSampleSize,
        [Decimal] $MarginOfError,
        [Decimal] $SamplingPercentage
    )
    {
        $this.ConfidenceLevel = $ConfidenceLevel
        $this.ExistingToken = $ExistingToken
        $this.FixedSampleSize = $FixedSampleSize
        $this.MarginOfError = $MarginOfError
        $this.SamplingPercentage = $SamplingPercentage
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}
        
        $ReturnValue.Add("ConfidenceLevel", $this.ConfidenceLevel)

        if ($this.ExistingToken -ne ([Guid]"00000000-0000-0000-0000-000000000000"))
        {
                $ReturnValue.Add("ExistingToken", $this.ExistingToken)
        }
        
        $ReturnValue.Add("FixedSampleSize", $this.FixedSampleSize)
        $ReturnValue.Add("MarginOfError", $this.MarginOfError)
        $ReturnValue.Add("SamplingPercentage", $this.SamplingPercentage)

        return $ReturnValue
    }
}