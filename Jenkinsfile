pipeline {
  environment {
    imagename = "kristosako/angular-quiz"
    registryCredential = 'dockerhub-cred'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/krsako/quiz-frontend.git', branch: 'main', credentialsId: 'git-jenkins'])
      }
    }
    stage('Building image') {
      steps{
        sh "docker build -t kristosako/angular-quiz:${env.BUILD_ID} ."
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("${env.BUILD_ID}")
             dockerImage.push('latest')

          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $imagename:${env.BUILD_ID}"
         sh "docker rmi $imagename:latest"

      }
    }
  }
}
