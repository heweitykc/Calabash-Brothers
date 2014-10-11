package com.game.newactivity.moonFestival.view.tips
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.newactivity.moonFestival.model.*;
    import com.model.*;
    import com.view.tipcell.*;
    import flash.display.*;

    public class DiceLevelTips extends BaseTips
    {
        private var _content:MovieClip;
        private var _vecLevIcon:Vector.<RoleLevelIcon>;

        public function DiceLevelTips()
        {
            this._content = ToolKit.getNew("dicelevel_tip") as MovieClip;
            addChild(this._content);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = MoonDiceModel.getInstance().records;
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (_loc_2[_loc_4].name == UserObj.getInstance().playerInfo.name)
                {
                    this._content["playerName" + _loc_4].textColor = 65310;
                }
                else
                {
                    this._content["playerName" + _loc_4].textColor = 16766079;
                }
                this._content["playerName" + _loc_4].text = _loc_2[_loc_4].name;
                this._content["rank" + _loc_4].text = ((_loc_4 + 1)).toString();
                this._content["lv" + _loc_4].text = _loc_2[_loc_4].fraction.toString();
                _loc_4++;
            }
            while (_loc_4 < 20)
            {
                
                this._content["playerName" + _loc_4].htmlText = "";
                this._content["rank" + _loc_4].text = "";
                this._content["lv" + _loc_4].text = "";
                _loc_4++;
            }
            if (MoonDiceModel.getInstance().rankScroe > 0)
            {
                this._content["txt_rank"].text = LanguageCfgObj.getInstance().getByIndex("10004", MoonDiceModel.LANG_VER) + MoonDiceModel.getInstance().rankScroe;
            }
            else
            {
                this._content["txt_rank"].text = LanguageCfgObj.getInstance().getByIndex("10004", MoonDiceModel.LANG_VER) + LanguageCfgObj.getInstance().getByIndex("10010", MoonDiceModel.LANG_VER);
            }
            return;
        }// end function

    }
}
