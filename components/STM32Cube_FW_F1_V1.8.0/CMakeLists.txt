set(TARGET "stm32_lib")
add_library(${TARGET} "")

target_sources(${TARGET}
    PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim.c
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim_ex.c
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c
        ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_exti.c
    PUBLIC ${LIB_INC}
)


target_include_directories(${TARGET}
    PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Inc
    ${CMAKE_CURRENT_LIST_DIR}/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy
    ${CMAKE_CURRENT_LIST_DIR}/Drivers/CMSIS/Device/ST/STM32F1xx/Include
    ${CMAKE_CURRENT_LIST_DIR}/Drivers/CMSIS/Include
)

# message(STATUS "here is components: ${ELF_FILE}")