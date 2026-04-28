# Terraform + Jenkins + GCP Lab

## Overview

This lab demonstrates a full Infrastructure as Code (IaC) workflow using:

* Terraform (infrastructure provisioning)
* Jenkins (CI/CD automation)
* GitHub (source control + PR workflow)
* Google Cloud (target environment)

The pipeline follows a real-world pattern:

* Pull Request → Terraform Plan
* Merge to main → Terraform Apply

---

## Architecture

```
GitHub (code + PRs)
        ↓
   Jenkins (pipeline)
        ↓
 Terraform (plan/apply)
        ↓
      GCP (VPC + subnets)
```

---

## Prerequisites

* Docker Desktop
* Git installed
* GitHub account
* Google Cloud project
* GCP service account with permissions:

  * Compute Admin
  * Network Admin

---

## 1. Run Jenkins locally

```bash
docker run -d \
  -p 8080:8080 -p 50000:50000 \
  --name jenkins \
  jenkins/jenkins:lts
```

Access Jenkins:

```
http://localhost:8080
```

Get admin password:

```bash
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

---

## 2. Install Jenkins plugins

Install suggested plugins, plus:

* GitHub
* Pipeline
* Credentials Binding
* Git

---

## 3. Install Terraform in Jenkins

Enter container:

```bash
docker exec -it jenkins bash
```

Install Terraform:

```bash
apt update
apt install -y wget unzip

wget https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_amd64.zip
unzip terraform_1.8.5_linux_amd64.zip
mv terraform /usr/local/bin/
```

Verify:

```bash
terraform version
```

---

## 4. GitHub Setup

Create repository:

```
sccoth-terraform-lab
```

Push your project:

```bash
git init
git remote add origin https://github.com/<your-username>/repo.git
git add .
git commit -m "initial commit"
git push -u origin main
```

---

## 5. GCP Setup

Create a service account:

* Name: terraform-sa
* Roles:

  * Compute Admin
  * Network Admin

Create and download JSON key.

---

## 6. Jenkins Credentials

### Add GCP credentials

Type: **Secret file**

* ID: `gcp-sccoth-dev-sa`
* Upload JSON key

---

### Add GitHub PAT

Generate token in GitHub:

Scopes:

* repo

Add in Jenkins:

* Type: Username + Password
* Username: your GitHub username
* Password: PAT
* ID: `github-creds`

---

## 7. Jenkins Pipeline (Multibranch)

Create:

```
New Item → Multibranch Pipeline
```

Configure:

* GitHub repo URL
* Credentials: `github-creds`
* Enable branch + PR discovery

---

## 8. Jenkinsfile

```groovy
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
        branch 'main'
      }
      steps {
        dir('environments/dev') {
          sh 'terraform apply -auto-approve -no-color'
        }
      }
    }
  }
}
```

---

## 9. Branch Protection Rules

GitHub → Settings → Rulesets

Enable:

* Require pull request before merging
* Require status checks:

  * Jenkins branch
  * Jenkins PR
* Require branch to be up to date

---

## 10. Workflow

### Create feature branch

```bash
git checkout -b feature/add-subnet
```

Make changes → commit → push:

```bash
git add .
git commit -m "add subnet"
git push
```

---

### Create PR

* Jenkins runs `terraform plan`

---

### Merge PR

* Jenkins runs `terraform apply`
* Infrastructure is created in GCP

---

## 11. Common Issues

### Resource already exists

Error:

```
Error 409: already exists
```

Fix:

```bash
terraform import <resource> <gcp-resource-id>
```

---

### Jenkins can't find credentials

Make sure:

* Credential ID matches Jenkinsfile
* Secret file exists

---

### Terraform apply skipped

Check:

```
when { branch 'main' }
```

Apply only runs on main branch.

---

## 12. Cleanup

To remove resources:

```bash
terraform destroy
```

Or delete manually in GCP.

---

## Key Learnings

* Terraform only manages resources in its state
* PR-based workflows separate plan vs apply
* Jenkins automates infrastructure safely
* Branch protection enforces good practices

---

## Next Improvements

* Remote Terraform state (GCS backend)
* Add `terraform validate`
* Add prod environment
* Add approval gates before apply
* Automate branch updates

---
