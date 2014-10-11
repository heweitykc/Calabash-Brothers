package com.cfg.info
{

    public class TitleCfg extends Object
    {
        public var q_titleid:int;
        public var q_titlename:String;
        public var q_rank:int;
        public var q_icon:String;
        public var q_effective_time:int;
        public var q_set_attribute:Array;
        public var q_effective:Number;
        public var q_get_type:int;
        public var q_get_value:String;
        public var q_get_job:int;
        public var q_show_job:Number;
        public var q_excursion_y:int;
        public var q_describe:String;

        public function TitleCfg()
        {
            return;
        }// end function

        public function get url() : String
        {
            return "art/res/title/" + this.q_icon + ".png";
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_titleid = param1.q_titleid;
            this.q_titlename = param1.q_titlename;
            this.q_rank = param1.q_rank;
            this.q_icon = param1.q_icon;
            this.q_effective_time = param1.q_effective_time > 0 ? (param1.q_effective_time * 60) : (param1.q_effective_time);
            this.q_set_attribute = [];
            var _loc_2:* = param1.q_attribute_show;
            var _loc_3:* = _loc_2.indexOf("[");
            var _loc_4:* = _loc_2.indexOf("]");
            _loc_2 = _loc_2.substring((_loc_3 + 1), _loc_4);
            var _loc_5:* = _loc_2.split(",");
            var _loc_6:* = _loc_2.split(",") ? (_loc_5.length) : (0);
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_2 = _loc_5[_loc_7];
                this.q_set_attribute[_loc_7] = _loc_2.split(":");
                _loc_7++;
            }
            this.q_effective = param1.q_effective;
            this.q_get_type = param1.q_get_type;
            this.q_get_value = param1.q_get_value;
            this.q_get_job = param1.q_get_job;
            this.q_show_job = param1.q_show_job;
            this.q_excursion_y = param1.q_excursion_y;
            this.q_describe = param1.q_describe;
            return;
        }// end function

    }
}
