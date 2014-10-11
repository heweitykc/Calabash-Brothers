package com.game.worldlevel.control
{
    import com.events.*;
    import com.game.worldlevel.message.*;
    import com.game.worldlevel.model.*;
    import com.game.worldlevel.protocol.*;
    import com.game.worldlevel.view.*;
    import com.model.*;

    public class WorldLevelControl extends Object
    {
        private var protocol:WorldLevelProtocol;
        private var worldLevelData:WorldLevelData;
        private var worldLevelPanel:WorldLevelPanel;
        private static var instance:WorldLevelControl;

        public function WorldLevelControl()
        {
            this.protocol = new WorldLevelProtocol();
            this.worldLevelData = WorldLevelData.getInstance();
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.SET_MY_INFO, this.onPlayerLevelChange);
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.UPDATE_LEVEL, this.onPlayerLevelChange);
            this.onPlayerLevelChange();
            return;
        }// end function

        public function openWorldLevelPanel() : void
        {
            if (this.worldLevelPanel == null)
            {
                this.worldLevelPanel = new WorldLevelPanel();
            }
            this.worldLevelPanel.open();
            return;
        }// end function

        private function onPlayerLevelChange(event:RoleEvent = null) : void
        {
            this.worldLevelData.refreshPlayerLevel();
            return;
        }// end function

        public function reqWorldLevelInfo() : void
        {
            this.protocol.reqWorldLevelInfo();
            return;
        }// end function

        public function resWorldLevel(param1:ResWorldLevelMessage) : void
        {
            this.worldLevelData.updateWorldLevel(param1);
            return;
        }// end function

        public function resWorldLevelInfo(param1:ResWorldLevelInfoMessage) : void
        {
            this.worldLevelData.updateWorldLevelDetail(param1);
            return;
        }// end function

        public static function getInstance() : WorldLevelControl
        {
            var _loc_1:* = new WorldLevelControl;
            instance = new WorldLevelControl;
            return instance || _loc_1;
        }// end function

    }
}
