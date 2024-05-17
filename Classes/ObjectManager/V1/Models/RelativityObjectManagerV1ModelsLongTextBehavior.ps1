enum RelativityObjectManagerV1ModelsLongTextBehavior
{
    <#
        .SYNOPSIS
            Controls the behavior that is used when a Long Text field exceeds the configured character limit.
        .PARAMETER Default
            Long Text field values will be truncated and followed by an ellipsis when the value exceeds the
            configured limit.
        .PARAMETER DefaultWithErrors
            Long Text field values will be truncated and followed by an ellipsis when the value exceeds the
            configured limit. If the field has errors, a TextFieldError object will be returned containing the error
            message.
        .PARAMETER Tokenized
            Long Text field values will return a default token when the value exceeds the configured limit.
        .PARAMETER TokenizedWithErrors
            Long Text field values will return a default token when the value exceeds the configured limit. If the
            field has errors, a TextFieldError object will be returned containing the error message.
    #>
    Default = 0
    DefaultWithErrors = 2
    Tokenized = 1
    TokenizedWithErrors = 3
}