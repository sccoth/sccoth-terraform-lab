pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/sccoth/sccoth-terraform-lab.git'
      }
    }

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
