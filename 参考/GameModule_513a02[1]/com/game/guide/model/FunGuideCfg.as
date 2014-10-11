package com.game.guide.model
{

    public class FunGuideCfg extends Object
    {
        private var _type:int;
        private var _illustrate:String;
        private var _icon:String;
        private var _priority:int;
        private var _funArr:Array;

        public function FunGuideCfg()
        {
            return;
        }// end function

        public function get funArr() : Array
        {
            return this._funArr;
        }// end function

        public function set funArr(param1:Array) : void
        {
            this._funArr = param1;
            return;
        }// end function

        public function get priority() : int
        {
            return this._priority;
        }// end function

        public function set priority(param1:int) : void
        {
            this._priority = param1;
            return;
        }// end function

        public function get icon() : String
        {
            return this._icon;
        }// end function

        public function set icon(param1:String) : void
        {
            this._icon = param1;
            return;
        }// end function

        public function get illustrate() : String
        {
            return this._illustrate;
        }// end function

        public function set illustrate(param1:String) : void
        {
            this._illustrate = param1;
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

        public function prase(param1:Object) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this._type = param1.q_id;
            var _loc_2:* = param1.q_recommend;
            var _loc_3:* = param1.q_gui_explain;
            if (_loc_3.charAt(0) == "\"" && _loc_3.charAt((_loc_3.length - 1)) == "\"")
            {
                _loc_3 = _loc_3.substring(1, (_loc_3.length - 1));
            }
            this._illustrate = _loc_3;
            this._icon = param1.q_ico;
            this._funArr = [];
            if (_loc_2 && _loc_2 != "")
            {
                _loc_4 = _loc_2.split(";");
                for each (_loc_5 in _loc_4)
                {
                    
                    _loc_6 = _loc_5.split("_");
                    param1 = new Object();
                    param1.type = int(_loc_6[0]);
                    param1.priority = int(_loc_6[1]);
                    this._funArr.push(param1);
                }
                this._funArr.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
            }
            return;
        }// end function

    }
}
