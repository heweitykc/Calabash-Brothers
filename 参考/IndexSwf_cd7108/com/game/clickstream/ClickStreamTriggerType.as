package com.game.clickstream
{
    import flash.utils.*;

    public class ClickStreamTriggerType extends Object
    {
        public var id:int;
        public var name:String;
        private var triggerIdParser:Function;
        private var cfgMap:Dictionary;
        private static var instanceDict:Dictionary = new Dictionary();
        public static var FINISH_TASK:ClickStreamTriggerType = new ClickStreamTriggerType(1, "完成任务", ClickStreamCfgTriggerIdParser.taskId);
        public static var QUICK_USE_EQUIP:ClickStreamTriggerType = new ClickStreamTriggerType(2, "快捷穿戴装备", ClickStreamCfgTriggerIdParser.itemIds);
        public static var QUICK_USE_ITEM:ClickStreamTriggerType = new ClickStreamTriggerType(3, "快捷使用物品", ClickStreamCfgTriggerIdParser.itemIds);
        public static var OPEN_FUNCTION:ClickStreamTriggerType = new ClickStreamTriggerType(4, "功能开启", ClickStreamCfgTriggerIdParser.guideTeamId);
        public static var ENTER_ZONE:ClickStreamTriggerType = new ClickStreamTriggerType(5, "进入副本", ClickStreamCfgTriggerIdParser.zoneType);
        public static var EXIT_ZONE:ClickStreamTriggerType = new ClickStreamTriggerType(6, "离开副本", ClickStreamCfgTriggerIdParser.zoneType);
        public static var TRANSFER_GUIDE:ClickStreamTriggerType = new ClickStreamTriggerType(7, "传送指引", ClickStreamCfgTriggerIdParser.taskId);

        public function ClickStreamTriggerType(param1:int, param2:String, param3:Function)
        {
            this.cfgMap = new Dictionary();
            this.id = param1;
            this.name = param2;
            this.triggerIdParser = param3;
            instanceDict[param1] = this;
            return;
        }// end function

        public function addCfg(param1:ClickStreamCfg) : void
        {
            var _loc_3:* = undefined;
            var _loc_2:* = new Array();
            this.triggerIdParser(_loc_2, param1);
            for each (_loc_3 in _loc_2)
            {
                
                this.cfgMap[_loc_3] = param1;
            }
            return;
        }// end function

        public function getCfg(param1) : ClickStreamCfg
        {
            ClickStreamCfgObj.getInstance();
            return this.cfgMap[param1];
        }// end function

        public static function getInstance(param1:int) : ClickStreamTriggerType
        {
            return instanceDict[param1];
        }// end function

    }
}
