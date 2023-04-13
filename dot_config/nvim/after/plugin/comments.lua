local status, comments = pcall(require, 'todo-comments')
if (not status) then return end

comments.setup {
    highlight = {
        multiline = true, -- enable multiline todo
        multiline_pattern = '^.',
        multiline_context = 10,
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:*]],
        comments_only = true,
        max_line_len = 400,
        exclude = {}
    },
    search = {
        command = 'rg',
        args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column"
        },
        pattern = [[\b(KEYWORDS)(\([^\)]*\))?:*]]
    }
}
