foreach(
    example
    server
    client
)
boost_add_executable(
    ${example}
    DEPENDS
    boost_system
    TARGET_PREFIX
    "porthopper-"
)
endforeach(
)
