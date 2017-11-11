import QtQuick 2.6
import QtQuick.Layouts 1.3

Item {
    id: root

    ColumnLayout {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -160

        BasicLabel {
            text: qsTr("CAM info")
            font.weight: Font.Medium
            Layout.alignment: Qt.AlignHCenter
        }

        BasicLabel {
            text: qsTr("CAM application manufacturer: %1")
                .arg(jkAccessProvider.camInfo.applicationManufacturer);
            Layout.alignment: Qt.AlignHCenter
        }

        BasicLabel {
            text: qsTr("CAM Menu string: %1")
                .arg(jkAccessProvider.camInfo.menuString)
            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            width: root.width
            height: root.height / 6
            BasicLabel {
                anchors.fill: parent
                text: qsTr("CAM supports the following ca sistem ids: %1")
                    .arg(jkAccessProvider.caids);
                wrapMode: Text.WordWrap
            }
            Layout.alignment: Qt.AlignHCenter
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 40

        BasicLabel {
            text: qsTr("MMI CAM Menu")
            font.weight: Font.Medium
            Layout.alignment: Qt.AlignHCenter
        }

        BasicLabel {
            text: jkAccessProvider.mmiCamMenu
            horizontalAlignment: Text.AlignLeft
            onTextChanged: console.log(text)
        }
    }

    Image {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -60
        source: "qrc:/images/cam-module-info-delimiter.png"
    }

    RowLayout {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 135

        spacing: 20

        BasicLineEdit {
            id: command
            placeholderText: qsTr("Enter value")
            background: Image {
                source: "qrc:/images/cam-module-line-edit-bg.png"
            }
            hint: qsTr("Enter CAM module value")
        }

        BasicPushButton {
            caption: qsTr("Send")
            hint: qsTr("Send CAM module value")
            onClicked: {
                jkAccessProvider.sendMmiCommand(command.text);
                command.text = "";
            }
        }
    }

    Component.onCompleted: jkAccessProvider.startMmiSession()
}
