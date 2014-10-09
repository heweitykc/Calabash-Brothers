package com.game.clickstream
{

    public class ClickStreamCfg extends Object
    {
        public var q_id:int;
        public var q_min_player_level:int;
        public var q_max_player_level:int;
        public var q_trigger_type:int;
        public var q_task_id:int;
        public var q_item_ids:Array;
        public var q_guide_team_id:int;
        public var q_zone_type:int;

        public function ClickStreamCfg(param1:Object)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            for (_loc_2 in param1)
            {
                
                if (this.hasOwnProperty(_loc_2))
                {
                    this[_loc_2] = _loc_7[_loc_2];
                }
            }
            _loc_3 = _loc_7.q_item_id;
            if (_loc_3 != null && _loc_3.length > 0)
            {
                _loc_4 = _loc_3.split(";");
                this.q_item_ids = new Array();
                for each (_loc_5 in _loc_4)
                {
                    
                    this.q_item_ids.push(int(_loc_5));
                }
            }
            return;
        }// end function

    }
}
