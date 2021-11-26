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
    stage('Building image') {
      steps{
        sh "docker build -t ${imagename}:${BUILD_ID} ."
      }
    }
    stage('Deploy Image') {
      steps{
        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            sh "docker login -u kristosako -p ${PASSWORD}"
            sh "docker push ${imagename}:${BUILD_ID}"
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $imagename:${BUILD_ID}"
         sh "docker rmi $imagename:latest"
      }
    }
  }
}
