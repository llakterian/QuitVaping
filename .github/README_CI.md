# Postman CLI CI/CD Setup Guide

## GitHub Actions Workflow

### 1. Setup Secrets

Go to GitHub Repository > Settings > Secrets and variables > Actions:

```bash
POSTMAN_API_KEY=your_postman_api_key_here
COLLECTION_ID=your_collection_id_here
ENVIRONMENT_ID=your_environment_id_here
```

### 2. Generate API Key
1. Go to: https://postman.co/settings/my-api-keys
2. Click "Generate New API Key"
3. Copy and save securely

### 3. Get Collection/Environment IDs
1. Open Postman
2. Click collection > "Info" (i) icon
3. Copy ID from right panel
4. Repeat for environment

### 4. Run Workflow

Push changes to `main` branch or:
```bash
# Manually trigger
gh workflow run postman-tests.yml
```

### 5. View Results

- **GitHub Actions Tab**: Full run logs
- **Postman Reports**: `https://go.postman.co/reports/collection-run/COLLECTION_ID`

## Native Git Integration

### Setup in Postman

1. Open Postman Desktop App
2. Go to Workspace > Branches
3. Connect Git Repository
4. Select this repo
5. Configure auto-run on push

## Available Commands

```bash
# Local test
npm run test:local

# CI test with API authentication
npm run test:ci

# Full report generation
npm run test:detailed
```

## Troubleshooting

### Collection Not Found
- Verify `COLLECTION_ID` is correct
- Check API key has read access

### Authentication Failed
- Regenerate API key
- Ensure key is not expired

### Environment Variables Missing
- Add `ENVIRONMENT_ID` to GitHub secrets
- Or use local environment file
