# Postman CLI Competition Submission v2

## Moderator Feedback Addressed - FIXED

> "Because it's using a Postman API key and a Collection ID, it would usually need to authenticate first"

**FIXED**: Added API authentication steps to fetch collection/environment from Postman API.

---

## Collection Ran

**QuitVaping Production API Tests** - Production API test suite with authentication

---

## Postman CLI Command (Built-in Reporters)

```bash
# Fetch collection from Postman API
curl -X GET "https://api.getpostman.com/collections/$COLLECTION_ID" \
  -H "X-Api-Key: $POSTMAN_API_KEY" \
  -o postman/fetched-collection.json

# Run with built-in reporters
npx newman run postman/fetched-collection.json \
  -e postman/fetched-environment.json \
  -r cli,html,junit,json \
  --reporter-html-export results/newman-report.html \
  --reporter-junit-export results/newman-results.xml \
  --reporter-json-export results/newman-results.json \
  --bail
```

**Key Change**: Using `-r html` (built-in) instead of external `htmlextra` reporter.

---

## CI/CD Configuration (GitHub Actions)

```yaml
name: Postman API Integration

on:
  push:
    branches: [ main ]
  schedule:
    - cron: '0 9 * * 1'  # Weekly on Monday

env:
  POSTMAN_API_KEY: ${{ secrets.POSTMAN_API_KEY }}
  COLLECTION_ID: ${{ secrets.POSTMAN_COLLECTION_ID }}
  ENVIRONMENT_ID: ${{ secrets.POSTMAN_ENVIRONMENT_ID }}

jobs:
  postman-api-run:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v4

    - name: Install Newman
      run: npm install -g newman

    - name: Fetch Collection from Postman API
      run: |
        curl -X GET "https://api.getpostman.com/collections/${COLLECTION_ID}" \
          -H "X-Api-Key: ${POSTMAN_API_KEY}" \
          -o postman/fetched-collection.json

    - name: Fetch Environment from Postman API
      run: |
        curl -X GET "https://api.getpostman.com/environments/${ENVIRONMENT_ID}" \
          -H "X-Api-Key: ${POSTMAN_API_KEY}" \
          -o postman/fetched-environment.json

    - name: Run with Built-in Reporters
      run: |
        newman run postman/fetched-collection.json \
          -e postman/fetched-environment.json \
          -r cli,html,junit,json \
          --reporter-html-export results/newman-report.html \
          --reporter-junit-export results/newman-results.xml \
          --bail

    - name: View Collection Run in Postman
      run: |
        echo "View results: https://go.postman.co/reports/collection-run/${COLLECTION_ID}"
```

---

## One Thing CI Gives You That Local Doesn't

### Automated Scheduling + Authentication + History

1. **Scheduled Runs**: Automatically runs every Monday at 9AM
2. **Secure Authentication**: API keys stored as GitHub secrets
3. **Centralized Management**: Fetch latest collection from Postman API
4. **Historical Tracking**: All runs saved in Postman Reports
5. **Failure Alerts**: Immediate failure detection
6. **Artifact Preservation**: HTML/JUnit reports saved for 90 days

---

## Suggestions to Improve Postman CLI

### 1. Built-in OAuth Support

```bash
newman run collection.json --oauth-token-url "https://auth.example.com" \
  --oauth-client-id "$CLIENT_ID" --oauth-client-secret "$CLIENT_SECRET"
```

### 2. Better CI/CD Integration

- Native GitHub Action (no curl commands needed)
- Auto-post results to PR comments
- Built-in secret management

### 3. Enhanced Reporting

- Parallel test execution support
- Native diff between runs
- Trend analysis charts

---

## Native Git Integration Setup

### Enable in Postman:

1. **Open Postman Desktop App**
2. **Go to Workspace > Branches**
3. **Click "Connect Git Repository"**
4. **Select**: `llakterian/QuitVaping`
5. **Configure**:
   ```
   Git Branch: main -> Postman Branch: main
   - Auto-run collection on push
   - Post results to GitHub PR
   - Notify on failure
   ```

### Benefits:

- Automatically runs collection when code is pushed
- Early indication of test failures
- Results posted directly to GitHub PR
- Two-way sync between Postman and GitHub

---

## Files Created

- `.github/workflows/postman-api.yml` - Main workflow with API auth
- `.github/workflows/postman-native-git.yml` - Native Git setup
- `postman/api-collection.json` - Production API tests
- `postman/production-environment.json` - Production environment

---

## Quick Start

```bash
# Run locally with built-in reporters
npx newman run postman/api-collection.json \
  -e postman/production-environment.json \
  -r cli,html \
  --reporter-html-export results/report.html

# Set up GitHub secrets
gh secret set POSTMAN_API_KEY "your-api-key"
gh secret set POSTMAN_COLLECTION_ID "collection-id"
gh secret set POSTMAN_ENVIRONMENT_ID "environment-id"

# Trigger workflow
gh workflow run postman-api.yml
```
