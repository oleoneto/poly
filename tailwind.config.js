const colors = require("tailwindcss/colors");

function withOpacity(variableName) {
  return ({ opacityValue }) => {
    return opacityValue !== undefined ?
        `rgba(var(${variableName}), ${opacityValue})` :
        `rgba(var(${variableName}))`
  }
}

module.exports = {
  mode: "jit",
  purge: [
    "./app/**/*.{html,html.erb}",
    "./app/helpers/**/*.rb",
    "./app/assets/javascript?s/**/*.{js,jsx,ts,tsx,vue}"
  ],
  darkMode: 'class',
  corePlugins: {
    preflight: true // remove to skip css reset
  },
  theme: {
    extend: {
      colors: {
          amber: colors.amber,
          'cool-gray': colors.coolGray,
          cyan: colors.cyan,
          rose: colors.rose,
          teal: colors.teal,
          sky: colors.sky,
          'warm-gray': colors.warmGray,
      },
      backgroundColor: {
        primary: withOpacity('--color-bg-primary'),
        secondary: withOpacity('--color-bg-secondary'),
        tertiary: withOpacity('--color-bg-tertiary'),
        inverted: withOpacity('--color-bg-inverted'),
        muted: withOpacity('--color-bg-muted'),
        'button-accent': withOpacity('--color-button-accent'),
        'button-accent-hover': withOpacity('--color-button-accent-hover'),
        'button-muted': withOpacity('--color-button-muted')
      },
      borderColor: {
        primary: withOpacity('--color-border-primary'),
        secondary: withOpacity('--color-border-secondary'),
        tertiary: withOpacity('--color-border-tertiary'),
        muted: withOpacity('--color-border-muted')
      },
      textColor: {
        primary: withOpacity('--color-text-primary'),
        secondary: withOpacity('--color-text-secondary'),
        tertiary: withOpacity('--color-text-tertiary'),
        muted: withOpacity('--color-text-muted'),
        inverted: withOpacity('--color-text-inverted')
      },
      lineClamp: {
        10: '10',
        12: '12'
      }
    }
  },
  variants: {
    extend: {
      opacity: ['disabled'],
      backgroundColor: ['disabled'],
      borderColor: ['active']
    }
  },
  plugins: [
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/line-clamp"),
  ]
};
