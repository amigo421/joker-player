import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import tv.jokersys.com 1.0

Image {
    source: "qrc:/images/satellite-transponder-settings-bg.png"

    RowLayout {
        anchors.fill: parent

        ColumnLayout {
            BasicLabel {
                text: qsTr("Standard")
                font.weight: Font.Medium
            }

            StandardsList {
                id: standardsList
                model: jkStandardsProxyModel
                onStandardCodeChanged: jkChannelsProxyModel.standardCode = standardCode

                Layout.fillHeight: true
            }

            Layout.margins: 10
        }

        ColumnLayout {
            ColumnLayout {
                RowLayout {
                    BasicLabel {
                        text: qsTr("Frequency")
                        font.weight: Font.Medium
                    }

                    ChannelsSelectionMenu {
                        opacity: (frequenciesList.count > 0)
                    }
                }

                FrequenciesList {
                    id: frequenciesList
                    width: 120
                    model: jkChannelsProxyModel

                    Layout.fillHeight: true
                }
            }

            RowLayout {
                ChannelScanProgress {
                    id: scanProgress

                    Layout.fillWidth: true
                }

                BasicPushButton {
                    id: scanButton
                    caption: {
                        if (jkAccessProvider.status === JokerAccessProvider.ProgramsDiscoveringStatus) {
                            return qsTr("Stop Scan");
                        } else if (jkAccessProvider.status === JokerAccessProvider.DeviceOpenedStatus
                                   || jkAccessProvider.status === JokerAccessProvider.ProgramsDiscoveredStatus
                                   || jkAccessProvider.status === JokerAccessProvider.ChannelActivated) {
                            return qsTr("Start Scan");
                        } else {
                            return qsTr("Unknown");
                        }
                    }
                    hint: qsTr("Start channel scanning")
                    onClicked: {
                        if (jkAccessProvider.status === JokerAccessProvider.ProgramsDiscoveringStatus) {
                            jkAccessProvider.stopScan();
                        } else if (jkAccessProvider.status === JokerAccessProvider.DeviceOpenedStatus
                                   || jkAccessProvider.status === JokerAccessProvider.ProgramsDiscoveredStatus
                                   || jkAccessProvider.status === JokerAccessProvider.ChannelActivated) {
                            jkAccessProvider.startScan();
                        }
                    }
                }
            }

            Layout.margins: 10
        }
    }

    Component.onDestruction: {
        if (jkAccessProvider.status === JokerAccessProvider.ProgramsDiscoveringStatus)
            jkAccessProvider.stopScan();
    }
}
