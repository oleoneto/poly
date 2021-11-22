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
    "./app/assets/javascripts/build/**/*.{js,jsx,ts,tsx,vue}",
  ],
  darkMode: 'class',
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
        muted: withOpacity('--color-bg-muted'),
        inverted: withOpacity('--color-bg-inverted'),
        'button-accent': withOpacity('--color-button-accent'),
        'button-accent-hover': withOpacity('--color-button-accent-hover'),
        'button-muted': withOpacity('--color-button-muted')
      },
      borderColor: {
        primary: withOpacity('--color-border-primary'),
        secondary: withOpacity('--color-border-secondary'),
        tertiary: withOpacity('--color-border-tertiary'),
        inverted: withOpacity('--color-border-inverted'),
      },
      textColor: {
        primary: withOpacity('--color-text-primary'),
        secondary: withOpacity('--color-text-secondary'),
        tertiary: withOpacity('--color-text-tertiary'),
        inverted: withOpacity('--color-text-inverted'),
      },
    }
  },
  variants: {
    extend: {
      opacity: ['disabled'],
      backgroundColor: ['disabled'],
      borderColor: ['active']
    }
  },
  plugins: []
};
