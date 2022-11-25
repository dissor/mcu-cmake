cmake_minimum_required(VERSION 3.5 FATAL_ERROR)
project(recipe LANGUAGES C ASM)

# 编译模式
set(CMAKE_BUILD_TYPE "Debug")

# 工具链
set(GCC_PATH "/opt/gcc-arm-none-eabi-10.3-2021.10/bin")
set(PREFIX "arm-none-eabi-")
set(CMAKE_C_COMPILER ${GCC_PATH}/${PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${GCC_PATH}/${PREFIX}gcc)

# 生成工具
set(CP ${GCC_PATH}/${PREFIX}objcopy)
set(SZ ${GCC_PATH}/${PREFIX}size)

message(STATUS "${CMAKE_C_COMPILER}")

# 宏定义
add_definitions(
    -DUSE_HAL_DRIVER
    -DSTM32F103xB
)

# 编译选项
set(CPU "-mcpu=cortex-m3")

# set(FPU "")
# set(FLOAT-AB "")
set(MCU "${CPU} -mthumb ${FPU} ${FLOAT-ABI}")
message(STATUS "${MCU}")

# set(OPT "-Og")
set(CMAKE_C_FLAGS "${MCU} ${OPT} -Wall -fdata-sections -ffunction-sections -g -gdwarf-2")
set(CMAKE_C_FLAGS_DEBUG "-g -gdwarf-2")
set(CMAKE_C_FLAGS_RELEASE "")
message(STATUS "${CMAKE_C_FLAGS}")

SET(CMAKE_ASM_FLAGS "${MCU} ${OPT} -x assembler-with-cpp -Wall -fdata-sections -ffunction-sections")
message(STATUS "${CMAKE_ASM_FLAGS}")

# TODO：模块芯片库
set(STM32F1xx_LIB "commponents/STM32Cube_FW_F1_V1.8.0")

include_directories(
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Inc
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy
    ${STM32F1xx_LIB}/Drivers/CMSIS/Device/ST/STM32F1xx/Include
    ${STM32F1xx_LIB}/Drivers/CMSIS/Include
    example/hello_cmake/Inc
)

add_library(stm32_lib
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim.c
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim_ex.c
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c
    ${STM32F1xx_LIB}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_exti.c
)

# 链接脚本
set(LDSCRIPT /root/mcu_cmake/example/hello_cmake/STM32F103CBTx_FLASH.ld)
set(LIBS "-lc -lm -lnosys")

# set(LIBDIR "")
set(CMAKE_EXE_LINKER_FLAGS
    "${MCU} -specs=nano.specs -T${LDSCRIPT} ${LIBS} ${LIBDIR} -Wl,-Map=${PROJECT_BINARY_DIR}/${PROJECT_NAME}.map,--cref -Wl,--gc-sections"
)

# 生成项目文件
add_executable(${PROJECT_NAME}.elf
    example/hello_cmake/Src/main.c
    example/hello_cmake/Src/stm32f1xx_hal_msp.c
    example/hello_cmake/Src/stm32f1xx_it.c
    example/hello_cmake/Src/system_stm32f1xx.c
    example/hello_cmake/startup_stm32f103xb.s
)
target_link_libraries(${PROJECT_NAME}.elf
    stm32_lib
)

# 生成输出文件
set(ELF_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.elf)
set(HEX_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bin)
message(STATUS "PROJECT_BINARY_DIR: ${PROJECT_BINARY_DIR}")
message(STATUS "CMAKE_CURRENT_BINARY_DIR: ${CMAKE_CURRENT_BINARY_DIR}")

add_custom_command(TARGET "${PROJECT_NAME}.elf" POST_BUILD
    COMMAND ${SZ} --format=berkeley ${PROJECT_NAME}.elf
    COMMAND ${CP} -O ihex ${ELF_FILE} ${HEX_FILE}
    COMMAND ${CP} -O binary -S ${ELF_FILE} ${BIN_FILE}
    COMMENT "Building ${PROJECT_NAME}.bin and ${PROJECT_NAME}.hex"

    # COMMAND ${CMAKE_COMMAND} -E copy ${HEX_FILE} "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.hex"
    # COMMAND ${CMAKE_COMMAND} -E copy ${BIN_FILE} "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.bin"
)
