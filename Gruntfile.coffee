module.exports = (grunt) ->

  grunt.initConfig

    config: grunt.file.readJSON("shopify.json")
    pkg: grunt.file.readJSON("package.json")

    shopify:
      options:
        api_key: "<%= config.private_api %>"
        password: "<%= config.private_password %>"
        url: "<%= config.shop_url %>"
        theme: "<%= config.theme_id %>"

    notify:
      shopify:
        options:
          title: 'Shopify'
          message: 'Files finished uploading'

    imagemin:
      dynamic:
        options:
          optimizationLevel: 3
        files: [{
          expand: true
          cwd: 'images/'
          src: ['**/*.{png,jpg,gif,svg}']
          dest: 'assets/'
        }]

    concat:
      dist:
        src: [
          "styles/global/mixins.scss"
          "styles/global/*"
          "styles/snippets/*"
          "styles/templates/*"
          "styles/misc/*"
        ]
        dest: "assets/timber.scss.liquid"

    clean: ['*.zip']

    compress:
      main:
        options:
          mode: 'zip'
          archive: '<%= pkg.name %>-v<%= pkg.version %>.zip'
        files: [
          src: [
            'assets/*'
            'config/*'
            'layout/*'
            'locales/*'
            'snippets/*'
            'templates/*'
            'templates/customers/*'
          ]
        ]

    watch:
      styles:
        files: ["styles/**/*"]
        tasks: ["concat"]
      images:
        files: ["images/**/*"]
        tasks: ["imagemin"]
      shopify:
        files: ["assets/*","config/*","layout/*","locales/*","snippets/*","templates/**/*"]
        tasks: ["shopify","notify"]

  # Load NPM task plugins
  # ---------------------------
  require('load-grunt-tasks')(grunt)

  # Register tasks
  # ---------------------------
  grunt.registerTask('default', ['watch'])
  grunt.registerTask('deploy', ['concat','imagemin','shopify:upload'])
  grunt.registerTask('package', ['concat','imagemin','clean','compress'])
