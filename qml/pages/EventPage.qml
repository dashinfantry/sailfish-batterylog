import QtQuick 2.0
import Sailfish.Silica 1.0

import "../components"
import "../globals.js" as Globals

Page
{
    id: page

    // -----------------------------------------------------------------------

    property bool pageActive: status === PageStatus.Active

    // -----------------------------------------------------------------------

    signal updateEventDuration()

    // -----------------------------------------------------------------------

    function init()
    {
        var currentDate = new Date(Date.now());

        var events = logs.getLatestEnergyEvents(10);
        for (var idx = 0; idx < events.length; ++idx)
        {
            var time     = events[idx][0];
            var energy   = events[idx][1];
            var charging = events[idx][2];
            var event    = events[idx][3];
            addItem(time, energy, charging, event);
        }
    }

    function addItem(time, energy, charging, event)
    {
        if (event !== "")
        {
            itemModel.append({"itemTime": time, "itemEnergy": energy, "itemCharging": charging, "itemEvent": event});
            itemListScrollTimer.start();
        }
    }

    // -----------------------------------------------------------------------

    allowedOrientations: Orientation.Portrait
    onPageActiveChanged:
    {
        if (pageActive)
        {
            itemList.scrollToTop();
            updateEventDuration();
            updateDurationTimer.start();
        }
        else
        {
            updateDurationTimer.stop();
        }
    }

    // -----------------------------------------------------------------------

    ListModel
    {
        id: itemModel
    }

    Item
    {
        anchors { fill: parent; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }

        PageHeader
        {
            id: header

            title: qsTr("Event Log")
            anchors { left: parent.left; right: parent.right; top: parent.top }
        }
        SilicaListView
        {
            id: itemList

            anchors { left: parent.left; right: parent.right; top: header.bottom; bottom: parent.bottom }
            model: itemModel
            verticalLayoutDirection: ListView.BottomToTop
            clip: true
            delegate: Event {
                time: itemTime
                energy: itemEnergy
                charging: itemCharging
                event: itemEvent

                nextTime: index + 1 < itemModel.count ? itemModel.get(index + 1).itemTime : new Date(Date.now())
                nextEnergy: index + 1 < itemModel.count ? itemModel.get(index + 1).itemEnergy : 0
                nextEvent: index + 1 < itemModel.count ? itemModel.get(index + 1).itemEvent : ""

                Component.onCompleted:
                {
                    updateEventDuration.connect(updateCurrentEventDuration);
                }
                Component.onDestruction:
                {
                    updateEventDuration.disconnect(updateCurrentEventDuration);
                }
            }
            add: Transition {
                NumberAnimation { easing.type: Easing.OutExpo; properties: "opacity"; from: 0; to: 1; duration: 400 }
            }
            addDisplaced: Transition {
                NumberAnimation { easing.type: Easing.OutExpo; properties: "y"; duration: 400 }
            }
            displaced: Transition {
                NumberAnimation { properties: "opacity"; to: 1; duration: 400 }
            }

            VerticalScrollDecorator {}
        }
        Timer
        {
            id: itemListScrollTimer

            interval: 500
            repeat: false
            onTriggered:
            {
                itemList.scrollToTop();
            }
        }
    }
    Timer
    {
        id: updateDurationTimer

        interval: 10000
        repeat: false
        onTriggered:
        {
            updateEventDuration();
            start();
        }
    }
}
