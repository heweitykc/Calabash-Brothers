package com.game.clickstream
{

    public class ClickStreamCfgTriggerIdParser extends Object
    {

        public function ClickStreamCfgTriggerIdParser()
        {
            return;
        }// end function

        public static function taskId(param1:Array, param2:ClickStreamCfg) : void
        {
            param1.push(param2.q_task_id);
            return;
        }// end function

        public static function itemIds(param1:Array, param2:ClickStreamCfg) : void
        {
            var _loc_3:* = undefined;
            for each (_loc_3 in param2.q_item_ids)
            {
                
                param1.push(_loc_3);
            }
            return;
        }// end function

        public static function guideTeamId(param1:Array, param2:ClickStreamCfg) : void
        {
            param1.push(param2.q_guide_team_id);
            return;
        }// end function

        public static function zoneType(param1:Array, param2:ClickStreamCfg) : void
        {
            param1.push(param2.q_zone_type);
            return;
        }// end function

    }
}
