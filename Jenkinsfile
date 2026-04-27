pipeline {
  agent any

  environment {
    GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-sccoth-dev-sa')
  }

  stages {
    stage('Terraform Init') {
      steps {
        dir('environments/dev') {
          sh 'terraform init'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir('environments/dev') {
          sh 'terraform plan'
        }
      }
    }
  }
}