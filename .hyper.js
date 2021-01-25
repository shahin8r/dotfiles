module.exports = {
  config: {
    updateChannel: 'stable',
    fontSize: 12,
    fontFamily: '"MesloLGS NF", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    showWindowControls: false,
    shell: '',
    paneNavigation: {
      showIndicators: false,
      hotkeys: {
        navigation: {
                up: 'ctrl+alt+k',
                down: 'ctrl+alt+j',
                left: 'ctrl+alt+h',
                right: 'ctrl+alt+l',
        },
        maximize: 'ctrl+alt+enter'
      }
    }
  },
  plugins: ["hyper-flat", "hyper-pane"]
};
