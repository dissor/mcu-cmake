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


# # 链接脚本
# set(LDSCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/examples/hello_cmake/STM32F103CBTx_FLASH.ld)
# set(LIBS "-lc -lm -lnosys")
# # set(LIBDIR "")
# set(CMAKE_EXE_LINKER_FLAGS
#     "${MCU} -specs=nano.specs -T${LDSCRIPT} ${LIBS} ${LIBDIR} -Wl,-Map=${PROJECT_BINARY_DIR}/${PROJECT_NAME}.map,--cref -Wl,--gc-sections"
# )

# include_directories(
#     ${CMAKE_CURRENT_SOURCE_DIR}/examples/hello_cmake/Inc
# )



# # 生成项目文件
# add_executable(${PROJECT_NAME}.elf 
#     ${CMAKE_CURRENT_SOURCE_DIR}/examples/hello_cmake/Src/main.c
#     ${CMAKE_CURRENT_SOURCE_DIR}/examples/hello_cmake/Src/stm32f1xx_hal_msp.c
#     ${CMAKE_CURRENT_SOURCE_DIR}/examples/hello_cmake/Src/stm32f1xx_it.c
#     ${CMAKE_CURRENT_SOURCE_DIR}/examples/hello_cmake/Src/system_stm32f1xx.c
#     ${CMAKE_CURRENT_SOURCE_DIR}/examples/hello_cmake/startup_stm32f103xb.s
# )
# target_link_libraries(${PROJECT_NAME}.elf
#     stm32_lib
# )

# # 生成输出文件
# set(ELF_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.elf)
# set(HEX_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.hex)
# set(BIN_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bin)

# add_custom_command(TARGET "${PROJECT_NAME}.elf" POST_BUILD
#     COMMAND ${SZ} --format=berkeley ${PROJECT_NAME}.elf
#     COMMAND ${CP} -O ihex ${ELF_FILE} ${HEX_FILE}
#     COMMAND ${CP} -O binary -S ${ELF_FILE} ${BIN_FILE}
#     COMMENT "Building ${PROJECT_NAME}.bin and ${PROJECT_NAME}.hex"
# )

# 导入子目录
add_subdirectory(examples)
add_subdirectory(components)
add_subdirectory(projects)

# file(READ ${PROJECT_BINARY_DIR}/CE_SHI DDDDDDS)
# message(STATUS "[${CMAKE_CURRENT_LIST_FILE}](${CMAKE_CURRENT_LIST_LINE}): ${DDDDDDS}")