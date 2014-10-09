package com.game.onlineactivity.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.newactivity.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.text.*;

    public class OnlineDecItem extends BaseButton implements IItem
    {
        private var bg_award:MovieClip;
        private var _content:Sprite;

        public function OnlineDecItem()
        {
            this._content = new Sprite();
            this._content.y = 0;
            addChild(this._content);
            return;
        }// end function

        override public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            super.obj = param1;
            this.setInfo(obj.type);
            return;
        }// end function

        public function setInfo(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_2:* = NewActivityModel.getInstance().getActivityByActivityId(OnlineActivityBox.activityId[(param1 - 1)]).condDesc;
            if (_loc_2)
            {
                _loc_3 = /\"/g;
                _loc_4 = _loc_2.replace(_loc_3, "");
                _loc_4 = _loc_4.substring(1, (_loc_4.length - 1));
                _loc_5 = _loc_4.split(";");
                _loc_6 = 0;
                while (_loc_6 < _loc_5.length)
                {
                    
                    _loc_7 = _loc_5[_loc_6].split(":");
                    if (_loc_7[0].indexOf(LanguageCfgObj.getInstance().getByIndex("10973")) != -1)
                    {
                        _loc_8 = new TextField();
                        _loc_8.selectable = false;
                        _loc_8.textColor = 16748800;
                        _loc_8.htmlText = "" + _loc_7[0];
                        _loc_8.width = _loc_8.textWidth + 5;
                        _loc_8.height = _loc_8.textHeight + 5;
                        _loc_8.x = 10;
                        _loc_8.y = this._content.height + 40;
                        _loc_8.filters = [FrameworkGlobal.BLACK_FILTER];
                        this._content.addChild(_loc_8);
                        _loc_9 = _loc_7[1];
                        _loc_10 = _loc_9.indexOf("[");
                        _loc_11 = _loc_9.indexOf("]");
                        _loc_12 = _loc_9.substring((_loc_10 + 1), _loc_11);
                        _loc_13 = _loc_9.substring(0, _loc_10).split("_");
                        _loc_14 = 0;
                        while (_loc_14 < _loc_13.length)
                        {
                            
                            _loc_15 = PropUtil.createItemByCfg(_loc_13[_loc_14]);
                            _loc_16 = new IconItem("");
                            _loc_16.setWH(40, 40);
                            _loc_16.setImageSize(40, 40);
                            _loc_16.setInfo(_loc_15);
                            _loc_16.x = _loc_8.x + 65 + _loc_14 * 50;
                            _loc_16.y = _loc_8.y - 10;
                            this.bg_award = ToolKit.getNew("commonRewardBox2_40");
                            this.bg_award.x = _loc_16.x - 3;
                            this.bg_award.y = _loc_16.y - 3;
                            this._content.addChild(this.bg_award);
                            this._content.addChild(_loc_16);
                            _loc_14++;
                        }
                        if (_loc_12)
                        {
                            _loc_17 = new TextField();
                            _loc_17.multiline = true;
                            _loc_17.wordWrap = true;
                            _loc_17.selectable = false;
                            _loc_17.textColor = 16766079;
                            _loc_17.htmlText = "" + _loc_12;
                            _loc_17.width = 470 - (this.bg_award.x + this.bg_award.width);
                            _loc_17.height = _loc_17.textHeight + 5;
                            _loc_17.x = this.bg_award.x + this.bg_award.width;
                            _loc_17.y = _loc_8.y;
                            _loc_17.filters = [FrameworkGlobal.BLACK_FILTER];
                            this._content.addChild(_loc_17);
                        }
                    }
                    else if (_loc_7[0] == "url")
                    {
                        OnlineActivityBox.jumpUrl[param1] = _loc_7[1] + ":" + _loc_7[2];
                    }
                    else
                    {
                        _loc_18 = new TextFormat(LanguageCfgObj.getInstance().getByIndex("10974"), 12, 16777215, null, null, null, null, null, null, null, null, null, 5);
                        _loc_8 = new TextField();
                        _loc_8.defaultTextFormat = _loc_18;
                        _loc_8.selectable = false;
                        _loc_8.textColor = 16748800;
                        _loc_8.htmlText = "" + _loc_7[0];
                        _loc_8.width = _loc_8.textWidth + 5;
                        _loc_8.height = _loc_8.textHeight;
                        _loc_8.x = 10;
                        _loc_8.filters = [FrameworkGlobal.BLACK_FILTER];
                        _loc_17 = new TextField();
                        _loc_17.defaultTextFormat = _loc_18;
                        _loc_17.multiline = true;
                        _loc_17.wordWrap = true;
                        _loc_17.autoSize = TextFieldAutoSize.LEFT;
                        _loc_17.selectable = false;
                        _loc_17.mouseWheelEnabled = false;
                        _loc_17.textColor = 16766079;
                        _loc_17.htmlText = "" + _loc_7[1];
                        _loc_17.width = 470 - _loc_8.width;
                        _loc_17.x = _loc_8.width;
                        _loc_17.filters = [FrameworkGlobal.BLACK_FILTER];
                        _loc_8.y = this._content.height;
                        _loc_17.y = _loc_8.y;
                        this._content.addChild(_loc_8);
                        this._content.addChild(_loc_17);
                    }
                    _loc_6++;
                }
            }
            return;
        }// end function

    }
}
