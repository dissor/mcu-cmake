set(TARGET "segger_rtt")
add_library(${TARGET} "")

target_sources(${TARGET}
    PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/RTT/SEGGER_RTT.c
    # ${CMAKE_CURRENT_LIST_DIR}/RTT/SEGGER_RTT_printf.c
    # ${CMAKE_CURRENT_LIST_DIR}/Syscalls/SEGGER_RTT_Syscalls_GCC.c
    PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/RTT/SEGGER_RTT.h
    ${CMAKE_CURRENT_LIST_DIR}/Config/SEGGER_RTT_Conf.h
)

target_include_directories(${TARGET}
    PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/RTT
    ${CMAKE_CURRENT_LIST_DIR}/Config
)