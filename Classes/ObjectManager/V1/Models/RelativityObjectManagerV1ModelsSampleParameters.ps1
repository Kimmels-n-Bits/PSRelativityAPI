class RelativityObjectManagerV1ModelsSampleParameters
{
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
}