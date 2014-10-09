package com.cfg.info
{

    public class HorseTableVo extends Object
    {
        public var horse_level:int;
        public var horse_step:int;
        public var horse_step_level:int;
        public var horse_id:String;
        public var horse_exp:int;
        public var horse_max_phyatk:int;
        public var horse_min_phyatk:int;
        public var horse_max_magicatk:int;
        public var horse_min_magicatk:int;
        public var horse_defense:int;
        public var horse_hp:int;
        public var horse_mp:int;
        public var horse_speed:int;
        public var horse_ignoredefense:int;
        public var horse_perfectatk_percent:int;
        public var horse_skill_id1:int;
        public var horse_skill_id2:int;
        public var horse_skill_id3:int;
        public var horse_item_id:int;
        public var horse_item_num:int;
        public var horse_item_exp:int;
        public var horse_item_gold:int;
        public var q_horse_stand:String;
        public var q_horse_move:String;
        public var q_horse_wing:int;

        public function HorseTableVo()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.horse_level = param1.horse_level;
            this.horse_id = param1.horse_id;
            this.horse_exp = param1.horse_exp;
            this.horse_max_phyatk = param1.horse_max_phyatk;
            this.horse_min_phyatk = param1.horse_min_phyatk;
            this.horse_max_magicatk = param1.horse_max_magicatk;
            this.horse_min_magicatk = param1.horse_min_magicatk;
            this.horse_defense = param1.horse_defense;
            this.horse_hp = param1.horse_hp;
            this.horse_mp = param1.horse_mp;
            this.horse_speed = param1.horse_speed;
            this.horse_ignoredefense = param1.horse_ignoredefense;
            this.horse_perfectatk_percent = param1.horse_perfectatk_percent;
            this.horse_skill_id1 = param1.horse_skill_id1;
            this.horse_skill_id2 = param1.horse_skill_id2;
            this.horse_skill_id3 = param1.horse_skill_id3;
            this.horse_item_id = param1.horse_item_id;
            this.horse_item_num = param1.horse_item_num;
            this.horse_item_exp = param1.horse_item_exp;
            this.horse_step = param1.horse_step;
            this.horse_step_level = param1.horse_step_level;
            this.q_horse_stand = param1.q_horse_stand;
            this.q_horse_move = param1.q_horse_move;
            this.q_horse_wing = param1.q_horse_wing;
            return;
        }// end function

    }
}
