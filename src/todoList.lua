-- GHCUC EXE - To-Do List Main
-- Task management with local storage

local TodoStorage = require(script.Parent.utils.todoStorage)
local TodoUI = require(script.Parent.ui.todoUI)

-- Initialize
local todoStorage = TodoStorage.new()
local todoUI = TodoUI.new()

-- Create UI
todoUI:createTodoWindow()

-- Refresh tasks display
local function refreshDisplay()
    local tasks = todoStorage:sortByPriority()
    local tasksText = "📋 Tasks:\n\n"
    
    if #tasks == 0 then
        tasksText = "[No tasks yet. Add one to get started!]\n"
    else
        for _, task in ipairs(tasks) do
            local status = task.completed and "✅" or "⭕"
            local priorityEmoji = ""
            
            if task.priority == "high" then
                priorityEmoji = "🔴"
            elseif task.priority == "medium" then
                priorityEmoji = "🟡"
            else
                priorityEmoji = "🟢"
            end
            
            tasksText = tasksText .. string.format(
                "%s %s [%s] %s\n",
                status,
                priorityEmoji,
                task.priority:upper(),
                task.title
            )
        end
    end
    
    todoUI:updateTasksList(tasksText)
    
    -- Update stats
    local total = todoStorage:getTaskCount()
    local completed = #todoStorage:getCompletedTasks()
    local percentage = todoStorage:getCompletionPercentage()
    
    todoUI:updateStats(total, completed, percentage)
end

-- Add task
local function addTask()
    local title = todoUI.elements.taskInput.Text
    local priority = todoUI.elements.priorityBox.Text:lower()
    
    if title == "" then
        todoUI:updateStatus("Please enter a task title!")
        return
    end
    
    if priority ~= "high" and priority ~= "medium" and priority ~= "low" then
        priority = "medium"
    end
    
    todoStorage:addTask(title, "", priority)
    todoUI:clearInput()
    todoUI:updateStatus("Task added successfully!")
    
    refreshDisplay()
end

-- Clear completed tasks
local function clearCompleted()
    local completed = todoStorage:getCompletedTasks()
    for _, task in ipairs(completed) do
        todoStorage:deleteTask(task.id)
    end
    
    todoUI:updateStatus("Completed tasks cleared!")
    refreshDisplay()
end

-- Sort tasks
local function sortTasks()
    todoStorage:sortByPriority()
    todoUI:updateStatus("Tasks sorted by priority!")
    refreshDisplay()
end

-- Connect buttons
todoUI.elements.addBtn.MouseButton1Click:Connect(addTask)
todoUI.elements.clearBtn.MouseButton1Click:Connect(clearCompleted)
todoUI.elements.sortBtn.MouseButton1Click:Connect(sortTasks)

-- Allow right-click on tasks to complete them
local lastClickTime = 0
local clickCount = 0

-- Initial display
refreshDisplay()

-- Startup message
todoUI:updateStatus("Ready - Click 'Add Task' to create a new task!")

print("=== GHCUC To-Do List ===")
print("To-Do List loaded successfully!")
print("Create and manage your tasks!")
print("========================")
