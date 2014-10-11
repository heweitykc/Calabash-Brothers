package com.cfg.info
{
    import com.f1.*;
    import com.f1.utils.*;

    public class SuitCfg extends Object
    {
        public var q_id:int;
        public var q_firstname:String;
        public var q_lastname:String;
        public var q_attribute:Array;
        public var q_score:int;
        public var q_split_coin:int;
        public var total_count:int;

        public function SuitCfg()
        {
            return;
        }// end function

        public function get q_name() : String
        {
            return this.q_firstname + this.q_lastname;
        }// end function

        public function parse(param1:Object) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this.q_id = param1.q_id;
            this.q_firstname = param1.q_firstname;
            this.q_lastname = param1.q_lastname;
            this.q_score = param1.q_score;
            this.q_split_coin = param1.q_split_coin;
            var _loc_2:* = StringUtil.clearJsonQuote(param1.q_attribute_reveal);
            var _loc_3:* = JSON.parse(_loc_2);
            this.q_attribute = [];
            for (_loc_4 in _loc_3)
            {
                
                _loc_5 = int(_loc_4);
                if (this.total_count < _loc_5)
                {
                    this.total_count = _loc_5;
                }
                _loc_6 = _loc_3[_loc_4];
                _loc_7 = StringUtil.decodeAttribute(_loc_6);
                this.q_attribute.push([_loc_4, _loc_7]);
            }
            return;
        }// end function

        public function attributeDesc(param1:int) : String
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_2:* = "";
            var _loc_3:* = LanguageCfgObj.getInstance().getByIndex("10038");
            var _loc_4:* = this.q_attribute ? (this.q_attribute.length) : (0);
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = this.q_attribute[_loc_5];
                _loc_7 = _loc_6[0];
                _loc_8 = _loc_6[1];
                _loc_9 = _loc_8 ? (_loc_8.length) : (0);
                _loc_10 = 0;
                while (_loc_10 < _loc_9)
                {
                    
                    _loc_11 = "";
                    _loc_12 = _loc_8[_loc_10];
                    _loc_11 = _loc_11 + (_loc_12[0] + "+" + _loc_12[1]);
                    _loc_13 = _loc_7 <= param1 ? ("ffff00") : ("737372");
                    _loc_2 = _loc_2 + StringUtil.formatString(_loc_3, _loc_13, _loc_7, _loc_11);
                    _loc_10++;
                }
                _loc_5++;
            }
            return _loc_2;
        }// end function

    }
}
