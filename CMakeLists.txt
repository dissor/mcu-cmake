cmake_minimum_required(VERSION 3.5 FATAL_ERROR)
project(recipe LANGUAGES C ASM)

set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
set(CMAKE_OBJCOPY arm-none-eabi-objcopy) 
set(CMAKE_SIZE arm-none-eabi-size)

add_definitions(
-DUSE_HAL_DRIVER
-DSTM32F103xB
)


set(MCU_FLAGS "-mcpu=cortex-m3 -mthumb")
set(CMAKE_C_FLAGS "${MCU_FLAGS} -w -Wno-unknown-pragmas")
set(CMAKE_C_FLAGS_DEBUG "-O0 -g2 -ggdb")
set(CMAKE_C_FLAGS_RELEASE "-O3")

SET(CMAKE_ASM_FLAGS "-mcpu=cortex-m3 -mthumb  -x assembler-with-cpp -Wall -fdata-sections -ffunction-sections")

include_directories(
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Inc
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/CMSIS/Device/ST/STM32F1xx/Include
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/CMSIS/Include
    example/Inc
)

add_library(stm32_lib
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim.c
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim_ex.c
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c
    commponents/STM32Cube_FW_F1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_exti.c
)

set(LINKER_SCRIPT /root/mcu_cmake/example/STM32F103CBTx_FLASH.ld)
set(CMAKE_EXE_LINKER_FLAGS
"-mcpu=cortex-m3 -mthumb -specs=nano.specs -T${LINKER_SCRIPT} -lc -lm -lnosys -Wl,-Map=${PROJECT_BINARY_DIR}/${PROJECT_NAME}.map,--cref -Wl,--gc-sections"
)

add_executable(${PROJECT_NAME}.elf 
                example/Src/main.c
                example/Src/stm32f1xx_hal_msp.c
                example/Src/stm32f1xx_it.c
                example/Src/system_stm32f1xx.c
                example/startup_stm32f103xb.s
                )
target_link_libraries(${PROJECT_NAME}.elf
    stm32_lib   
)