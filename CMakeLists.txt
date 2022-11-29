cmake_minimum_required(VERSION 3.5 FATAL_ERROR)
project(recipe LANGUAGES C ASM)

# 生成compile_commands.json文件
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# 编译模式
set(CMAKE_BUILD_TYPE "Debug")


# 导入子模块
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(arm-none-eabi-gcc)
include(definitions)
include(project-settings)


# 导入子目录
add_subdirectory(examples)
add_subdirectory(components)
add_subdirectory(projects)