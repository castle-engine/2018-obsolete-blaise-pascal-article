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
        dir ('3d_game/') {
          sh 'castle-engine compile'
        }
      }
    }
    stage('Build CGE Lazarus packages (by lazbuild)') {
      steps {
        sh 'echo "Castle Game Engine in ${CASTLE_ENGINE_PATH}"'
        sh 'lazbuild --add-package-link "${CASTLE_ENGINE_PATH}"src/vampyre_imaginglib/src/Packages/VampyreImagingPackage.lpk'
        sh 'lazbuild --add-package-link "${CASTLE_ENGINE_PATH}"src/vampyre_imaginglib/src/Packages/VampyreImagingPackageExt.lpk'
        sh 'lazbuild --add-package-link "${CASTLE_ENGINE_PATH}"packages/castle_base.lpk'
        sh 'lazbuild --add-package-link "${CASTLE_ENGINE_PATH}"packages/castle_window.lpk'
        sh 'lazbuild --add-package-link "${CASTLE_ENGINE_PATH}"packages/castle_components.lpk'
      }
    }
    stage('Build TCastleWindow version (by lazbuild)') {
      steps {
        dir ('3d_game/') {
          sh 'lazbuild my_game.lpi'
        }
      }
    }
    stage('Build TCastleControl version (by lazbuild)') {
      steps {
        dir ('3d_game_alternative_using_castlecontrol/') {
          sh 'lazbuild my_game_castlecontrol.lpi'
        }
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
