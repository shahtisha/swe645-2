// Jenkinsfile
// This file defines the CI/CD pipeline for the SWE 645 student survey app.
// It builds a Docker image, pushes it to DockerHub, and redeploys to Kubernetes automatically.

pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'DOCKERHUB_USERNAME'
        IMAGE_NAME = 'studentsurvey645'
        DOCKERHUB_PASS = credentials('docker-pass')
        BUILD_TAG = "${env.BUILD_NUMBER}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo 'Pulling latest code from GitHub...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    sh "docker build -t ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${BUILD_TAG} ."
                    sh "docker tag ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${BUILD_TAG} ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                echo 'Pushing image to DockerHub...'
                script {
                    sh "echo ${DOCKERHUB_PASS} | docker login -u ${DOCKERHUB_USERNAME} --password-stdin"
                    sh "docker push ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${BUILD_TAG}"
                    sh "docker push ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying updated image to Kubernetes cluster...'
                script {
                    sh """
                        kubectl set image deployment/studentsurvey-deployment \
                        studentsurvey=${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${BUILD_TAG} \
                        --record
                    """
                    sh "kubectl rollout status deployment/studentsurvey-deployment"
                }
            }
        }

    }

    post {
        success {
            echo 'Pipeline completed successfully! App is live on Kubernetes.'
        }
        failure {
            echo 'Pipeline failed. Check the logs above for errors.'
        }
    }
}
