module.exports = {
  config: {
    // default font size in pixels for all tabs
    fontSize: 15,

    // font family with optional fallbacks
    fontFamily: '"Fira Code", Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: 'rgba(255, 255, 255, 0.9)',

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'UNDERLINE',

    // color of the text
    foregroundColor: '#959dcb', // #ffffff

    // terminal background color
    backgroundColor: '#292d3e', // #13141b

    // border color (window, tabs)
    borderColor: '#222222',

    // custom css to embed in the main window
    css: '',

    // custom css to embed in the terminal window
    termCSS: '',

    // set to `true` (without backticks) if you're using a Linux setup that doesn't show native menus
    // default: `false` on Linux, `true` on Windows (ignored on macOS)
    showHamburgerMenu: false,

    // set to `false` if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` on windows and Linux (ignored on macOS)
    showWindowControls: true,

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: '12px 20px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: '#292d3e', // #000000
      red: '#f07178', // #ff0000
      green: '#c3e88d', // #33ff00
      yellow: '#ffcb6b', // #ffff00
      blue: '#82aaff', // #0066ff
      magenta: '#c792ea', // #cc00ff
      cyan: '#89ddff', // #00ffff
      white: '#d0d0d0', // #d0d0d0
      lightBlack: '#434758', // #808080
      lightRed: '#ff8b92', // #ff0000
      lightGreen: '#ddffa7', // #33ff00
      lightYellow: '#ffe585', // #ffff00
      lightBlue: '#9cc4ff', // #0066ff
      lightMagenta: '#e1acff', // #cc00ff
      lightCyan: '#a3f7ff', // #00ffff
      lightWhite: '#ffffff', // #ffffff
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    // make sure to use a full path if the binary name doesn't work
    // (e.g `C:\\Windows\\System32\\bash.exe` instad of just `bash.exe`)
    // if you're using powershell, make sure to remove the `--login` below
    shell: '/usr/local/bin/zsh',

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to false for no bell
    bell: 'SOUND',

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: true,

    // if true, on right click selected text will be copied or pasted if no
    // selection is present (true by default on Windows)
    //quickEdit: true

    // URL to custom bell
    //bellSoundURL: 'http://example.com/bell.mp3',
    //bellSoundURL: '/Users/bbentley/.hyper_plugins/media/notifications/deez_nuts/ha_gotemmmm.mp3',  // "HA! Gotemmmm"
    //bellSoundURL: '/Users/bbentley/.hyper_plugins/media/notifications/deez_nuts/got_emm.mp3',      // "Got Emm"
    //bellSoundURL: '/Users/bbentley/.hyper_plugins/media/notifications/deez_nuts/deez_nuts.mp3',    // "Deez Nuts"

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    'hypercwd',
    'hyperlinks',
    'hypertheme',
    //'hyper-ayu',
    //'hyper-dracula',
    //'hyper-material-theme',
    'hyper-snazzy',
    //'hyper-solarized-dark',
    //'hyperpower',
    'nord-hyper',
  ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],
};
