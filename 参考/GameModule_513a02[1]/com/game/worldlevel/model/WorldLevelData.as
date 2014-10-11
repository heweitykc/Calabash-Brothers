package com.game.worldlevel.model
{
    import __AS3__.vec.*;
    import com.game.worldlevel.bean.*;
    import com.game.worldlevel.event.*;
    import com.game.worldlevel.message.*;
    import com.model.*;
    import flash.events.*;

    public class WorldLevelData extends EventDispatcher
    {
        public var worldLevel:int = 0;
        public var records:Vector.<WorldLevelRecord>;
        public var lastUpdateTime:Date;
        private static var instance:WorldLevelData;

        public function WorldLevelData()
        {
            this.records = new Vector.<WorldLevelRecord>;
            this.lastUpdateTime = new Date(0);
            return;
        }// end function

        public function isWorldLevelEnabled() : Boolean
        {
            return this.playerLevel >= WorldLevelConst.worldLevelEnablePlayerLevel;
        }// end function

        public function get playerLevel() : int
        {
            return UserObj.getInstance().playerInfo.level;
        }// end function

        public function get additionActiveMinPlayerLevel() : int
        {
            return WorldLevelConst.worldLevelEnablePlayerLevel;
        }// end function

        public function get additionActiveMaxPlayerLevel() : int
        {
            return this.worldLevel - WorldLevelConst.worldLevelEnableMinPlayerLevelDif;
        }// end function

        public function isAdditionActive() : Boolean
        {
            return this.playerLevel >= this.additionActiveMinPlayerLevel && this.playerLevel <= this.additionActiveMaxPlayerLevel;
        }// end function

        public function getLevelDif() : int
        {
            return this.worldLevel - this.playerLevel;
        }// end function

        public function getExpAddition() : Number
        {
            return WorldLevelConst.getExpAddition(this.worldLevel);
        }// end function

        public function getExpRecoverAddition() : Number
        {
            return WorldLevelConst.getExpRecoverAddition(this.worldLevel);
        }// end function

        public function refreshPlayerLevel() : void
        {
            dispatchEvent(new WorldLevelEvent(WorldLevelEvent.WORLD_LEVEL_DATA_CHANGE));
            return;
        }// end function

        public function updateWorldLevel(param1:ResWorldLevelMessage) : void
        {
            this.worldLevel = param1.worldLevel;
            dispatchEvent(new WorldLevelEvent(WorldLevelEvent.WORLD_LEVEL_DATA_CHANGE));
            return;
        }// end function

        public function updateWorldLevelDetail(param1:ResWorldLevelInfoMessage) : void
        {
            this.lastUpdateTime.time = param1.lastRefTime * 1000;
            this.records = param1.arr;
            this.records = this.records.sort(compareRecordByRanking);
            dispatchEvent(new WorldLevelEvent(WorldLevelEvent.WORLD_LEVEL_DETAIL_CHANGE));
            return;
        }// end function

        public static function getInstance() : WorldLevelData
        {
            var _loc_1:* = new WorldLevelData;
            instance = new WorldLevelData;
            return instance || _loc_1;
        }// end function

        private static function compareRecordByRanking(param1:WorldLevelRecord, param2:WorldLevelRecord) : Number
        {
            return param1.ranking - param2.ranking;
        }// end function

    }
}
