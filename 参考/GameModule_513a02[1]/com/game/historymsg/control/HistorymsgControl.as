package com.game.historymsg.control
{
    import com.game.historymsg.bean.*;
    import com.game.historymsg.event.*;
    import com.game.historymsg.message.*;
    import com.game.historymsg.model.*;
    import com.game.historymsg.view.*;
    import flash.events.*;

    public class HistorymsgControl extends Object
    {
        private var historymsgData:HistorymsgData;
        public var msgIcon:HistorymsgIcon;
        public var msgListPanel:HistorymsgListPanel;
        public var msgPanel:HistorymsgPanel;
        private static var instance:HistorymsgControl;

        public function HistorymsgControl()
        {
            this.historymsgData = HistorymsgData.getInstance();
            this.historymsgData.addEventListener(HistorymsgEvent.HISTORYMSG_DATA_CHANGE, this.onHistorymsgDataChange);
            return;
        }// end function

        public function openMsgListPanel() : void
        {
            if (!this.msgListPanel)
            {
                this.msgListPanel = new HistorymsgListPanel();
            }
            this.msgListPanel.open();
            return;
        }// end function

        private function onHistorymsgDataChange(event:Event) : void
        {
            this.judgeMsgIconVisible();
            return;
        }// end function

        public function judgeMsgIconVisible() : void
        {
            if ((this.msgListPanel == null || !this.msgListPanel.showing) && this.historymsgData.hasMsgs())
            {
                if (!this.msgIcon)
                {
                    this.msgIcon = new HistorymsgIcon();
                }
                this.msgIcon.show();
            }
            else if (this.msgIcon)
            {
                this.msgIcon.hide();
            }
            return;
        }// end function

        public function seeMsg(param1:HistorymsgMsg) : void
        {
            if (!this.msgPanel)
            {
                this.msgPanel = new HistorymsgPanel();
            }
            this.msgPanel.show(param1);
            this.removeMsg(param1);
            return;
        }// end function

        public function removeMsg(param1:HistorymsgMsg) : void
        {
            this.historymsgData.removeMsg(param1);
            return;
        }// end function

        public function clearMsgs() : void
        {
            this.historymsgData.clearMsgs();
            return;
        }// end function

        public function resAddHistorymsg(param1:ResAddHistorymsgMessage) : void
        {
            this.historymsgData.addMsg(param1.msg);
            return;
        }// end function

        public static function getInstance() : HistorymsgControl
        {
            var _loc_1:* = new HistorymsgControl;
            instance = new HistorymsgControl;
            return instance || _loc_1;
        }// end function

    }
}
