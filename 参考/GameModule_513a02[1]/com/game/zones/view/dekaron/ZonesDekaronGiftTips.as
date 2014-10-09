package com.game.zones.view.dekaron
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.zones.model.*;
    import com.model.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class ZonesDekaronGiftTips extends BaseTips
    {
        private var _content:MovieClip;
        private var _txtOpenGift:TextField;
        private var _txtMaxGift:TextField;
        private var _tipsBack:Sprite;
        private var _txtOpenZonesName:TextField;
        private var _txtOpenState:TextField;
        private var _txtMaxZonesName:TextField;
        private var _txtMaxState:TextField;

        public function ZonesDekaronGiftTips()
        {
            this._content = ToolKit.getNew("zones_get_gift_tips") as MovieClip;
            this.addChild(this._content);
            this._tipsBack = Sprite(this._content.getChildByName("tip_back"));
            this._txtOpenZonesName = TextField(this._content.getChildByName("txt_open_zones_name"));
            this._txtOpenGift = TextField(this._content.getChildByName("txt_open_gift"));
            this._txtOpenState = TextField(this._content.getChildByName("txt_open_state"));
            this._txtMaxZonesName = TextField(this._content.getChildByName("txt_max_zones_name"));
            this._txtMaxGift = TextField(this._content.getChildByName("txt_max_gift"));
            this._txtMaxState = TextField(this._content.getChildByName("txt_max_state"));
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = ZonesModel.getInstance().dekaronInfo.stage;
            var _loc_3:* = UserObj.getInstance().playerInfo.spirit;
            param1 = ZonesCloneCfg.getInstance().getDekaronAwardInfo(_loc_2);
            this._txtOpenZonesName.text = param1.q_name;
            this._txtOpenGift.text = this.getAwardString(param1.q_award);
            this._txtOpenState.text = LanguageCfgObj.getInstance().getByIndex("11516");
            this._txtOpenState.textColor = 2031360;
            var _loc_4:* = ZonesCloneCfg.getInstance().getDekaronAwardInfo((_loc_2 + 1));
            _loc_4 = ZonesCloneCfg.getInstance().getDekaronAwardInfo((_loc_2 + 1)) == null ? (param1) : (_loc_4);
            this._txtMaxZonesName.text = _loc_4.q_name;
            this._txtMaxGift.text = this.getAwardString(_loc_4.q_award);
            this._txtMaxState.text = LanguageCfgObj.getInstance().getByIndex("11517");
            this._txtMaxState.textColor = 13763588;
            return;
        }// end function

        private function getAwardString(param1:String) : String
        {
            var _loc_5:* = null;
            var _loc_2:* = param1.split(";");
            var _loc_3:* = "";
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_5 = String(_loc_2[_loc_4]).split("_");
                switch(_loc_5[0])
                {
                    case "-6":
                    {
                        _loc_3 = _loc_3 + (LanguageCfgObj.getInstance().getByIndex("12347") + ToolKit.getMoneyString(int(_loc_5[1])));
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

    }
}
