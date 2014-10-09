package com.game.remark.model
{

    public class RemarkRoleInfo extends Object
    {
        public var param:String;
        public var type:int;
        public var attributeArr:Array;
        public var isSatisfy:Boolean;

        public function RemarkRoleInfo()
        {
            return;
        }// end function

        public function setInfo(param1:int, param2:int) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_3:* = RemarkRoleCfgObj.getInstance().getRemark(param1, param2);
            if (_loc_3 == null)
            {
                return;
            }
            this.attributeArr = [];
            this.param = _loc_3.q_param;
            this.type = int(_loc_3.q_type);
            var _loc_4:* = _loc_3.q_attribute;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_4.length)
            {
                
                if (_loc_4.charAt(_loc_7) == "\"" || _loc_4.charAt(_loc_7) == "[")
                {
                    ;
                }
                else
                {
                    _loc_5 = _loc_7;
                    break;
                }
                _loc_7++;
            }
            _loc_7 = _loc_4.length - 1;
            while (_loc_7 >= 0)
            {
                
                if (_loc_4.charAt(_loc_7) == "\"" || _loc_4.charAt(_loc_7) == "[")
                {
                    ;
                }
                else
                {
                    _loc_6 = _loc_7;
                    break;
                }
                _loc_7 = _loc_7 - 1;
            }
            _loc_4 = _loc_4.slice(_loc_5, _loc_6);
            var _loc_8:* = _loc_4.split(",");
            _loc_7 = 0;
            while (_loc_7 < _loc_8.length)
            {
                
                _loc_9 = new Object();
                _loc_10 = _loc_8[_loc_7].split(":");
                _loc_9.key = _loc_10[0];
                _loc_9.value = _loc_10[1];
                this.attributeArr.push(_loc_9);
                _loc_7++;
            }
            return;
        }// end function

    }
}
