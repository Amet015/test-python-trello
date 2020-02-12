pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        bat 'python --version'
      }
    }
    stage('Install Requirements') {
      steps {
          sh 'pip3 install -r requirements.txt'
      }
    }
    stage('API') {
      steps {
        sh 'behave trello/api/features'
      }
    }
  }
}