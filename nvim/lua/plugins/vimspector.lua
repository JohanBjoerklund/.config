return {
  'puremourning/vimspector',
  build = ':VimspectorInstall vscode-node-debug2 netcoredbg',
  keys = {
    {
      '<localleader>dl',
      '<Plug>VimspectorLaunch',
      desc = 'Launch Vimspector',
    },
    {
      '<localleader>di',
      '<Plug>VimspectorBalloonEval',
      mode = { 'n', 'x' },
      desc = 'Balloon Eval Vimpector',
    },
    {
      '<localleader>ds',
      '<Plug>VimspectorStop',
      mode = { 'n', 'x' },
      desc = 'Stop Vimspector',
    },
    {
      '<localleader>dc',
      '<Plug>VimspectorContinue',
      desc = 'Continue Vimspector',
    },
    {
      '<localleader>dt',
      '<Plug>VimspectorToggleBreakpoint',
      desc = 'Toggle Breakpoint Vimspector',
    },
    {
      '<localleader>dtc',
      '<Plug>VimspectorToggleConditionalBreakpoint',
      desc = 'Toggle Conditional Breakpoint Vimspector',
    },
    {
      '<localleader>dT',
      '<Plug>VimspectorClearBreakpoints',
      desc = 'Clear Breakpoints Vimspector',
    },
    {
      '<localleader>dk',
      '<Plug>VimspectorRestart',
      desc = 'Restart Vimspector',
    }, 
    {
      '<localleader>doo',
      '<Plug>VimspectorStepOut',
      desc = 'Step Out Vimspector',
    },
    {
      '<localleader>dsi',
      '<Plug>VimspectorStepInto',
      desc = 'Step Into Vimspector',
    },
    {
      '<localleader>dso',
      '<Plug>VimspectorStepOver',
      desc = 'Step Over Vimspector',
    },
    {
      '<localleader>dtl',
      '<Plug>VimspectorGoToCurrentLine',
      desc = 'Go To Current Line Vimspector',
    },
    {
      '<localleader>drc',
      '<Plug>VimspectorRunToCursor',
      desc = 'Run To Cursor Vimspector',
    },
    {
      '<localleader>dq',
      ':call vimspector#Reset()<CR>',
      desc = 'Reset Vimspector',
    },
  },
}
