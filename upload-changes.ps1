[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$CommitMessage
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ExpectedRemote = 'https://github.com/fortuneolose/pcb-001-ne555-astable-led-flasher.git'

function Invoke-Git {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$GitArguments
    )

    & git @GitArguments
    if ($LASTEXITCODE -ne 0) {
        throw "Git command failed: git $($GitArguments -join ' ')"
    }
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'Git is not installed or is not available on PATH.'
}

Push-Location $PSScriptRoot
try {
    $insideWorkTree = (& git rev-parse --is-inside-work-tree 2>$null)
    if ($LASTEXITCODE -ne 0 -or $insideWorkTree -ne 'true') {
        throw "The script directory is not a Git repository: $PSScriptRoot"
    }

    $remoteUrl = (& git remote get-url origin 2>$null)
    if ($LASTEXITCODE -ne 0) {
        throw "The repository does not have an 'origin' remote. Expected: $ExpectedRemote"
    }

    $normalizedRemote = $remoteUrl.Trim().TrimEnd('/')
    if ($normalizedRemote -ne $ExpectedRemote.TrimEnd('/')) {
        throw "Refusing to push because 'origin' is '$remoteUrl'. Expected: $ExpectedRemote"
    }

    $branch = (& git branch --show-current)
    if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($branch)) {
        throw 'No branch is currently checked out. Check out a branch before uploading changes.'
    }
    $branch = $branch.Trim()

    Write-Host "Staging changes in $PSScriptRoot ..."
    Invoke-Git add --all

    & git diff --cached --quiet
    $hasStagedChanges = $LASTEXITCODE -eq 1
    if ($LASTEXITCODE -gt 1) {
        throw 'Git could not inspect the staged changes.'
    }

    if ($hasStagedChanges) {
        if ([string]::IsNullOrWhiteSpace($CommitMessage)) {
            $CommitMessage = "Update project files $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        }

        Write-Host "Creating commit: $CommitMessage"
        Invoke-Git commit -m $CommitMessage
    }
    else {
        Write-Host 'No uncommitted changes were found. Checking for commits that still need to be pushed.'
    }

    Write-Host "Uploading branch '$branch' to origin ..."
    Invoke-Git push --set-upstream origin $branch
    Write-Host 'Upload complete.' -ForegroundColor Green
}
finally {
    Pop-Location
}
