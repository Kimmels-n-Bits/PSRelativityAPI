@{
    Rules = @{
        PSAlignAssignmentStatement = @{
            Enable = $false
            CheckHashtable = $false
        }

        PSAvoidAssignmentToAutomaticVariable = @{
            Enable = $true
        }

        PSAvoidDefaultValueForMandatoryParameter = @{
            Enable = $true
        }

        PSAvoidDefaultValueSwitchParameter = @{
            Enable = $true
        }

        PSAvoidExclaimOperator = @{
            Enable = $true
        }

        PSAvoidGlobalAliases = @{
            Enable = $true
        }

        PSAvoidGlobalFunctions = @{
            Enable = $true
        }

        PSAvoidGlobalVars = @{
            Enable = $true
        }

        PSAvoidInvokingEmptyMembers = @{
            Enable = $true
        }

        PSAvoidLongLines = @{
            Enable = $true
            MaximumLineLength = 120
        }

        PSAvoidMultipleTypeAttributes = @{
            Enable = $true
        }

        PSAvoidNullOrEmptyHelpMessageAttribute = @{
            Enable = $true
        }

        PSAvoidOverwritingBuiltInCmdlets = @{
            Enable = $true
        }

        PSAvoidSemicolonsAsLineTerminators = @{
            Enable = $true
        }

        PSAvoidShouldContinueWithoutForce = @{
            Enable = $true
        }

        PSAvoidTrailingWhitespace = @{
            Enable = $true
        }

        PSAvoidUsingAllowUnencryptedAuthentication = @{
            Enable = $true
        }

        PSAvoidUsingBrokenHashAlgorithms = @{
            Enable = $true
        }

        PSAvoidUsingCmdletAliases = @{
            Enable = $true
        }

        PSAvoidUsingComputerNameHardcoded = @{
            Enable = $true
        }

        PSAvoidUsingConvertToSecureStringWithPlainText = @{
            Enable = $true
        }

        PSAvoidUsingDeprecatedManifestFields = @{
            Enable = $true
        }

        PSAvoidUsingDoubleQuotesForConstantString = @{
            Enable = $false
        }

        PSAvoidUsingEmptyCatchBlock = @{
            Enable = $true
        }

        PSAvoidUsingInvokeExpression = @{
            Enable = $true
        }

        PSAvoidUsingPlainTextForPassword = @{
            Enable = $true
        }

        PSAvoidUsingPositionalParameters = @{
            Enable = $true
        }

        PSAvoidUsingUsernameAndPasswordParams = @{
            Enable = $true
        }

        PSAvoidUsingWMICmdlet = @{
            Enable = $true
        }

        PSAvoidUsingWriteHost = @{
            Enable = $true
        }

        PSMisleadingBacktick = @{
            Enable = $true
        }

        PSMissingModuleManifestField = @{
            Enable = $true
        }

        PSPlaceCloseBrace = @{
            Enable = $true
            NoEmptyLineBefore = $true
            IgnoreOneLineBlock = $true
            NewLineAfter = $true
        }

        PSPlaceOpenBrace = @{
            Enable = $true
            OnSameLine = $false
            NewLineAfter = $false
            IgnoreOneLineBlock = $true
        }

        PSPossibleIncorrectComparisonWithNull = @{
            Enable = $true
        }

        PSPossibleIncorrectUsageOfAssignmentOperator = @{
            Enable = $true
        }

        PSPossibleIncorrectUsageOfRedirectionOperator = @{
            Enable = $true
        }

        PSProvideCommentHelp = @{
            Enable = $true
            ExportedOnly = $false
            BlockComment = $true
            VSCodeSnippetCorrection = $false
            Placement = "before"
        }

        PSReservedCmdletChar = @{
            Enable = $true
        }

        PSReservedParams = @{
            Enable = $true
        }

        PSReviewUnusedParameter = @{
            Enable = $true
        }

        PSShouldProcess = @{
            Enable = $true
        }

        PSUseApprovedVerbs = @{
            Enable = $true
        }

        PSUseBOMForUnicodeEncodedFile = @{
            Enable = $true
        }

        PSUseCmdletCorrectly = @{
            Enable = $true
        }

        PSUseCompatibleCmdlets = @{
            Enable = $true
            Compatibility = @("desktop-5.1.14393.206-windows")
        }

        PSUseCompatibleCommands = @{
            Enable = $false
            TargetProfiles = @()
            IgnoreCommands = @()
        }

        PSUseCompatibleSyntax = @{
            Enable = $true
            TargetVersions = @(
                "5.1"
            )
        }

        PSUseCompatibleTypes = @{
            Enable = $false
            TargetProfiles = @()
            IgnoreTypes = @()
        }

        PSUseConsistentIndentation = @{
            Enable = $true
            IndentationSize = 4
            PipelineIndentation = "IncreaseIndentationForFirstPipeline"
            Kind = "space"
        }

        PSUseConsistentWhitespace = @{
            Enable = $true
            CheckInnerBrace = $true
            CheckOpenBrace = $false
            CheckOpenParen = $true
            CheckOperator = $true
            CheckSeparator = $true
            CheckPipe = $true
            CheckPipeForRedundantWhitespace = $true
            CheckParameter = $true
            IgnoreAssignmentOperatorInsideHashTable = $false
        }

        PSUseCorrectCasing = @{
            Enable = $true
        }

        PSUseDeclaredVarsMoreThanAssignments = @{
            Enable = $true
        }

        PSUseLiteralInitializerForHashtable = @{
            Enable = $true
        }

        PSUseOutputTypeCorrectly = @{
            Enable = $true
        }

        PSUseProcessBlockForPipelineCommand = @{
            Enable = $true
        }

        PSUsePSCredentialType = @{
            Enable = $true
        }

        PSUseShouldProcessForStateChangingFunctions = @{
            Enable = $true
        }

        PSUseSingularNouns = @{
            Enable = $true
            NounAllowList = @(
                "Data",
                "Windows"
            )
        }

        PSUseSupportsShouldProcess = @{
            Enable = $true
        }

        PSUseToExportFieldsInManifest = @{
            Enable = $true
        }

        PSUseUsingScopeModifierInNewRunspaces = @{
            Enable = $true
        }

        PSUseUTF8EncodingForHelpFile = @{
            Enable = $true
        }
    }
}