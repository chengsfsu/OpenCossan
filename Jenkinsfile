#!groovy

pipeline {

    // Run in docker container
    agent {
        docker {
            image   'friesischscott/gitlab-ci-matlab'
            args    '-v /opt/MATLAB/R2018b/:/usr/local/MATLAB/from-host -v /home/jenkins/.matlab/R2018b:/.matlab/R2018b --mac-address=$MAC_ADDRESS'
        }
    }

    stages {
        stage("Test") {
            parallel {
                stage("Integration") {
                    steps {
                        sh 'matlab -r run_integration_tests'
                    }
                    post {
                        success {
                            // archive and track test results
                            archive "integrationResults.xml"
                            junit "integrationResults.xml"
                        }
                    }
                }
            }
        }
    }
}
