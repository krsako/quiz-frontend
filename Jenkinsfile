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
    stage('Build Image') {
      steps{
        sh "docker build -t ${imagename}:${BUILD_ID} ."
      }
    }
    stage('Push Image') {
      steps{
        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            sh "docker login -u kristosako -p ${PASSWORD}"
            sh "docker push ${imagename}:${BUILD_ID}"
        }
      }
    }
    stage('Remove unused docker image') {
      steps{
        sh "docker rmi ${imagename}:${BUILD_ID}"
      }
    }
    // stage('Deploy image to AKS-Test') {
    //   steps{
    //     sh "az aks get-credentials --resource-group rg-quiz-ks --name tf-aks-quiz-test"
    //     sh "kubectl set image deployment/quiz-client quiz-client=${imagename}:${BUILD_ID} --namespace=quiz"
    //   }
    // }
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
