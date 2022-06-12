node {
    withEnv(
        [
            'NAME=portal-spa',
            'GREEN=#009933',
            'RED=#cc0000',
        ]
    ) {
            stage('Checkout') {
                checkout([
                    $class: 'GitSCM',
                    branches: [ [ name: "refs/heads/develop" ] ],
                    userRemoteConfigs: [ [
                        url: 'https://github.com/jcode72/php-app.git',
                    ] ]
                ])
            }
            stage('Build') {
                docker.withRegistry( 'https://307997508224.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:jenkins.aws') {
                    def myImage = docker.build ('307997508224.dkr.ecr.us-east-1.amazonaws.com/nginx-php-app', './docker/nginx')
                    myImage.push('latest')
                }
            }
            stage('Deploy') {
                sh 'kubectl rollout restart deployment/nginx-php-app'
            }
    }
}
