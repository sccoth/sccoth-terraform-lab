pipeline {
  agent any

  environment {
    GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-sccoth-dev-sa')
    TF_DIR = 'environments/dev/network'
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
        dir(env.TF_DIR) {
          sh 'terraform init'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir(env.TF_DIR) {
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
        dir(env.TF_DIR) {
          sh 'terraform apply -auto-approve -no-color'
        }
      }
    }
  }
}