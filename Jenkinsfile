pipeline {
    agent any  // This runs the pipeline on any available agent

    environment {
        DOCKER_IMAGE = "educomz"   // Name of the Docker image
        DOCKER_TAG = "latest"     // Tag for the Docker image (e.g., "latest" or commit hash)
        REGISTRY = "jithinmicrocometz"  // Optional, specify your Docker Hub username if pushing to Docker Hub
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the code from the repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    //Checking Docker Version
                    sh 'docker --version'
                    // Build the Docker image using the Dockerfile in the repository
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        // stage('Run Docker Container') {
        //     steps {
        //         script {
        //             // Run the Docker container (for testing or other purposes)
        //             // This can be modified based on what you need to do with the container
        //             docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").run('-d')  // Run in detached mode
        //         }
        //     }
        // }

        // stage('Test Docker Container') {
        //     steps {
        //         script {
        //             // Example of running a test or validation inside the container
        //             // You can modify this to run specific tests, e.g., curl, etc.
        //             docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").inside {
        //                 sh 'echo "Running tests inside the container..."'
        //                 // Add additional test commands here
        //             }
        //         }
        //     }
        // }

        // stage('Push Docker Image') {
        //     // when {
        //     //     branch 'main'  // Optional: Only push to registry on the 'main' branch
        //     // }
        //     steps {
        //         script {
        //             // Log in to Docker Hub (if pushing to Docker Hub or a private registry)
        //             withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER-USER', passwordVariable: 'DOCKER-PASS')]) {
        //                 sh "echo ${DOCKER-PASS} | docker login -u ${DOCKER-USER} --password-stdin"
        //             }

        //             // Tag the Docker image with the registry name
        //             sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}"

        //             // Push the Docker image to Docker Hub
        //             sh "docker push ${REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}"
        //         }
        //     }
        // }

        // stage('Clean up') {
        //     steps {
        //         script {
        //             // Clean up: remove the Docker container and image to free resources
        //             sh "docker container prune -f"
        //             sh "docker image prune -f"
        //         }
        //     }
        // }
    }

    post {
        always {
            // This will run regardless of the pipeline success or failure
            cleanWs()  // Clean the workspace after the build is done
        }
        success {
            echo 'Build and Docker operations completed successfully.'
        }
        failure {
            echo 'There was a failure in the pipeline.'
        }
    }
}
