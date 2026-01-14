pipeline {
  agent any
 
  environment {
    // These map to Jenkins Credentials IDs you created in Phase 3
    ARM_CLIENT_ID       = credentials('AZURE_CLIENT_ID')
    ARM_CLIENT_SECRET   = credentials('AZURE_CLIENT_SECRET')
    ARM_TENANT_ID       = credentials('AZURE_TENANT_ID')
    ARM_SUBSCRIPTION_ID = credentials('AZURE_SUBSCRIPTION_ID')
  }
 
  stages {
 
    stage('Terraform Init') {
      steps {
        dir('C:\Users\User\Desktop\Terraform\terraform-jenkins-lab') {
          bat 'terraform init'
        }
      }
    }
 
    stage('Terraform Plan') {
      steps {
        dir('C:\Users\User\Desktop\Terraform\terraform-jenkins-lab') {
          // If your TF code reads vars from env (recommended with azurerm), plain 'terraform plan' is enough.
          // If your variables.tf requires explicit -var values, keep the block below:
          bat '''
            terraform plan ^
              -var "subscription_id=%ARM_SUBSCRIPTION_ID%" ^
              -var "client_id=%ARM_CLIENT_ID%" ^
              -var "client_secret=%ARM_CLIENT_SECRET%" ^
              -var "tenant_id=%ARM_TENANT_ID%" ^
              -out plan.tfplan
          '''
        }
      }
    }
 
    stage('Manual Approval') {
      steps {
        input message: 'Approve deployment?', ok: 'Deploy'
      }
    }
 
    stage('Terraform Apply') {
      steps {
        dir('C:/path/to/your/terraform/project') {
          bat 'terraform apply -auto-approve plan.tfplan'
        }
      }
    }
  }
 
  post {
    success {
      echo '✅ Infrastructure provisioned successfully!'
    }
    failure {
      echo '❌ Build failed. Check logs.'
    }
  }
}
