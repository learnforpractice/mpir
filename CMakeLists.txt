cmake_minimum_required(VERSION 3.0)

project(mpir)

file(GLOB s1 "fft/*.c")
file(GLOB s2 "mpf/*.c")
file(GLOB s3 "mpn/generic/*.c")
file(GLOB s4 "mpq/*.c")
file(GLOB s5 "mpz/*.c")
file(GLOB s6 "printf/*.c")
add_library(mpz assert.c errno.c memory.c mp_bpl.c mp_minv_tab.c tal-reent.c ${s1} ${s2} ${s3} ${s4} ${s5} ${s6})
target_include_directories(mpz PUBLIC ${CMAKE_SOURCE_DIR})

install(FILES gmp.h DESTINATION include)
install(TARGETS mpz ARCHIVE DESTINATION lib)