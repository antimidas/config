import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: window

            required property var modelData
            visible: modelData.name === "HDMI-A-2"
            screen: modelData

            width: 1024
            height: 600
            color: "#1e1e2e"

            exclusionMode: ExclusionMode.Ignore

            anchors {
                top: false
                bottom: false
                left: false
                right: false
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15

                Text {
                    text: "Audio Mixing Deck"
                    color: "#cdd6f4"
                    font.pixelSize: 24
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: Pipewire.nodes
                    spacing: 10

                    delegate: Rectangle {
                        required property var modelData

                        visible: modelData.audio !== null && modelData.description !== ""
                        width: parent.width
                        height: visible ? 70 : 0
                        color: "#313244"
                        radius: 12

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 15
                            spacing: 20

                            Text {
                                text: modelData.description || modelData.name
                                color: "#cdd6f4"
                                font.pixelSize: 16
                                Layout.preferredWidth: 250
                                elide: Text.ElideRight
                            }

                            Slider {
                                id: volSlider
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                from: 0
                                to: 1.5
                                value: modelData.audio?.volume ?? 0

                                onMoved: {
                                    if (modelData.audio) {
                                        modelData.audio.volume = value
                                    }
                                }
                            }

                            Text {
                                text: Math.round((volSlider.value * 100)) + "%"
                                color: "#a6e3a1"
                                font.pixelSize: 14
                                Layout.preferredWidth: 50
                            }

                            Button {
                                Layout.preferredWidth: 80
                                Layout.preferredHeight: 40
                                text: modelData.audio?.muted ? "Muted" : "Mute"

                                onClicked: {
                                    if (modelData.audio) {
                                        modelData.audio.muted = !modelData.audio.muted
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
