package com.view.tipcell
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.text.*;

    public class WorldMapTips extends BaseTips
    {
        private var _content:MovieClip;
        private var _mapName:TextField;
        private var _enterLvContent:TextField;
        private var _introLvContent:TextField;
        private const LEFT_SPACE:int = 15;
        private const TOP_SPACE:int = 20;
        private const ONE_LINE_ICON_NUM:int = 3;
        private const ICON_SPACE:uint = 2;
        private const MAX_DROP_ICON:uint = 9;

        public function WorldMapTips()
        {
            this._content = ToolKit.getNew("worldMapTip") as MovieClip;
            this._mapName = this._content["mapName"] as TextField;
            this._enterLvContent = this._content["lv"] as TextField;
            this._introLvContent = this._content["intro_lv"] as TextField;
            addChild(this._content);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_13:* = null;
            var _loc_16:* = 0;
            var _loc_2:* = param1 as WorldMapInfo;
            this._mapName.text = _loc_2.mapName;
            var _loc_4:* = _loc_2.mapLimitMinLv > Params.ROLE_MAX_LEVEL ? (LanguageCfgObj.getInstance().getByIndex("12455") + (_loc_2.mapLimitMinLv - Params.ROLE_MAX_LEVEL)) : (_loc_2.mapLimitMinLv.toString());
            var _loc_5:* = _loc_2.recMinLv > Params.ROLE_MAX_LEVEL ? (LanguageCfgObj.getInstance().getByIndex("12455") + (_loc_2.recMinLv - Params.ROLE_MAX_LEVEL)) : (_loc_2.recMinLv.toString());
            var _loc_6:* = _loc_2.recMaxLv > Params.ROLE_MAX_LEVEL ? (LanguageCfgObj.getInstance().getByIndex("12455") + (_loc_2.recMaxLv - Params.ROLE_MAX_LEVEL)) : (_loc_2.recMaxLv.toString());
            if (UserObj.getInstance().playerInfo.level >= _loc_2.mapLimitMinLv)
            {
                this._enterLvContent.htmlText = "<font color=\'" + Params.GREEN_COLOR_STR + "\'>" + _loc_4 + "</font>";
            }
            else
            {
                this._enterLvContent.htmlText = "<font color=\'" + Params.RED_COLOR_STR + "\'>" + _loc_4 + "</font>";
            }
            this._introLvContent.htmlText = "<font color=\'" + Params.GREEN_COLOR_STR + "\'>" + _loc_5 + "-" + _loc_6 + "</font>";
            var _loc_7:* = 0;
            var _loc_8:* = _loc_2.mapDrop.length;
            _loc_8 = _loc_2.mapDrop.length >= this.MAX_DROP_ICON ? (this.MAX_DROP_ICON) : (_loc_8);
            var _loc_12:* = new Vector.<IconItem>;
            while (_loc_7 < _loc_8)
            {
                
                _loc_13 = ItemCfgObj.getInstance().getCfgBy(_loc_2.mapDrop[_loc_7].itemModelId);
                if (PropUtil.isEquip(_loc_13.q_type))
                {
                    _loc_11 = new EquipmentInfo();
                    _loc_11.conByWorldMapDropInfo(_loc_2.mapDrop[_loc_7]);
                    _loc_9 = new IconItem("commonRewardBox40Img");
                    _loc_9.image.move(8, 8);
                    _loc_9.needTips = false;
                    _loc_9.setInfo(_loc_11);
                }
                else
                {
                    _loc_10 = new PropInfo();
                    _loc_10.conByWorldMapDropInfo(_loc_2.mapDrop[_loc_7]);
                    _loc_9 = new IconItem("commonRewardBox40Img");
                    _loc_9.image.move(8, 8);
                    _loc_9.needTips = false;
                    _loc_9.setInfo(_loc_10);
                }
                addChild(_loc_9);
                _loc_12.push(_loc_9);
                _loc_7++;
            }
            while (_loc_7 < this.MAX_DROP_ICON)
            {
                
                _loc_9 = new IconItem("commonRewardBox40Img");
                addChild(_loc_9);
                _loc_12.push(_loc_9);
                _loc_7++;
            }
            var _loc_14:* = this.LEFT_SPACE;
            var _loc_15:* = 142;
            _loc_7 = 0;
            while (_loc_7 < this.MAX_DROP_ICON)
            {
                
                if (_loc_16 >= this.ONE_LINE_ICON_NUM)
                {
                    _loc_16 = 0;
                    _loc_14 = this.LEFT_SPACE;
                    _loc_15 = _loc_15 + (56 + 2);
                }
                _loc_12[_loc_7].x = _loc_14;
                _loc_12[_loc_7].y = _loc_15;
                _loc_14 = _loc_14 + (56 + 2);
                _loc_7++;
                _loc_16++;
            }
            return;
        }// end function

    }
}
