pipeline {
    agent any

    environment {
        DOCKER_COMPOSE = '/usr/local/bin/docker-compose'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-repo/project.git'
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
                    sh 'docker-compose exec liquibase liquibase --defaultsFile=liquibase.properties update'
                }
            }
        }

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
