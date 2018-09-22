node{

   stage('SCM Checkout'){
       git credentialsId: '41238c82-d394-4d1e-95e1-f993a46502e5', url: 'https://github.com/Nethaji450/gradle-web-app.git'


   }
       stage('Gradle Clean Build'){
           def gradle_version = 'gradle'

withEnv( ["PATH+GRADLE=${tool gradle_version}/bin"] ){
       sh 'gradle clean build'
   }
       }
        stage('Build Docker Image'){
        sh 'docker build -t nethaji/jen-doc .'
    }
    stage('docker-push') {
    withCredentials([string(credentialsId: 'a26238bd-73bf-4d57-a418-81c3f25e2ed1', variable: 'dockercredentials')]) {
    sh 'docker login -u nethaji  -p ${dockercredentials}'

}
sh 'docker  push nethaji/jen-doc'

    
}
stage('docker-deploy-2ndserver') {
    def dockerRun = ' docker run  -d -p 8080:8080 --name gradle-web-app nethaji/jen-doc'
    sshagent(['f6f5ed22-aebd-4c10-b079-b6b8ddec3291']) {
   sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.1.1.239 docker stop gradle-web-app || true'
         sh 'ssh  ec2-user@10.1.1.239 docker rm gradle-web-app || true'
         sh 'ssh  ec2-user@10.1.1.239 docker rmi -f  $(docker images -q) || true'
          sh "ssh  ec2-user@10.1.1.239 ${dockerRun}"
}

}

}
