package com.game.zones.view.belialworld
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class ZonesBelialWorldEvaluateTips extends BaseTips
    {
        private var _content:MovieClip;
        private var _txtState:TextField;
        private var _txtGiftExp:TextField;
        private var _txtGiftMoney:TextField;
        private var _mcLevel:MovieClip;
        private var _txtExpSign:TextField;

        public function ZonesBelialWorldEvaluateTips()
        {
            this.initComp();
            return;
        }// end function

        private function initComp() : void
        {
            this._content = ToolKit.getNew("evaluate_tips");
            this.addChild(this._content);
            this._mcLevel = MovieClip(this._content.getChildByName("mc_level"));
            this._txtState = TextField(this._content.getChildByName("txt_state"));
            this._txtExpSign = TextField(this._content.getChildByName("txt_exp_sign"));
            this._txtGiftExp = TextField(this._content.getChildByName("txt_gift_exp"));
            this._txtGiftMoney = TextField(this._content.getChildByName("txt_gift_money"));
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_2:* = param1.zoneID;
            var _loc_3:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_2);
            this._mcLevel.gotoAndStop((param1.level + 1));
            if (_loc_3)
            {
                _loc_5 = _loc_3.appraise_reward;
                _loc_4 = _loc_5.split("#");
                if (_loc_4.length > 0)
                {
                    _loc_6 = this.getValueForId(-4, _loc_4[param1.level]);
                    if (_loc_6 > 0)
                    {
                        this._txtGiftExp.text = _loc_6.toString();
                        this._txtExpSign.visible = true;
                    }
                    else
                    {
                        this._txtExpSign.visible = false;
                        this._txtGiftExp.text = "";
                    }
                    this._txtGiftMoney.text = this.getValueForId(-1, _loc_4[param1.level]).toString();
                }
                this._txtState.htmlText = param1.state == true ? ("<font color = \'#00ff00\'>" + LanguageCfgObj.getInstance().getByIndex("11516") + "</font>") : ("<font color = \'#ff0000\'>" + LanguageCfgObj.getInstance().getByIndex("11517") + "</font>");
            }
            return;
        }// end function

        private function getValueForId(param1:int, param2:String) : int
        {
            var _loc_5:* = null;
            if (!param2)
            {
                return 0;
            }
            var _loc_3:* = param2.split(";");
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = String(_loc_3[_loc_4]).split("_");
                if (int(_loc_5[0]) == param1)
                {
                    return int(_loc_5[1]);
                }
                _loc_4++;
            }
            return 0;
        }// end function

    }
}
