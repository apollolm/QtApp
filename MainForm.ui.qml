import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
    width: 640
    height: 480

    property alias button3: button3
    property alias button2: button2
    property alias button1: button1

    RowLayout {
        anchors.centerIn: parent

        Button {
            id: button1

            property color buttonColor: "#c2c2c2"
            property color onHoverColor: "darkblue"
            property color borderColor: "red"

            text: qsTr("Press Me 1")
        }

        Button {
            id: button2
            text: qsTr("Press Me 2")
        }

        Button {
            id: button3
            text: qsTr("Press Me 3")
        }
    }

    TextInput {
        id: textInput1
        x: 266
        y: 65
        width: 180
        height: 20
        text: qsTr("Text Input")
        font.pixelSize: 12
    }

    Text {
        id: uxDirectionsInput
        x: 116
        y: 65
        width: 138
        height: 15
        text: qsTr("Enter your destination:")
        font.bold: true
        font.pixelSize: 12
    }
}
