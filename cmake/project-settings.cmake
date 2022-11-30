# set(PROJECT_TYPE "examples")
set(PROJECT_TYPE "projects")
set(PROJECT_NAME "iap")
set(PROJECT_LINK "STM32F103CBTx_FLASH.ld")


set(PROJECT_PATH ${CMAKE_SOURCE_DIR}/${PROJECT_TYPE}/${PROJECT_NAME})

# 包含cube头文件
include_directories(
    ${PROJECT_PATH}/cube/Core/Inc
)

# 链接脚本
set(LDSCRIPT ${PROJECT_PATH}/cube/${PROJECT_LINK})
set(LIBS "-lc -lm -lnosys")
# set(LIBDIR "")
set(CMAKE_EXE_LINKER_FLAGS
    "${MCU} -specs=nano.specs -specs=nosys.specs -T${LDSCRIPT} ${LIBS} ${LIBDIR} -Wl,-Map=${PROJECT_BINARY_DIR}/${PROJECT_NAME}.map,--cref -Wl,--gc-sections"
)

# message(STATUS "[${CMAKE_CURRENT_LIST_FILE}](${CMAKE_CURRENT_LIST_LINE}): ${CMAKE_SOURCE_DIR}")