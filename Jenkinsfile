pipeline {
    agent {
        docker {
            image 'node:20-alpine'
        }
    }
    
    stages {
        stage('Install Newman') {
            steps {
                sh 'npm install -g newman newman-reporter-htmlextra'
            }
        }
        
        stage('Run Postman Tests') {
            steps {
                sh '''
                newman run postman/QuitVaping_API_Tests.postman_collection.json \
                  -e postman/QuitVaping_Test_Environment.postman_environment.json \
                  --reporters cli,htmlextra,junit \
                  --reporter-htmlextra-export newman-report.html \
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
    
    post {
        always {
            cleanWs()
        }
    }
}