pipeline {
  environment {
    imagename = "kristosako/angular-quiz"
    AZURE_SUBSCRIPTION_ID = "Kristo_Sako_Subscription"
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/krsako/quiz-frontend.git', branch: 'main', credentialsId: 'github'])
      }
    }
    stage('Deploy image to AKS-Test') {
      steps{
        withCredentials([azureServicePrincipal('azure')]) {
          stage('Prepare Environment') {
            sh 'az login --service-principal -u ${AZURE_CLIENT_ID} -p ${AZURE_CLIENT_SECRET} -t ${AZURE_TENANT_ID}'
            sh 'az account set -s ${AZURE_SUBSCRIPTION_ID}'
            acrSettings = new JsonSlurper().parseText(sh(script: "az acs show -o json -n my-acr", returnStdout: true))
        }
      }
    }
  }
}
