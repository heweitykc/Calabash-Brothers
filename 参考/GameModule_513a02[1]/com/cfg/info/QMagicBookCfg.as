package com.cfg.info
{
    import com.cfg.vo.*;
    import com.game.magicbook.bean.*;
    import com.staticdata.*;
    import flash.utils.*;

    public class QMagicBookCfg extends QMagicbookLevel
    {
        public var prop:Dictionary;
        public var gameModelUrl:String;
        public var panelModelUrl:String;
        public var useItemId:Array;
        public var strengthTools:Array;

        public function QMagicBookCfg()
        {
            return;
        }// end function

        override public function parse(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_6:* = null;
            super.parse(param1);
            this.useItemId = new Array();
            _loc_2 = up_itemids.split("|");
            _loc_3 = _loc_2.length;
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                this.useItemId.push(int(_loc_2[_loc_4]));
                _loc_4++;
            }
            var _loc_5:* = attributes_str.split("|");
            _loc_3 = _loc_5.length;
            this.prop = new Dictionary();
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2 = _loc_5[_loc_4].split("_");
                this.prop[_loc_2[0]] = _loc_2[1];
                _loc_4++;
            }
            this.gameModelUrl = Params.MAGICBOOK_PATH + q_resmodel;
            this.panelModelUrl = Params.MAGICBOOK_PATH + q_respanel + "/act01.png";
            _loc_5 = max_use_item_quantity_str.split("|");
            _loc_3 = _loc_5.length;
            this.strengthTools = new Array();
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_6 = new MagicUseOnceInfo();
                _loc_2 = (_loc_5[_loc_4] as String).split("_");
                _loc_6.itemId = _loc_2[0];
                _loc_6.maxUseNum = _loc_2[1];
                this.strengthTools.push(_loc_6);
                _loc_4++;
            }
            return;
        }// end function

        public function compareStar(param1:int) : int
        {
            var _loc_2:* = this.getStar();
            if (_loc_2 == param1)
            {
                return 0;
            }
            if (_loc_2 < param1)
            {
                return -1;
            }
            return 1;
        }// end function

        public function getStar() : int
        {
            return (Math.floor((level - 1) / 20) + 1);
        }// end function

        public function getMagicLevel() : int
        {
            return (level - 1) % 20 + 1;
        }// end function

    }
}
