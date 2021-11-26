pipeline {
   agent any

   environment {
     SERVICE_NAME = "quiz-frontend"
     REPOSITORY_TAG="${DOCKERHUB_USR}/${SERVICE_NAME}:${BUILD_ID}"
   }

   stages {
      stage('Preparation') {
         steps {
            cleanWs()
            git credentialsId: 'git-jenkins', url: "https://github.com/krsako/${SERVICE_NAME}"
         }
      }
      stage('Build') {
         steps {
            sh 'echo No build required for Webapp.'
         }
      }

      stage('Build and Push Image') {
         steps {
           sh 'docker image build -t ${REPOSITORY_TAG} .'
         }
      }

      stage('Deploy to Cluster') {
          steps {
            sh 'envsubst < ${WORKSPACE}/deploy.yaml -n quiz | kubectl apply -f -'
          }
      }
   }
}
