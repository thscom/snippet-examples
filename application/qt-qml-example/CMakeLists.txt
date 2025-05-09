cmake_minimum_required(VERSION 3.16)

project(qtqml VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(EXE "appqtqml")

find_package(Qt6 REQUIRED COMPONENTS Quick)


qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(${EXE}
    main.cpp
)

qt_add_qml_module(${EXE}
    URI ${PROJECT_NAME}
    VERSION 1.0
    QML_FILES
        qml/Animate.qml
        qml/Attribute.qml
        qml/BusyIndicator.qml
        qml/Button.qml
        qml/Canvas.qml
        qml/Canvas2.qml
        qml/CheckBox.qml
        qml/ComboBox.qml
        qml/DelayButton.qml
        qml/Dial.qml
        qml/Dialog.qml
        qml/Drawer.qml
        qml/Flickable.qml        
        qml/GridView.qml
        qml/GridViewItem.qml
        qml/ListView.qml
        qml/ChildListView.qml
        qml/Locator.qml
        qml/Main.qml
        qml/MVC.qml
        qml/PathView.qml
        qml/Popup.qml
        qml/ProgressBar.qml      
        qml/Text.qml
        qml/TextEdit.qml
        qml/TextInput.qml

    SOURCES
        include/backend.h
        src/backend.cpp

    RESOURCES
        qml/qml.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(${EXE} PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqtqml
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_include_directories(${EXE} PUBLIC "include")
target_link_libraries(${EXE}
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS ${EXE}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
