import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("Ryan's First Qt App")
    width: 640
    height: 480
    visible: true

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: ryanDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }

    function submitPost(postString) {
                    var request = new XMLHttpRequest();
                    request.onreadystatechange=function() {
                        // Need to wait for the DONE state or you'll get errors
                        if(request.readyState === XMLHttpRequest.DONE) {
                            if (request.status === 200) {
                                console.log("Response = " + request.responseText);
                                // if response is JSON you can parse it
                                var response = JSON.parse(request.responseText);
                                // then do something with it here

                            }
                            else {
                                // This is very handy for finding out why your web service won't talk to you
                                console.log("Status: " + request.status + ", Status Text: " + request.statusText);
                            }
                        }
                    }
                    // Make sure whatever you post is URI encoded
                    var encodedString = encodeURIComponent(postString);
                    // This is for a POST request but GET etc. work fine too
                    request.open("GET", "http://spatialserver.spatialdev.com/services/tables/library_2014/query?format=geojson&returnGeometry=yes&returnGeometryEnvelopes=no&limit=10", true); // only async supported
                    // You might not need an auth header, or might need to modify - check web service docs
                    //request.setRequestHeader("Authorization", "Bearer " + yourAccessToken);
                    // Post types other than forms should work fine too but I've not tried
                    request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    // Form data is web service dependent - check parameter format
                    var requestString = "text=" + encodedString;
                    request.send(requestString);
    }


    MainForm {
        anchors.fill: parent
        button1.onClicked: ryanDialog.show(qsTr("Button 1 pressed"))
        button2.onClicked: ryanDialog.show(qsTr("Button 2 pressed"))
        button3.onClicked: {

            //ryanDialog.show(qsTr("Button 3 pressed"))
            console.log("Clicked 3")
            submitPost("foo");
            console.log("passed post.")
        }
    }

    MessageDialog {
        id: ryanDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            ryanDialog.text = caption;
            ryanDialog.open();
        }
    }
}
