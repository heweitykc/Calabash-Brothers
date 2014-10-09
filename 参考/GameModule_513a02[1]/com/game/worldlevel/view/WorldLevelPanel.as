package com.game.worldlevel.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.protect.util.*;
    import com.game.worldlevel.bean.*;
    import com.game.worldlevel.control.*;
    import com.game.worldlevel.event.*;
    import com.game.worldlevel.model.*;
    import com.game.worldlevel.util.*;
    import flash.events.*;
    import flash.text.*;

    public class WorldLevelPanel extends WorldLevelBaseBox
    {
        private var btnClose:BaseButton;
        private var viewWorldLevel:TextField;
        private var viewTime:TextField;
        private var recordViews:Vector.<TextField>;
        private var worldLevelData:WorldLevelData;

        public function WorldLevelPanel()
        {
            this.worldLevelData = WorldLevelData.getInstance();
            loadDisplay("res/worldLevelPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("worldLevelPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            var _loc_4:* = null;
            this.btnClose = ProtectUiUtil.createButton(this, "btnClose", this.onClose);
            this.viewWorldLevel = getDisplayChildByName("viewWorldLevel");
            this.viewTime = getDisplayChildByName("viewTime");
            var _loc_1:* = this.viewTime.x;
            var _loc_2:* = this.viewTime.y + this.viewTime.height + 10;
            this.recordViews = new Vector.<TextField>(WorldLevelConst.maxRecords);
            var _loc_3:* = 0;
            while (_loc_3 < this.recordViews.length)
            {
                
                var _loc_5:* = new TextField();
                this.recordViews[_loc_3] = new TextField();
                _loc_4 = _loc_5;
                _loc_4.defaultTextFormat = new TextFormat(LanguageCfgObj.getInstance().getByIndex("11426"), 12, 16776960);
                _loc_4.width = 300;
                _loc_4.height = 20;
                _loc_4.x = _loc_1;
                _loc_4.y = _loc_2;
                addChild(_loc_4);
                _loc_2 = _loc_2 + (_loc_4.height + 2);
                _loc_3 = _loc_3 + 1;
            }
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (stage)
            {
                this.onAddedToStage();
            }
            return;
        }// end function

        private function onAddedToStage(event:Event = null) : void
        {
            WorldLevelControl.getInstance().reqWorldLevelInfo();
            this.worldLevelData.addEventListener(WorldLevelEvent.WORLD_LEVEL_DATA_CHANGE, this.refreshData);
            this.worldLevelData.addEventListener(WorldLevelEvent.WORLD_LEVEL_DETAIL_CHANGE, this.refreshData);
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            this.worldLevelData.removeEventListener(WorldLevelEvent.WORLD_LEVEL_DATA_CHANGE, this.refreshData);
            this.worldLevelData.removeEventListener(WorldLevelEvent.WORLD_LEVEL_DETAIL_CHANGE, this.refreshData);
            return;
        }// end function

        private function initData() : void
        {
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            this.viewWorldLevel.text = LanguageCfgObj.getInstance().getByIndex("12312") + this.worldLevelData.worldLevel;
            this.viewTime.text = LanguageCfgObj.getInstance().getByIndex("12313") + WorldLevelUtil.getDateYYYYMMDDHHSS(this.worldLevelData.lastUpdateTime);
            var _loc_2:* = this.worldLevelData.records;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                this.recordViews[_loc_3].visible = true;
                this.refreshRecord(this.recordViews[_loc_3], _loc_2[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            while (_loc_3 < this.recordViews.length)
            {
                
                this.recordViews[_loc_3].visible = false;
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private function refreshRecord(param1:TextField, param2:WorldLevelRecord) : void
        {
            param1.text = param2.ranking + " " + param2.name + " " + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11817"), [param2.level]);
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

    }
}
