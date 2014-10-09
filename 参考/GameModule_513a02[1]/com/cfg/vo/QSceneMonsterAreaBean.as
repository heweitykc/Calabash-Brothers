package com.cfg.vo
{

    public class QSceneMonsterAreaBean extends Object
    {
        public var q_id:int;
        public var q_mapid:int;
        public var q_monster_model:uint;
        public var q_monster_num:uint;
        public var q_center_x:int;
        public var q_center_y:int;
        public var q_relive:uint;

        public function QSceneMonsterAreaBean()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_id = param1.q_id;
            this.q_mapid = param1.q_mapid;
            this.q_monster_model = param1.q_monster_model;
            this.q_monster_num = param1.q_monster_num;
            this.q_center_x = param1.q_center_x;
            this.q_center_y = param1.q_center_y;
            this.q_relive = param1.q_relive;
            return;
        }// end function

    }
}
