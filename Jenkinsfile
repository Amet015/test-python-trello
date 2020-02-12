pipeline {
  agent { docker { image '3.8.1-alpine3.11' } }
  stages {
    stage('build') {
      steps {
        sh 'python --version'
      }
    }
    stage('Install Requirements') {
      steps {
        withEnv(["HOME=${env.WORKSPACE}"]) {
          sh 'pip3 install -r requirements.txt'
        }
      }
    }
    stage('API') {
      steps {
        sh 'behave trello/api/features'
      }
    }
  }
}