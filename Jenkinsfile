/* -*- mode: groovy -*-
  Confgure how to run our job in Jenkins.
  See https://github.com/castle-engine/castle-engine/wiki/Cloud-Builds-(Jenkins) .
*/

pipeline {
  triggers {
    pollSCM('H/4 * * * *')
    upstream(upstreamProjects: 'castle_game_engine_organization/castle-engine-cloud-builds-tools/master', threshold: hudson.model.Result.SUCCESS)
  }
  agent {
    docker {
      image 'kambi/castle-engine-cloud-builds-tools:cge-unstable'
    }
  }
  stages {
    stage('Build TCastleWindow version (by build tool)') {
      steps {
        sh 'cd 3d_game/ && castle-engine compile'
      }
    }
    /*
    stage('Build CGE Lazarus packages (by lazbuild)') {
      steps {
        sh 'lazbuild "${CASTLE_ENGINE_PATH}"/packages/castle_base.lpk'
        sh 'lazbuild "${CASTLE_ENGINE_PATH}"/packages/castle_window.lpk'
        sh 'lazbuild "${CASTLE_ENGINE_PATH}"/packages/castle_components.lpk'
        // TODO: This fails with
        // Write error: Unable to create file "/usr/local/castle-engine/packages/castle_base.pas"
        // (that is correct, non-root cannot write there),
        // regardless of using --add-package-link .
      }
    }
    */
    /*
    TODO: Cannot compile lpi from Jenkins now, it says "castle_window"
    dependency broken.
    This should work out-of-the-box (ideally) with our Docker image,
    or at least be possible to workaround like above by "Build CGE Lazarus packages",
    but for now I failed.
    */

    stage('Build TCastleWindow version (by lazbuild)') {
      steps {
        sh 'cd 3d_game/ && lazbuild my_game.lpi'
      }
    }
    stage('Build TCastleControl version (by lazbuild)') {
      steps {
        sh 'cd 3d_game_alternative_using_castlecontrol/ && lazbuild my_game.lpi'
      }
    }
  }
  post {
    regression {
      mail to: 'michalis@castle-engine.io',
        subject: "[jenkins] Build started failing: ${currentBuild.fullDisplayName}",
        body: "See the build details on ${env.BUILD_URL}"
    }
    failure {
      mail to: 'michalis@castle-engine.io',
        subject: "[jenkins] Build failed: ${currentBuild.fullDisplayName}",
        body: "See the build details on ${env.BUILD_URL}"
    }
    fixed {
      mail to: 'michalis@castle-engine.io',
        subject: "[jenkins] Build is again successful: ${currentBuild.fullDisplayName}",
        body: "See the build details on ${env.BUILD_URL}"
    }
  }
}
