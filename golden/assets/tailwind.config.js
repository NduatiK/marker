const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
    mode: "jit",
    purge: {
        safelist: [
            'h1',
            'h2',
            'h3',
            'h4',
            'h5',
            'h6',
        ],
        content: ["./js/**/*.js",
            "../lib/element.ex",
            "../Elixir.Element.Input.ex",
            "../lib/element/**/*.*ex", "../lib/*_web/**/*.*ex"
        ]
    },
    theme: {
        extend: {
            fontFamily: {
                sans: ['Inter var', ...defaultTheme.fontFamily.sans],
            }
        },
    },
    variants: {
        extend: {},
    },
    plugins: [
        require('@tailwindcss/forms')
    ],
};
