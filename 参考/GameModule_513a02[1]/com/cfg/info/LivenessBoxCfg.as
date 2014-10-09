package com.cfg.info
{

    public class LivenessBoxCfg extends Object
    {
        private var _id:int;
        private var _name:String;
        private var _condition:int;
        public var goods:Array;

        public function LivenessBoxCfg()
        {
            this.goods = [];
            return;
        }// end function

        public function get condition() : int
        {
            return this._condition;
        }// end function

        public function set condition(param1:int) : void
        {
            this._condition = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
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

        public function prase(param1:Object) : void
        {
            var _loc_5:* = null;
            this._id = param1.q_box_id;
            this._name = param1.q_box_name;
            this._condition = param1.q_value_min;
            var _loc_2:* = param1.q_items.split("_");
            var _loc_3:* = [];
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_5 = {};
                _loc_3 = _loc_2[_loc_4].split(":");
                _loc_5.itemModelId = _loc_3[0];
                _loc_5.num = _loc_3[1];
                this.goods.push(_loc_5);
                _loc_4++;
            }
            return;
        }// end function

    }
}
