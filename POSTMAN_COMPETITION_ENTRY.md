# Postman CLI Competition Entry

## Competition Details
- **Competition**: Weekly Community Challenge
- **Prize**: $200 Visa Gift Card
- **Entry Date**: Wednesday Feb 11, 2026

---

## Step 1: Postman CLI Command Used

### Collection Ran
**QuitVaping API Tests** - API test suite for the QuitVaping application

### Command
```bash
# Basic run with HTML reporter
npx newman run postman/QuitVaping_API_Tests.postman_collection.json \
  -e postman/QuitVaping_Test_Environment.postman_environment.json \
  -r cli,html \
  --reporter-html-export results/newman-report.html
```

### Advanced CI Command
```bash
npx newman run postman/QuitVaping_API_Tests.postman_collection.json \
  -e postman/QuitVaping_Test_Environment.postman_environment.json \
  -r cli,html,junit,json \
  --reporter-html-export results/newman-report.html \
  --reporter-junit-export results/newman-results.xml \
  --reporter-json-export results/newman-results.json \
  --environment-results-file results/environment.json \
  --bail
```

### Key Flags Used
- `-e, --environment`: Postman environment file
- `-r, --reporters`: Multiple reporters (cli, html, junit, json)
- `--reporter-html-export`: HTML report
- `--reporter-junit-export`: JUnit XML for CI integration
- `--reporter-json-export`: JSON results for custom parsing
- `--bail`: Stop on first failure (CI mode)
- `--skip-environment-variables`: Hide sensitive data in logs

---

## Step 2: CI/CD Pipeline Configurations

### 1. GitHub Actions
**File**: `.github/workflows/postman-tests.yml`

```yaml
name: Postman CLI Tests

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: '0 9 * * 1'  # Weekly on Monday at 9AM

jobs:
  postman-tests:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v4
      
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '20'
        cache: 'npm'
        
    - name: Install dependencies
      run: npm ci
      
    - name: Install Newman
      run: npm install -g newman

    - name: Run Postman Collection
      run: |
        newman run postman/QuitVaping_API_Tests.postman_collection.json \
          -e postman/QuitVaping_Test_Environment.postman_environment.json \
          -r cli,html,junit \
          --reporter-html-export results/newman-report.html \
          --reporter-junit-export results/newman-results.xml \
          --bail
        
    - name: Upload test results
      uses: actions/upload-artifact@v4
      if: always()
      with:
        name: postman-results
        path: results/
```

### 2. GitLab CI
**File**: `.gitlab-ci.yml`

```yaml
stages:
  - test

postman_tests:
  image: node:20-alpine
  stage: test
  before_script:
    - npm install -g newman
  script:
    - newman run postman/QuitVaping_API_Tests.postman_collection.json \
      -e postman/QuitVaping_Test_Environment.postman_environment.json \
      -r cli,html \
      --reporter-html-export newman-report.html \
      --bail
  artifacts:
    when: always
    paths:
      - newman-report.html
    expire_in: 1 week
  rules:
    - if: $CI_PIPELINE_SOURCE == "schedule"
    - if: $CI_COMMIT_BRANCH == "main"
```

### 3. Bitbucket Pipelines
**File**: `bitbucket-pipelines.yml`

```yaml
image: node:20-alpine

pipelines:
  default:
    - step:
        name: Postman CLI Tests
        caches:
          - node
        script:
          - npm install -g newman
          - newman run postman/QuitVaping_API_Tests.postman_collection.json \
            -e postman/QuitVaping_Test_Environment.postman_environment.json \
            -r cli,html \
            --reporter-html-export newman-report.html \
            --bail
        artifacts:
          - newman-report.html
  scheduled:
    - step:
        name: Weekly Postman Tests
        trigger: scheduled
        script:
          - npm install -g newman
          - newman run postman/QuitVaping_API_Tests.postman_collection.json \
            -e postman/QuitVaping_Test_Environment.postman_environment.json \
            -r cli,html \
            --reporter-html-export newman-report.html
```

### 4. Jenkins
**File**: `Jenkinsfile`

```groovy
pipeline {
    agent {
        docker {
            image 'node:20-alpine'
        }
    }
    
    stages {
        stage('Install Newman') {
            steps {
                sh 'npm install -g newman'
            }
        }
        
        stage('Run Postman Tests') {
            steps {
                sh '''
                newman run postman/QuitVaping_API_Tests.postman_collection.json \
                  -e postman/QuitVaping_Test_Environment.postman_environment.json \
                  -r cli,html,junit \
                  --reporter-html-export newman-report.html \
                  --reporter-junit-export newman-results.xml \
                  --bail
                '''
            }
            post {
                always {
                    junit 'newman-results.xml'
                    publishHTML([
                        reportDir: '.',
                        reportFiles: 'newman-report.html',
                        reportName: 'Postman Test Report'
                    ])
                }
            }
        }
    }
}
```

---

## One Thing CI Gives You That Local Doesn't

### Automated Scheduling + Notifications + History

Running in CI provides:

1. **Scheduled Runs**: Automatically run tests weekly (GitHub Actions `schedule` cron)
2. **Failure Alerts**: Immediate notifications when tests fail
3. **Historical Trends**: Track test performance over time
4. **Branch Protection**: Prevent merges when tests fail
5. **Parallel Execution**: Run multiple collections simultaneously
6. **Artifacts**: Preserve reports for later analysis
7. **Integration**: Connect with Slack, Discord, email alerts

---

## Suggestions to Improve Postman CLI

### 1. **Built-in Parallel Test Execution**
```bash
newman run collection.json --parallel 4
```

### 2. **Native JSON Reporter**
Currently requires external plugins. Would be great as built-in.

### 3. **Better WebSocket Support**
Collections with WebSocket requests need better CLI handling.

### 4. **Dynamic Environment Variables**
```bash
newman run collection.json --env-var API_URL=$PROD_URL
```

### 5. **Test Summary in PR Comments**
Auto-post results as GitHub PR comments.

---

## Quick Start Commands

```bash
# Install
npm install

# Run tests locally
npm test

# Run with CI configuration
npm run test:ci

# Run with all reporters
npm run test:detailed
```

---

## Test Results

**Last Run**: 2026-02-11
- **Total Tests**: 3 requests, 5 assertions
- **Status**: Configured and ready
- **Report Location**: `results/newman-report.html`
