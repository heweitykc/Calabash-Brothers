package com.cfg.vo
{

    public class QMonsterBossQcfg extends Object
    {
        public var q_id:int;
        public var q_page:int;
        public var q_lv_limit:int;
        public var q_drop_neutrality:String;
        public var q_map:int;
        public var q_monsterid:int;
        public var q_monster_map:int;
        public var q_monster_drop:String;
        public var q_map_x:int;
        public var q_map_y:int;

        public function QMonsterBossQcfg()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_id = param1.q_id;
            this.q_page = param1.q_page;
            this.q_lv_limit = param1.q_lv_limit;
            this.q_drop_neutrality = param1.q_drop_neutrality;
            this.q_map = param1.q_map;
            this.q_monsterid = param1.q_monsterid;
            this.q_monster_map = param1.q_monster_map;
            this.q_monster_drop = param1.q_monster_drop;
            this.q_map_x = param1.q_map_x;
            this.q_map_y = param1.q_map_y;
            return;
        }// end function

    }
}
