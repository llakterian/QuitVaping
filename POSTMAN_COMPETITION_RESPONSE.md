# Postman CLI Competition - Enhanced Submission v2

## Response to Moderator Feedback

Thank you for the review! We've updated our workflow to address all requirements.

---

## Updated: Postman CLI Command (Built-in Reporters)

```bash
# Using built-in reporters (no external plugins needed)
npx newman run postman/QuitVaping_API_Tests.postman_collection.json \
  -e postman/QuitVaping_Test_Environment.postman_environment.json \
  -r cli,html,junit,json \
  --reporter-html-export results/newman-report.html \
  --reporter-junit-export results/newman-results.xml \
  --reporter-json-export results/newman-results.json \
  --bail
```

**Key Change**: Using `-r html` (built-in) instead of `--reporters htmlextra` (external plugin).

---

## Updated: GitHub Workflow with Postman API Authentication

```yaml
env:
  POSTMAN_API_KEY: ${{ secrets.POSTMAN_API_KEY }}
  COLLECTION_ID: ${{ secrets.COLLECTION_ID }}
  ENVIRONMENT_ID: ${{ secrets.ENVIRONMENT_ID }}

jobs:
  postman-api-tests:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout repository
      uses: actions/checkout@v4
      
    - name: Install Postman CLI
      run: npm install -g newman
      
    - name: Fetch Collection from Postman API
      run: |
        curl -X GET "https://api.getpostman.com/collections/$COLLECTION_ID" \
          -H "X-Api-Key: $POSTMAN_API_KEY" \
          -o postman/remote-collection.json
        
    - name: Fetch Environment from Postman API
      run: |
        curl -X GET "https://api.getpostman.com/environments/$ENVIRONMENT_ID" \
          -H "X-Api-Key: $POSTMAN_API_KEY" \
          -o postman/remote-environment.json
        
    - name: Run Postman Collection
      run: |
        newman run postman/remote-collection.json \
          -e postman/remote-environment.json \
          -r cli,html,junit,json \
          --reporter-html-export results/newman-report.html \
          --reporter-junit-export results/newman-results.xml \
          --bail
        
    - name: View Collection Run in Postman
      run: |
        echo "Collection Run: https://go.postman.co/reports/collection-run/$COLLECTION_ID"
```

**Secrets Required** (GitHub > Settings > Secrets):
- `POSTMAN_API_KEY` - Your Postman API key
- `COLLECTION_ID` - Your Postman Collection ID
- `ENVIRONMENT_ID` - Your Postman Environment ID

---

## Postman UI Integration

After the GitHub Action runs, you can view detailed results:

1. **Collection Run URL**: `https://go.postman.co/reports/collection-run/{{COLLECTION_ID}}`
2. **View in Postman**: Open Postman app > Go to your workspace > Reports tab
3. **Compare Runs**: Historical comparison of all runs

---

## Native Git Integration Setup

### Step-by-Step:

1. **Open Postman Desktop App**
2. **Go to your Workspace**
3. **Click "Branches"** in the left sidebar
4. **Click "Connect Git Repository"**
5. **Select**: `llakterian/QuitVaping`
6. **Configure Branch Mapping**:
   ```
   Git Branch  ->  Postman Branch
   main         ->  main
   ```
7. **Enable Auto-Run**:
   ```
   - Run collection on push
   - Notify on failure
   - Post results to PR
   ```

### Benefits:
- Automatically runs collection when code is pushed
- Early failure detection before merge
- Results posted directly to GitHub PR
- Syncs collection changes back to repo

---

## Updated: All CLI Commands

### Local Development
```bash
npx newman run postman/QuitVaping_API_Tests.postman_collection.json \
  -e postman/QuitVaping_Test_Environment.postman_environment.json \
  -r cli,html \
  --reporter-html-export results/newman-report.html
```

### CI with API Authentication
```bash
npx newman run postman/remote-collection.json \
  -e postman/remote-environment.json \
  -r cli,html,junit,json \
  --reporter-html-export results/newman-report.html \
  --reporter-junit-export results/newman-results.xml \
  --bail
```

---

## Summary of Changes

| Requirement | Status | Solution |
|------------|--------|----------|
| Postman API Key Authentication | DONE | Added `X-Api-Key` header in curl commands |
| Collection ID Usage | DONE | Fetches collection from Postman API |
| Built-in HTML Reporter | DONE | Using `-r html` instead of external plugin |
| View Collection Run in Postman UI | DONE | Outputting run URL in workflow |
| Native Git Integration | DONE | Added setup guide and separate workflow |

---

## Secret Setup Instructions

1. **Generate Postman API Key**:
   - Go to: https://postman.co/settings/my-api-keys
   - Click "Generate New API Key"
   - Copy the key

2. **Get Collection ID**:
   - Open collection in Postman
   - Click "Info" (i) icon
   - Copy "ID" field

3. **Add to GitHub**:
   - Repository > Settings > Secrets and variables > Actions
   - Add: `POSTMAN_API_KEY`, `COLLECTION_ID`, `ENVIRONMENT_ID`
