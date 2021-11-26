pipeline {
  environment {
    imagename = "kristosako/angular-quiz"
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
    stage('Deploy image to AKS-Test') {
      steps{
        sh "az aks get-credentials --resource-group rg-quiz-ks --name tf-aks-quiz-test"
        sh "kubectl set image deployment/quiz-client quiz-client=${imagename}:${BUILD_ID} --namespace=quiz"
      }
    }
  }
}
