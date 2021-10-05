module.exports = {
  plugins: [
    require('postcss-import'),
    require('tailwindcss')('./app/assets/stylesheets/tailwind.config.js'),
    require('autoprefixer')
  ]
}
