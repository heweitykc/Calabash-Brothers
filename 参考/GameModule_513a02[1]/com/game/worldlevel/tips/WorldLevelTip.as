package com.game.worldlevel.tips
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.role.view.*;
    import com.game.worldlevel.model.*;
    import com.view.tipcell.*;
    import flash.display.*;

    public class WorldLevelTip extends BaseTips
    {
        private var _content:MovieClip;
        private var _vecLevIcon:Vector.<RoleLevelIcon>;

        public function WorldLevelTip()
        {
            this._content = ToolKit.getNew("worldlevel_tip") as MovieClip;
            addChild(this._content);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_5:* = 0;
            var _loc_2:* = WorldLevelData.getInstance().records;
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 420;
            if (420 <= 400)
            {
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    this._content["playerName" + _loc_5].htmlText = _loc_2[_loc_5].name;
                    this._content["rank" + _loc_5].text = _loc_2[_loc_5].ranking.toString();
                    this._content["lv" + _loc_5].text = _loc_2[_loc_5].level.toString();
                    _loc_5++;
                }
                while (_loc_5 < 30)
                {
                    
                    this._content["playerName" + _loc_5].htmlText = "";
                    this._content["rank" + _loc_5].text = "";
                    this._content["lv" + _loc_5].text = "";
                    _loc_5++;
                }
            }
            else
            {
                if (!this._vecLevIcon)
                {
                    this._vecLevIcon = new Vector.<RoleLevelIcon>(30);
                }
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    if (!this._vecLevIcon[_loc_5])
                    {
                        this._vecLevIcon[_loc_5] = new RoleLevelIcon();
                        this._vecLevIcon[_loc_5].x = this._content["lv" + _loc_5].x - 20;
                        this._vecLevIcon[_loc_5].y = this._content["lv" + _loc_5].y;
                        this._content.addChild(this._vecLevIcon[_loc_5]);
                    }
                    this._content["playerName" + _loc_5].htmlText = _loc_2[_loc_5].name;
                    this._content["rank" + _loc_5].text = _loc_2[_loc_5].ranking.toString();
                    this._vecLevIcon[_loc_5].level = _loc_2[_loc_5].level;
                    this._vecLevIcon[_loc_5].textColor = this._content["lv" + _loc_5].textColor;
                    this._content["lv" + _loc_5].text = "";
                    _loc_5++;
                }
                while (_loc_5 < 30)
                {
                    
                    this._content["playerName" + _loc_5].htmlText = "";
                    this._content["rank" + _loc_5].text = "";
                    this._content["lv" + _loc_5].text = "";
                    _loc_5++;
                }
            }
            this._content["txt_time"].text = LanguageCfgObj.getInstance().getByIndex("12311") + ToolKit.formatDateToString(WorldLevelData.getInstance().lastUpdateTime);
            return;
        }// end function

    }
}
