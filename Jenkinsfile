pipeline {
  agent any

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