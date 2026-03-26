return {
  {
    "ErickKramer/nvim-ros2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      autocmds = true,
      treesitter = true,
    },
    keys = {
      { "<leader>ri", function() require("nvim-ros2").pickers.interfaces() end,  desc = "ROS2 interfaces" },
      { "<leader>rn", function() require("nvim-ros2").pickers.nodes() end,       desc = "ROS2 nodes" },
      { "<leader>ra", function() require("nvim-ros2").pickers.actions() end,     desc = "ROS2 actions" },
      { "<leader>rt", function() require("nvim-ros2").pickers.topics_info() end, desc = "ROS2 topics info" },
      { "<leader>re", function() require("nvim-ros2").pickers.topics_echo() end, desc = "ROS2 topics echo" },
      { "<leader>rs", function() require("nvim-ros2").pickers.services() end,    desc = "ROS2 services" },
    },
  },
}
