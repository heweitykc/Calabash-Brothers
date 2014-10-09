package com.game.zones.view.dekaron
{
    import com.cfg.vo.*;
    import com.f1.utils.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class ZonesDekaronUFOTips extends BaseTips
    {
        private var _txtExp:TextField;
        private var _content:MovieClip;
        private var _txtMoney:TextField;
        private var _txtSpirit:TextField;
        private var _txtPower:TextField;

        public function ZonesDekaronUFOTips()
        {
            this.initTips();
            return;
        }// end function

        private function initTips() : void
        {
            this._content = MovieClip(ToolKit.getNew("zones_monster_ufo_tips"));
            this.addChild(this._content);
            this._txtExp = TextField(this._content.getChildByName("txt_exp"));
            this._txtMoney = TextField(this._content.getChildByName("txt_money"));
            this._txtSpirit = TextField(this._content.getChildByName("txt_spirit"));
            this._txtPower = TextField(this._content.getChildByName("txt_power"));
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = ZonesTableVo(param1);
            if (_loc_2)
            {
                _loc_3 = "";
                _loc_4 = _loc_2.reward.split(";");
                _loc_5 = 0;
                while (_loc_5 < _loc_4.length)
                {
                    
                    _loc_6 = _loc_4[_loc_5];
                    _loc_7 = _loc_6.split("_");
                    if (_loc_7[0] == -1)
                    {
                        this._txtMoney.text = ToolKit.getMoneyString(uint(_loc_7[1]));
                    }
                    if (_loc_7[0] == -4)
                    {
                        this._txtExp.text = ToolKit.getMoneyString(uint(_loc_7[1]));
                    }
                    if (_loc_7[0] == -6)
                    {
                        this._txtSpirit.text = ToolKit.getMoneyString(uint(_loc_7[1]));
                    }
                    _loc_5++;
                }
                this._txtPower.text = _loc_2.fighting_value.toString();
            }
            return;
        }// end function

    }
}
