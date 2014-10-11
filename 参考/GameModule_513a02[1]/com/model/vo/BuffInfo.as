package com.model.vo
{
    import com.cfg.vo.*;
    import com.game.buff.bean.*;
    import com.game.utils.*;
    import com.staticdata.*;

    public class BuffInfo extends Buff
    {
        public var num:uint = 0;
        public var buffId:long;
        public var buffIds:Array;
        public var url:String;
        public var icon:String;
        public var buffPosType:uint;
        public var total:int;
        public var remain:int;
        public var value:int;
        public var overlay:int;
        public var percent:int;
        public var buffBody:uint = 2;
        public var lastRound:uint;
        public static var BUFF_FOOR:uint = 1;
        public static var BUFF_Head:uint = 2;
        public static var BUFF_CHEST:uint = 3;
        public static var BUFF_ROUND:uint = 4;

        public function BuffInfo()
        {
            this.buffIds = [];
            return;
        }// end function

        override public function parse(param1:Object) : void
        {
            super.parse(param1);
            if (q_swf)
            {
                this.url = Params.BUFF_PATH + q_swf + ".png";
            }
            if (q_ico)
            {
                this.icon = Params.BUFF_ICON_PATH + q_ico + ".png";
            }
            if (q_small_ico)
            {
                q_small_ico = Params.BUFF_PATH + q_small_ico + ".png";
            }
            return;
        }// end function

        public function conv(param1:CSBuffInfo) : void
        {
            this.buffId = param1.buffId;
            this.remain = param1.remain;
            this.total = param1.total;
            this.value = param1.value;
            this.overlay = param1.overlay;
            this.percent = param1.percent / 100;
            this.overlay = param1.overlay;
            return;
        }// end function

        public function getBuffTips() : String
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_1:* = "";
            _loc_1 = "<font color=\'#FFF000\'>" + q_buff_name + "</font>\n";
            var _loc_2:* = /\{.*?\}/gims;
            var _loc_5:* = null;
            while (true)
            {
                
                _loc_5 = _loc_2.exec(_loc_1);
                if (_loc_5 == null)
                {
                    break;
                }
                _loc_6 = _loc_5[0];
                _loc_3 = _loc_6.substr(1, _loc_6.length - 2);
                if (_loc_3 == Params.CFG_BUFF_REMAIN)
                {
                    _loc_4 = "{time}";
                }
                else if (q_overlay == 1)
                {
                    _loc_4 = (int(this[_loc_3]) * this.num).toString();
                }
                else
                {
                    _loc_4 = this[_loc_3];
                }
                _loc_1 = _loc_1.replace(_loc_6, _loc_4);
            }
            return _loc_1;
        }// end function

        public function getEffectPrompt() : String
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_1:* = "";
            _loc_1 = q_effect_prompt;
            var _loc_2:* = /\{.*?\}/gims;
            var _loc_5:* = null;
            while (true)
            {
                
                _loc_5 = _loc_2.exec(_loc_1);
                if (_loc_5 == null)
                {
                    break;
                }
                _loc_6 = _loc_5[0];
                _loc_3 = _loc_6.substr(1, _loc_6.length - 2);
                if (q_overlay == 1)
                {
                    _loc_4 = (int(this[_loc_3]) * this.num).toString();
                }
                else
                {
                    _loc_4 = this[_loc_3];
                }
                _loc_1 = _loc_1.replace(_loc_6, _loc_4);
            }
            return _loc_1;
        }// end function

    }
}
