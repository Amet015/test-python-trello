pipeline {
  agent any
  triggers {
    pollSCM('* * * * *')
  }
  stages {
    stage('build') {
      steps {
        bat 'python --version'
      }
    }
    stage('Install Requirements') {
      steps {
          bat 'pip3 install -r requirements.txt'
      }
    }
    stage('API') {
      steps {
        bat 'behave trello/api/features --tags=~@wip --tags=~@defect'
      }
    }
  }
}