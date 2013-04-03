module.exports = (grunt) ->
  'use strict'

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

  # Configuration
  # =============
  grunt.initConfig

    # Cleanup
    # -------
    clean:
      all: [
        'build',
        'temp'
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
          cwd: 'temp/scripts-amd'
          dest: 'temp/scripts'
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
          cwd: 'src/scripts'
          dest: 'temp/scripts'
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
          cwd: 'src/templates'
          dest: 'temp/scripts/templates'
          src: '**/*.haml'
          ext: '.js'
        ]

        options:
          target: 'js'

      'temp/index.html': 'src/index.haml'

    # Bundle conversion
    # -----------------
    urequire:
      convert:
        template: 'AMD'
        bundlePath: 'temp/scripts/'
        outputPath: 'temp/scripts-amd/'

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
          require('connect-url-rewrite') ['^([^.]+)$ /']
          require('grunt-contrib-livereload/lib/utils').livereloadSnippet
          connect.static options.base
        ]

      build:
        options:
          keepalive: true
          base: 'build'

      temp:
        options:
          base: 'temp'

    # Watcher
    # -------
    regarde:
      coffee:
        files: 'src/scripts/**/*.coffee'
        tasks: ['script', 'livereload']

      haml:
        files: 'src/templates/**/*.haml'
        tasks: ['haml:compile', 'livereload']

      index:
        files: 'src/index.haml'
        tasks: ['haml:index', 'livereload']

      # sass:
      #   files: 'src/styles/**/*.scss'
      #   tasks: ['sass:compile', 'livereload']

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
    'connect:temp'
    'regarde'
  ]
