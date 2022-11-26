if(${PROJECT_PATH} STREQUAL ${CMAKE_CURRENT_LIST_DIR})

# 生成项目文件
add_executable(${PROJECT_NAME}.elf 
    ${CMAKE_CURRENT_SOURCE_DIR}/cube/Core/Src/main.c
    ${CMAKE_CURRENT_SOURCE_DIR}/cube/Core/Src/stm32f1xx_hal_msp.c
    ${CMAKE_CURRENT_SOURCE_DIR}/cube/Core/Src/stm32f1xx_it.c
    ${CMAKE_CURRENT_SOURCE_DIR}/cube/Core/Src/system_stm32f1xx.c
    ${CMAKE_CURRENT_SOURCE_DIR}/cube/startup_stm32f103xb.s
)
target_link_libraries(${PROJECT_NAME}.elf
    stm32_lib
)

# 生成输出文件
set(ELF_FILE ${PROJECT_NAME}.elf)
set(HEX_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bin)

add_custom_command(TARGET "${PROJECT_NAME}.elf" 
POST_BUILD
    COMMAND ${SZ} --format=berkeley ${PROJECT_NAME}.elf
    COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_NAME}.elf ${PROJECT_BINARY_DIR}/mcu_out.elf
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/cube/STM32F103xx.svd ${PROJECT_BINARY_DIR}/mcu_out.svd
    COMMAND ${CP} -O ihex ${ELF_FILE} ${HEX_FILE}
    COMMAND ${CP} -O binary -S ${ELF_FILE} ${BIN_FILE}
    COMMENT "Building ${PROJECT_NAME}.bin and ${PROJECT_NAME}.hex"
)

endif()