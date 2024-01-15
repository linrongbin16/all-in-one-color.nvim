local cwd = vim.fn.getcwd()

describe("colorbox", function()
    local assert_eq = assert.is_equal
    local assert_true = assert.is_true
    local assert_false = assert.is_false

    before_each(function()
        vim.api.nvim_command("cd " .. cwd)
    end)

    local github_actions = os.getenv("GITHUB_ACTIONS") == "true"
    local colorbox = require("colorbox")
    local db = require("colorbox.db")
    colorbox.setup({
        debug = true,
        file_log = true,
    })

    describe("[update]", function()
        it("update", function()
            if not github_actions then
                colorbox.update()
            end
        end)
    end)
    describe("[_primary_color_name_filter]", function()
        it("test", function()
            local ColorNameToColorSpecsMap =
                db.get_color_name_to_color_specs_map()
            local input_color = "tokyonight"
            local input_spec = ColorNameToColorSpecsMap[input_color]
            for _, c in ipairs(input_spec.color_names) do
                local actual = colorbox._builtin_filter_primary(c, input_spec)
                print(
                    string.format(
                        "input color:%s, current color:%s, actual:%s\n",
                        vim.inspect(input_color),
                        vim.inspect(c),
                        vim.inspect(actual)
                    )
                )
                assert_eq(actual, input_color == c)
            end
        end)
    end)
    describe("[filter]", function()
        it("_builtin_filter", function()
            local ColorNameToColorSpecsMap =
                db.get_color_name_to_color_specs_map()
            for color, spec in pairs(ColorNameToColorSpecsMap) do
                local actual = colorbox._builtin_filter("primary", color, spec)
                assert_eq(type(actual), "boolean")
            end
        end)
        it("_function_filter", function()
            local ColorNameToColorSpecsMap =
                db.get_color_name_to_color_specs_map()
            for color, spec in pairs(ColorNameToColorSpecsMap) do
                local actual = colorbox._function_filter(function(c, s)
                    return true
                end, color, spec)
                assert_eq(type(actual), "boolean")
                assert_true(actual)
            end
            for color, spec in pairs(ColorNameToColorSpecsMap) do
                local actual = colorbox._function_filter(function(c, s)
                    return false
                end, color, spec)
                assert_eq(type(actual), "boolean")
                assert_false(actual)
            end
        end)
        it("_all_filter", function()
            local ColorNameToColorSpecsMap =
                db.get_color_name_to_color_specs_map()
            for color, spec in pairs(ColorNameToColorSpecsMap) do
                local actual = colorbox._all_filter({
                    function(c, s)
                        return true
                    end,
                    function(c, s)
                        return true
                    end,
                }, color, spec)
                assert_eq(type(actual), "boolean")
                assert_true(actual)
            end
            for color, spec in pairs(ColorNameToColorSpecsMap) do
                local actual = colorbox._all_filter({
                    function(c, s)
                        return false
                    end,
                    function(c, s)
                        return false
                    end,
                }, color, spec)
                assert_eq(type(actual), "boolean")
                assert_false(actual)
            end
        end)
        it("_filter", function()
            local ColorNameToColorSpecsMap =
                db.get_color_name_to_color_specs_map()
            for color, spec in pairs(ColorNameToColorSpecsMap) do
                local actual = colorbox._filter(color, spec)
                assert_eq(type(actual), "boolean")
            end
        end)
    end)
    describe("[_force_sync_syntax]", function()
        it("test", function()
            colorbox._force_sync_syntax()
        end)
    end)
    describe("[_save_track/_load_previous_track]", function()
        it("test", function()
            colorbox._save_track("tokyonight")
            local actual = colorbox._load_previous_track() --[[@as colorbox.PreviousTrack]]
            print(
                string.format("load previous track:%s\n", vim.inspect(actual))
            )
            if actual ~= nil then
                assert_eq(type(actual), "table")
                assert_eq(type(actual.color_name), "string")
                assert_true(actual.color_number > 0)
            end
        end)
    end)
    describe(
        "[_get_next_color_name_by_idx/_get_prev_color_name_by_idx]",
        function()
            it("_get_next_color_name_by_idx", function()
                local colornames = colorbox._get_filtered_color_names_list()
                local colorindexes =
                    colorbox._get_filtered_color_name_to_index_map()
                for i, c in ipairs(colornames) do
                    local actual = colorbox._get_next_color_name_by_idx(i)
                    if i == #colornames then
                        assert_eq(colorindexes[actual], 1)
                    else
                        assert_eq(i + 1, colorindexes[actual])
                    end
                end
            end)
            it("_get_prev_color_name_by_idx", function()
                local colornames = colorbox._get_filtered_color_names_list()
                local colorindexes =
                    colorbox._get_filtered_color_name_to_index_map()
                for i, c in ipairs(colornames) do
                    local actual = colorbox._get_prev_color_name_by_idx(i)
                    if i == 1 then
                        assert_eq(colorindexes[actual], #colornames)
                    else
                        assert_eq(i - 1, colorindexes[actual])
                    end
                end
            end)
        end
    )
    describe("[_policy]", function()
        it("test", function()
            colorbox._policy_shuffle()
            colorbox._policy_in_order()
            colorbox._policy_reverse_order()
            colorbox._policy_single()
            colorbox._policy()
        end)
    end)
    describe("[_command]", function()
        it("_parse_args", function()
            assert_eq(colorbox._parse_args(""), nil)
            local actual1 = colorbox._parse_args("concurrency=4")
            assert_eq(actual1.concurrency, "4")
            local actual2 = colorbox._parse_args("scale=0.7")
            assert_eq(actual2.scale, "0.7")
        end)
    end)
end)