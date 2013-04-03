path = require 'path'

module.exports = (grunt) ->
  'use strict'

  # Settings
  # ========

  # Base directory
  # --------------
  # Set this to where you're directory structure is
  # based on.
  baseDirectory = 'frontend'

  # Server
  # ======

  # Port offset
  # -----------
  # Increment this for additional gruntfiles that you want
  # to run simultaneously.
  portOffset = 0

  # Host
  # ----
  # You could this to your IP address to expose it over a local intranet.
  hostname = 'localhost'

  # Router
  # ------
  router = {}
  router["#{ hostname }/api"] = "#{ hostname }:8000/"
  router[hostname] = "#{ hostname }:#{ 3501 + portOffset }"

  # Configuration
  # =============
  grunt.initConfig

    # Cleanup
    # -------
    clean:
      all: [
        "#{ baseDirectory }/build",
        "#{ baseDirectory }/temp"
      ]

    # File management
    # ---------------
    copy:
      options:
        excludeEmpty: true

      bundle:
        files: [
          expand: true
          filter: 'isFile'
          cwd: "#{ baseDirectory }/temp/scripts-amd"
          dest: "#{ baseDirectory }/temp/scripts"
          src: [
            '**/*'
            '!main.js'
            '!vendor/**/*'
            '!templates/**/*'
          ]
        ]

    # Coffee-Script
    # -------------
    coffee:
      compile:
        files: [
          expand: true
          filter: 'isFile'
          cwd: "#{ baseDirectory }/src/scripts"
          dest: "#{ baseDirectory }/temp/scripts"
          src: '**/*.coffee'
          ext: '.js'
        ]

        options:
          bare: true

    # Micro-templates
    # ---------------
    haml:
      options:
        language: 'coffee'
        placement: 'amd'
        uglify: true
        customHtmlEscape: 'haml.escape'
        customPreserve: 'haml.preserve'
        customCleanValue: 'haml.clean'
        dependencies:
          'haml': 'lib/haml'

      compile:
        files: [
          expand: true
          filter: 'isFile'
          cwd: "#{ baseDirectory }/src/templates"
          dest: "#{ baseDirectory }/temp/scripts/templates"
          src: '**/*.haml'
          ext: '.js'
        ]

        options:
          target: 'js'

      index:
        dest: "#{ baseDirectory }/temp/index.html"
        src: "#{ baseDirectory }/src/index.haml"

    # Stylesheets
    # -----------
    sass:
      compile:
        dest: "#{ baseDirectory }/temp/styles/main.css"
        src: "#{ baseDirectory }/src/styles/main.scss"
        options:
          loadPath: require('path').join(__dirname, 'frontend', 'temp')

    # Bundle conversion
    # -----------------
    urequire:
      convert:
        template: 'AMD'
        bundlePath: "#{ baseDirectory }/temp/scripts/"
        outputPath: "#{ baseDirectory }/temp/scripts-amd/"

    # LiveReload
    # ----------
    livereload:
      port: 35728 + portOffset

    # Webserver
    # ---------
    connect:
      options:
        port: 3501 + portOffset
        hostname: hostname
        middleware: (connect, options) -> [
          require('connect-url-rewrite') ['^[^.]*?\\?.*?$ /']
          require('grunt-contrib-livereload/lib/utils').livereloadSnippet
          connect.static options.base
        ]

      build:
        options:
          keepalive: true
          base: "#{ baseDirectory }/build"

      temp:
        options:
          base: "#{ baseDirectory }/temp"

    # Proxy
    # -----
    proxy:
      serve:
        options:
          port: 4501 + portOffset
          router: router

    # Watcher
    # -------
    regarde:
      coffee:
        files: "#{ baseDirectory }/src/scripts/**/*.coffee"
        tasks: ['script', 'livereload']

      haml:
        files: "#{ baseDirectory }/src/templates/**/*.haml"
        tasks: ['haml:compile', 'livereload']

      index:
        files: "#{ baseDirectory }/src/index.haml"
        tasks: ['haml:index', 'livereload']

      sass:
        files: "#{ baseDirectory }/src/styles/**/*.scss"
        tasks: ['sass:compile', 'livereload']

  # Dependencies
  # ============
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  # Tasks
  # =====

  # Prepare
  # -------
  grunt.registerTask 'prepare', [
    'clean'
  ]

  # Script
  # ------
  # Compiles scripts through the pipeline; pushing in common.js coffe-script
  # and outputting AMD javascript.
  grunt.registerTask 'script', [
    'coffee'
    'urequire:convert'
    'copy:bundle'
  ]

  # Server
  # ------
  grunt.registerTask 'server', [
    'livereload-start'
    'script'
    'haml'
    'sass'
    'connect:temp'
    'proxy'
    'regarde'
  ]
