pipeline {
    agent any

    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-sccoth-dev-sa')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Detect Changed Terraform Stacks') {
            steps {
                script {
                    def changedFiles = sh(
                        script: '''
                            git fetch origin main
                            git diff --name-only origin/main...HEAD
                        ''',
                        returnStdout: true
                    ).trim()

                    echo "Changed files:"
                    echo changedFiles

                    def stacks = []

                    if (changedFiles.contains('environments/dev/network/') || changedFiles.contains('modules/network/')) {
                        stacks.add('environments/dev/network')
                    }

                    if (changedFiles.contains('environments/dev/gke/') || changedFiles.contains('modules/gke/')) {
                        stacks.add('environments/dev/gke')
                    }

                    if (stacks.isEmpty()) {
                        echo "No Terraform stack changes detected. Defaulting to dev/network for safety."
                        stacks.add('environments/dev/network')
                    }

                    env.TF_STACKS = stacks.join(',')
                    echo "Terraform stacks to run: ${env.TF_STACKS}"
                }
            }
        }

        stage('Terraform Init / Validate / Plan') {
            steps {
                script {
                    def stacks = env.TF_STACKS.split(',')

                    for (stack in stacks) {
                        echo "Running Terraform for ${stack}"

                        dir(stack) {
                            sh 'terraform init'
                            sh 'terraform validate'
                            sh 'terraform plan -no-color'
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                branch 'main'
            }
            steps {
                script {
                    def stacks = env.TF_STACKS.split(',')

                    for (stack in stacks) {
                        echo "Applying Terraform for ${stack}"

                        dir(stack) {
                            sh 'terraform apply -auto-approve'
                        }
                    }
                }
            }
        }
    }
}