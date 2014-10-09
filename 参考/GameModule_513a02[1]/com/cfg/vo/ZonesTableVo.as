package com.cfg.vo
{

    public class ZonesTableVo extends Object
    {
        private var _id:int;
        private var _type:int;
        private var _duplicate_name:String;
        private var _min_lv:int;
        private var _max_lv:int;
        private var _manual_num:int;
        private var _reward:String;
        private var _fighting_value:int;
        private var _level:int;
        private var _monster:int;
        private var _monster_skill:String = "";
        private var _first_reward:String;
        private var _need_item:String;
        private var _boss:Array;
        private var _appraise_reward:String;
        private var _condition_explain:String;
        private var _time_evaluate:String;
        public var q_exist_time:int;

        public function ZonesTableVo()
        {
            return;
        }// end function

        public function get boss() : Array
        {
            return this._boss;
        }// end function

        public function set boss(param1:Array) : void
        {
            this._boss = param1;
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            if (param1)
            {
                this._id = param1.q_id;
                this._type = param1.q_type;
                this._duplicate_name = param1.q_duplicate_name;
                this._min_lv = param1.q_min_lv;
                this._max_lv = param1.q_max_lv;
                this._manual_num = param1.q_manual_num;
                this._reward = param1.q_reward;
                this._fighting_value = param1.q_fighting_value;
                this._level = param1.q_raids_level;
                this._monster = param1.q_monster;
                this._monster_skill = param1.q_monster_skill;
                this._first_reward = param1.q_first_reward;
                this._need_item = param1.q_need_item;
                this._appraise_reward = param1.q_appraise_reward;
                this._condition_explain = param1.q_condition_explain;
                this._time_evaluate = param1.q_time_evaluate;
                this.q_exist_time = param1.q_exist_time;
                if (param1.q_map_boss)
                {
                    this._boss = param1.q_map_boss.substring(1, (param1.q_map_boss.length - 1)).split(",");
                }
            }
            return;
        }// end function

        public function get reward() : String
        {
            return this._reward;
        }// end function

        public function set reward(param1:String) : void
        {
            this._reward = param1;
            return;
        }// end function

        public function get manual_num() : int
        {
            return this._manual_num;
        }// end function

        public function set manual_num(param1:int) : void
        {
            this._manual_num = param1;
            return;
        }// end function

        public function get max_lv() : int
        {
            return this._max_lv;
        }// end function

        public function set max_lv(param1:int) : void
        {
            this._max_lv = param1;
            return;
        }// end function

        public function get min_lv() : int
        {
            return this._min_lv;
        }// end function

        public function set min_lv(param1:int) : void
        {
            this._min_lv = param1;
            return;
        }// end function

        public function get duplicate_name() : String
        {
            return this._duplicate_name;
        }// end function

        public function set duplicate_name(param1:String) : void
        {
            this._duplicate_name = param1;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function set id(param1:int) : void
        {
            this._id = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get fighting_value() : int
        {
            return this._fighting_value;
        }// end function

        public function set fighting_value(param1:int) : void
        {
            this._fighting_value = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get monster() : uint
        {
            return this._monster;
        }// end function

        public function set monster(param1:uint) : void
        {
            this._monster = param1;
            return;
        }// end function

        public function get monster_skill() : String
        {
            return this._monster_skill;
        }// end function

        public function set monster_skill(param1:String) : void
        {
            this._monster_skill = param1;
            return;
        }// end function

        public function get first_reward() : String
        {
            return this._first_reward;
        }// end function

        public function set first_reward(param1:String) : void
        {
            this._first_reward = param1;
            return;
        }// end function

        public function get need_item() : String
        {
            return this._need_item;
        }// end function

        public function set need_item(param1:String) : void
        {
            this._need_item = param1;
            return;
        }// end function

        public function get appraise_reward() : String
        {
            return this._appraise_reward;
        }// end function

        public function set appraise_reward(param1:String) : void
        {
            this._appraise_reward = param1;
            return;
        }// end function

        public function get condition_explain() : String
        {
            return this._condition_explain;
        }// end function

        public function set condition_explain(param1:String) : void
        {
            this._condition_explain = param1;
            return;
        }// end function

        public function get time_evaluate() : String
        {
            return this._time_evaluate;
        }// end function

        public function set time_evaluate(param1:String) : void
        {
            this._time_evaluate = param1;
            return;
        }// end function

    }
}
