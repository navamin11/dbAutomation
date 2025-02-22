pipeline {
    agent any

    environment {
        DOCKER_COMPOSE = '/usr/local/bin/docker-compose'
    }

    stages {
        stage('Check Docker Compose') {
            steps {
                script {
                    sh 'docker-compose --version'
                }
            }
        }

        stage('Checkout') {
            steps {
                git 'https://github.com/navamin11/dbAutomation.git'
            }
        }

        stage('Build and Start Containers') {
            steps {
                script {
                    sh 'docker-compose -f docker-compose.yml up -d'
                }
            }
        }

        stage('Liquibase Migration') {
            steps {
                script {
                    sh 'docker compose exec liquibase liquibase --defaultsFile=liquibase.properties update'
                }
            }
        }

        //  stage('Liquibase Migration') {
        //     steps {
        //         sh '''
        //         docker run --rm --network=host \
        //         -v $(pwd)/liquibase:/liquibase \
        //         liquibase/liquibase --defaultsFile=/liquibase/liquibase.properties update
        //         '''
        //     }
        // }

        stage('PostgreSQL Check') {
            steps {
                script {
                    sh 'docker-compose exec postgres pg_isready -U postgres'
                }
            }
        }

        stage('Stop Containers') {
            steps {
                script {
                    sh 'docker-compose down -v'
                }
            }
        }
    }
}
