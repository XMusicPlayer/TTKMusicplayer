import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import Qt.labs.folderlistmodel 2.1

import TTKFileSearchCore 1.0
import "Core"

Item {
    id: ttkScanFolderPage
    width: parent.width
    height: parent.height

    property variant scanPaths: []
    signal pathChanged(variant scanPath)

    TTKFileSearchCore {
        id: searchCore
    }

    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        ///top bar
        Rectangle {
            id: mainMenubar
            Layout.fillWidth: true
            height: dpHeight(ttkTheme.topbar_height)
            color: ttkTheme.topbar_background

            RowLayout {
                spacing: 2
                anchors.fill: parent

                Rectangle {
                    Layout.preferredWidth: dpWidth(50)
                }

                Text {
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: ttkTheme.white
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    font.pixelSize: mainMenubar.height*2/5
                    text: "扫描指定的文件夹"
                }

                TTKTextButton {
                    Layout.preferredWidth: dpWidth(50)
                    Layout.preferredHeight: dpHeight(50)
                    anchors.right: parent.right
                    textColor: ttkTheme.white
                    text: "关闭"

                    onPressed: {
                        ttkOutStackView.pop();
                    }
                }
            }
        }

        ///function area
        Rectangle {
            id: functionArea
            Layout.fillWidth: true
            height: dpHeight(60)
            color: ttkTheme.white

            RowLayout {
                spacing: 0
                anchors.fill: parent

                TTKImageButton {
                    id: goBackButton
                    Layout.preferredWidth: dpWidth(40)
                    Layout.preferredHeight: dpHeight(40)
                    anchors {
                        left: parent.left
                        leftMargin: dpHeight(5)
                    }
                    source: folderModel.parentFolder !== "" ? "qrc:/image/scanning_icon_up"
                                                            : "qrc:/image/scanning_icon_up_disable"
                    onPressed: {
                        if(folderModel.parentFolder !== "") {
                            folderModel.folder = folderModel.parentFolder;
                        }
                    }
                }

                Text {
                    id: filePathArea
                    text: folderModel.folder;
                    Layout.preferredWidth: ttkScanFolderPage.width - dpWidth(80)
                    Layout.fillHeight: true
                    anchors {
                        left: goBackButton.right
                        leftMargin: dpWidth(5)
                    }
                    verticalAlignment: Qt.AlignVCenter
                    font.pixelSize: functionArea.height/3
                    elide: Text.ElideLeft
                    color: "gray"
                }
            }
        }

        ///main body
        Rectangle {
            id: mainBody
            Layout.fillWidth: true
            height: ttkScanFolderPage.height - mainMenubar.height - functionArea.height - bottomArea.height
            color: ttkTheme.alphaLv9

            ListView {
                id: listView
                anchors.fill: parent
                clip: true

                FolderListModel {
                    id: folderModel
                    showFiles: false
                    showHidden: true
                    folder: "file://" + searchCore.getRoot() + "/"
                }

                model: folderModel
                delegate: Rectangle {
                    id: wrapper
                    width: listView.width
                    height: dpHeight(60)
                    color: ttkTheme.alphaLv0

                    RowLayout {
                        spacing: 0
                        anchors.fill: parent

                        CheckBox {
                            id: checkBoxArea
                            Layout.preferredHeight: dpHeight(30)
                            Layout.alignment: Qt.AlignCenter
                            anchors {
                                left: parent.left
                                leftMargin: dpHeight(10)
                            }
                            style: CheckBoxStyle {
                                indicator: Image {
                                    width: dpWidth(30)
                                    height: dpHeight(30)
                                    source: control.checked ? "qrc:/image/ic_lyric_poster_lyric_select"
                                                            : "qrc:/image/ic_lyric_poster_lyric_unselect"
                                }
                            }
                            onClicked: {
                                if(checkBoxArea.checked) {
                                    scanPaths.push(fileURL);
                                }else{
                                    scanPaths.pop(fileURL);
                                }
                            }
                        }

                        Image {
                            id: iconArea
                            Layout.preferredWidth: dpWidth(40)
                            Layout.preferredHeight: dpHeight(40)
                            Layout.alignment: Qt.AlignCenter
                            anchors {
                                left: checkBoxArea.right
                                leftMargin: dpHeight(10)
                            }
                            source: "qrc:/image/custom_file_type_dir"
                        }

                        Text {
                            id: titleArea
                            text: fileName
                            Layout.preferredWidth: ttkScanFolderPage.width - dpHeight(140)
                            Layout.fillHeight: true
                            anchors {
                                left: iconArea.right
                                leftMargin: dpWidth(10)
                            }
                            verticalAlignment: Qt.AlignVCenter
                            font.pixelSize: wrapper.height/3
                            elide: Text.ElideRight

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    scanPaths = [];
                                    listView.currentIndex = index;
                                    folderModel.folder = folderModel.get(index, "fileURL");
                                }
                            }
                        }
                    }

                    Rectangle {
                        width: ttkScanFolderPage.width
                        height: 1
                        anchors {
                            left: parent.left
                            leftMargin: checkBoxArea.width + dpWidth(15)
                            bottom: parent.bottom
                        }
                        color: ttkTheme.alphaLv9
                    }
                }
            }
        }

        ///bottom area
        Rectangle {
            id: bottomArea
            Layout.fillWidth: true
            height: dpHeight(60)
            color: ttkTheme.white

            TTKTextButton {
                anchors.centerIn: parent
                width: dpWidth(180)
                height: dpHeight(40)
                textColor: ttkTheme.white
                color: ttkTheme.topbar_background
                radius: 10
                text: "开始扫描"

                onPressed: {
                    if(scanPaths.length !== 0) {
                        ttkScanFolderPage.pathChanged(scanPaths);
                    }else{
                        ttkFlyInOutBox.color = "red"
                        ttkFlyInOutBox.text = "请选择扫描的文件夹"
                        ttkFlyInOutBox.start();
                    }
                }
            }
        }
    }

    TTKFlyInOutBox {
        id: ttkFlyInOutBox
    }
}
