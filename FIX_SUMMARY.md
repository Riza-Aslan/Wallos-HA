# Fix Summary: GitHub Actions Workflow Error

## Issue
The GitHub Actions workflow was failing with the following error:

```
(Line: 99, Col: 17): Unrecognized named-value: 'latest'. Located at position 34 within expression: needs.prepare.outputs.version || latest
```

And in the workflow logs:
```
##[error]Invalid Opening Quote: a quote is found on field 1 at line 1, value is "value="
```

## Root Cause
The issue was in `.github/workflows/build.yml` at line 101, in the `docker/metadata-action@v5` step:

```yaml
tags: |
  type=raw,value=latest
  type=raw,value=${{ needs.prepare.outputs.version || 'latest' }}
```

The problem had two parts:

1. **GitHub Actions Expression Error**: The expression `needs.prepare.outputs.version || 'latest'` was using `latest` without quotes in the fallback, which GitHub Actions doesn't recognize as a valid string literal in expressions.

2. **Docker Metadata Action Parsing Error**: When the expression was evaluated with quotes (e.g., `'4.8.2'`), it would produce `value="4.8.2"` in the YAML, which the docker metadata action parser couldn't handle correctly.

## Solution
Changed line 101 from:
```yaml
type=raw,value=${{ needs.prepare.outputs.version || 'latest' }}
```

To:
```yaml
type=raw,value=${{ needs.prepare.outputs.version }}
```

This removes the problematic fallback expression entirely. The `latest` tag is still explicitly set on line 100, and the version tag will be set from the config.yaml file. If the version is not available, only the `latest` tag will be applied, which is the desired behavior.

## Files Modified
- `.github/workflows/build.yml` - Line 101

## Verification
The YAML syntax is now valid and the workflow should execute without parsing errors.
