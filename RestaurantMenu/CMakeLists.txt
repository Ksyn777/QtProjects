cmake_minimum_required(VERSION 3.16)

project(RestaurantMenu VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appRestaurantMenu
    main.cpp
)

qt_add_qml_module(appRestaurantMenu
    URI RestaurantMenu
    QML_FILES
        Main.qml
        RESOURCES images/dark/cart_add.svg images/dark/cart_remove.svg images/dark/checkout.svg images/dark/mild.svg images/dark/very_hot.svg images/light/cart_add.svg images/light/cart_remove.svg images/light/checkout.svg images/light/mild.svg images/light/very_hot.svg images/curry.jpg
        QML_FILES MenuControl.qml
        QML_FILES MenuSide.qml
        QML_FILES MenuItemRow.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appRestaurantMenu PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appRestaurantMenu
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appRestaurantMenu
    PRIVATE Qt6::Quick
)

install(TARGETS appRestaurantMenu
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
