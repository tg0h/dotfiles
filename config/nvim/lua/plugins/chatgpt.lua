-- Lazy
return {
  'jackMort/ChatGPT.nvim',
  enabled = false,
  event = 'VeryLazy',
  commit = '24bcca7', -- temporary fix for no url error
  opts = {
    api_key_cmd = nil,
    yank_register = '+',
    edit_with_instructions = {
      diff = false,
      keymaps = {
        close = '<C-c>',
        accept = '<C-y>',
        toggle_diff = '<C-d>',
        toggle_settings = '<C-o>',
        cycle_windows = '<Tab>',
        use_output_as_input = '<C-i>',
      },
    },
    chat = {
      welcome_message = WELCOME_MESSAGE,
      loading_text = 'Loading, please wait ...',
      question_sign = '',
      answer_sign = 'ﮧ',
      max_line_length = 120,
      sessions_window = {
        border = {
          style = 'rounded',
          text = {
            top = ' Sessions ',
          },
        },
        win_options = {
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
        },
      },
      keymaps = {
        close = { '<C-c>' },
        yank_last = '<C-y>',
        yank_last_code = '<C-k>',
        scroll_up = '<C-u>',
        scroll_down = '<C-d>',
        new_session = '<C-n>',
        cycle_windows = '<Tab>',
        cycle_modes = '<C-f>',
        select_session = '<Space>',
        rename_session = 'r',
        delete_session = 'd',
        draft_message = '<C-d>',
        toggle_settings = '<C-o>',
        toggle_message_role = '<C-r>',
        toggle_system_role_open = '<C-s>',
        stop_generating = '<C-x>',
      },
    },
    popup_layout = {
      default = 'center',
      center = {
        width = '80%',
        height = '80%',
      },
      right = {
        width = '30%',
        width_settings_open = '50%',
      },
    },
    popup_window = {
      border = {
        highlight = 'FloatBorder',
        style = 'rounded',
        text = {
          top = ' ChatGPT ',
        },
      },
      win_options = {
        wrap = true,
        linebreak = true,
        foldcolumn = '1',
        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
      },
      buf_options = {
        filetype = 'markdown',
      },
    },
    system_window = {
      border = {
        highlight = 'FloatBorder',
        style = 'rounded',
        text = {
          top = ' SYSTEM ',
        },
      },
      win_options = {
        wrap = true,
        linebreak = true,
        foldcolumn = '2',
        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
      },
    },
    popup_input = {
      prompt = '  ',
      border = {
        highlight = 'FloatBorder',
        style = 'rounded',
        text = {
          top_align = 'center',
          top = ' Prompt ',
        },
      },
      win_options = {
        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
      },
      submit = '<C-Enter>',
      submit_n = '<Enter>',
      max_visible_lines = 20,
    },
    settings_window = {
      border = {
        style = 'rounded',
        text = {
          top = ' Settings ',
        },
      },
      win_options = {
        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
      },
    },
    openai_params = {
      model = 'gpt-3.5-turbo',
      frequency_penalty = 0,
      presence_penalty = 0,
      max_tokens = 300,
      temperature = 0,
      top_p = 1,
      n = 1,
    },
    openai_edit_params = {
      model = 'code-davinci-edit-001',
      temperature = 0,
      top_p = 1,
      n = 1,
    },
    actions_paths = {},
    show_quickfixes_cmd = 'Trouble quickfix',
    predefined_chat_gpt_prompts = 'https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv',
  },
  config = function(_, opts)
    require('chatgpt').setup(opts)

    local chatgpt = require('chatgpt')
    local wk = require('which-key')
    wk.register({
      p = {
        name = 'ChatGPT',
        e = {
          function() chatgpt.edit_with_instructions() end,
          'Edit with instructions',
        },
      },
    }, {
      prefix = '<leader>',
      mode = 'v',
    })

    wk.register({
      v = {
        name = 'ChatGPT',
        h = { '<cmd>ChatGPT<CR>', 'ChatGPT' },
        e = { '<cmd>ChatGPTEditWithInstruction<CR>', 'Edit with instruction' },
        g = { '<cmd>ChatGPTRun grammar_correction<CR>', 'Grammar Correction' },
        t = { '<cmd>ChatGPTRun translate<CR>', 'Translate' },
        k = { '<cmd>ChatGPTRun keywords<CR>', 'Keywords' },
        d = { '<cmd>ChatGPTRun docstring<CR>', 'Docstring' },
        a = { '<cmd>ChatGPTRun add_tests<CR>', 'Add Tests' },
        o = { '<cmd>ChatGPTRun optimize_code<CR>', 'Optimize Code' },
        s = { '<cmd>ChatGPTRun summarize<CR>', 'Summarize' },
        f = { '<cmd>ChatGPTRun fix_bugs<CR>', 'Fix Bugs' },
        x = { '<cmd>ChatGPTRun explain_code<CR>', 'Explain Code' },
        r = { '<cmd>ChatGPTRun roxygen_edit<CR>', 'Roxygen Edit' },
        l = { '<cmd>ChatGPTRun code_readability_analysis<CR>', 'Code Readability Analysis' },
      },
    }, {
      prefix = '<leader>',
      mode = 'n',
    })
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
}
