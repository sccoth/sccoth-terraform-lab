pipeline {
  agent any

  environment {
    GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-sccoth-dev-sa')
  }

  stages {
    stage('Debug Branch') {
      steps {
        sh 'echo BRANCH_NAME=$BRANCH_NAME'
        sh 'echo GIT_BRANCH=$GIT_BRANCH'
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
          sh 'terraform plan -no-color'
        }
      }
    }

    stage('Terraform Apply') {
      when {
        anyOf {
          branch 'main'
          expression { env.GIT_BRANCH == 'origin/main' }
        }
      }
      steps {
        dir('environments/dev') {
          sh 'terraform apply -auto-approve -no-color'
        }
      }
    }
  }
}