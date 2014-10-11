package com.game.remark.tips
{
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.remark.model.*;
    import com.util.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class RemarkRoleTip extends BaseTips
    {
        private var _backImg:Sprite;
        private var _content:Sprite;
        private var _points:Array;
        private var _box:HBox;
        private var _containerArr:Array;
        private var _lines:Array;
        private var _gap:int = 8;
        private var REMARK_ACTIVATE:String;
        private var REMARK_INACTIVATE:String;
        private var REMARK_TOTAL:String;
        private var INTENSIFY_ACTIVATE:String;
        private var INTENSIFY_INACTIVATE:String;
        private var INTENSIFY_TOTAL:String;
        private var _attributeOffSet:int = 25;
        private var satisfyInfo:RemarkRoleInfo;

        public function RemarkRoleTip()
        {
            this.REMARK_ACTIVATE = LanguageCfgObj.getInstance().getByIndex("11115");
            this.REMARK_INACTIVATE = LanguageCfgObj.getInstance().getByIndex("11116");
            this.REMARK_TOTAL = LanguageCfgObj.getInstance().getByIndex("11117");
            this.INTENSIFY_ACTIVATE = LanguageCfgObj.getInstance().getByIndex("11757");
            this.INTENSIFY_INACTIVATE = LanguageCfgObj.getInstance().getByIndex("11758");
            this.INTENSIFY_TOTAL = LanguageCfgObj.getInstance().getByIndex("11759");
            this._backImg = ToolKit.getNew("generalHoverWndBg");
            addChild(this._backImg);
            this._content = new Sprite();
            this._content.x = 16;
            this._content.y = 12;
            addChild(this._content);
            this._box = new HBox();
            this._box.x = this._attributeOffSet;
            this._box.intervalY = 2 * this._gap;
            this._content.addChild(this._box);
            this._points = [];
            this._containerArr = [];
            this._lines = [];
            return;
        }// end function

        protected function repaintInfo(param1:RemarkRoleInfo) : Sprite
        {
            var _loc_4:* = null;
            var _loc_2:* = new Sprite();
            var _loc_3:* = new TextField();
            _loc_4 = _loc_3.defaultTextFormat;
            _loc_4.leading = 1;
            _loc_4.font = "SimSun";
            _loc_4.align = "left";
            _loc_4.size = 12;
            _loc_4.leading = 2;
            _loc_3.filters = [FrameworkGlobal.BLACK_FILTER];
            _loc_3.autoSize = "left";
            _loc_3.filters = [FrameworkGlobal.BLACK_FILTER];
            _loc_3.defaultTextFormat = _loc_4;
            _loc_3.selectable = false;
            _loc_3.x = -this._attributeOffSet;
            _loc_2.addChild(_loc_3);
            if (param1.isSatisfy)
            {
                _loc_3.textColor = 2031360;
            }
            var _loc_5:* = new TextField();
            _loc_4 = _loc_3.defaultTextFormat;
            _loc_4.leading = 1;
            _loc_4.font = "SimSun";
            _loc_4.align = "left";
            _loc_4.leading = 6;
            _loc_5.filters = [FrameworkGlobal.BLACK_FILTER];
            _loc_5.autoSize = TextFieldAutoSize.NONE;
            _loc_5.multiline = true;
            _loc_5.wordWrap = true;
            _loc_5.filters = [FrameworkGlobal.BLACK_FILTER];
            _loc_5.width = 215;
            _loc_5.defaultTextFormat = _loc_4;
            _loc_5.selectable = false;
            _loc_2.addChild(_loc_5);
            var _loc_6:* = "";
            var _loc_7:* = 0;
            while (_loc_7 < param1.attributeArr.length)
            {
                
                _loc_6 = _loc_6 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12177"), [param1.attributeArr[_loc_7].key, param1.attributeArr[_loc_7].value]) + "<br>");
                _loc_7++;
            }
            _loc_5.htmlText = _loc_6;
            if (param1.isSatisfy)
            {
                _loc_3.textColor = 2031360;
                if (param1.type == RemarkModel.REMARK)
                {
                    _loc_3.htmlText = this.REMARK_ACTIVATE.replace("{1}", param1.param);
                }
                else if (param1.type == RemarkModel.INTENSIFY)
                {
                    _loc_3.htmlText = this.INTENSIFY_ACTIVATE.replace("{1}", param1.param);
                }
                _loc_5.textColor = 33243;
            }
            else
            {
                _loc_3.textColor = PropUtil.GRAY;
                if (param1.type == RemarkModel.REMARK)
                {
                    _loc_3.htmlText = this.REMARK_INACTIVATE.replace("{1}", param1.param);
                }
                else if (param1.type == RemarkModel.INTENSIFY)
                {
                    _loc_3.htmlText = this.INTENSIFY_INACTIVATE.replace("{1}", param1.param);
                }
                _loc_5.textColor = 6184542;
            }
            _loc_5.y = _loc_3.y + _loc_3.height + 1;
            _loc_5.height = _loc_5.textHeight + 4;
            this._box.add(_loc_2);
            this.addGapPoint(this._box.y + _loc_2.y + _loc_5.y, param1.attributeArr.length);
            this._containerArr.push(_loc_2);
            return _loc_2;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this.satisfyInfo = null;
            if (param1.hasOwnProperty("type") && param1.hasOwnProperty("param"))
            {
                _loc_2 = RemarkRoleCfgObj.getInstance().getSatisfyInfo(param1.type, param1.param);
                _loc_3 = null;
                if (_loc_2 != -1)
                {
                    this.satisfyInfo = new RemarkRoleInfo();
                    this.satisfyInfo.setInfo(_loc_2, param1.type);
                    this.satisfyInfo.isSatisfy = true;
                    _loc_3 = this.repaintInfo(this.satisfyInfo);
                    this.addGapLine(this._box.y + _loc_3.y + _loc_3.height);
                }
                _loc_4 = RemarkRoleCfgObj.getInstance().getLevelUp((_loc_2 + 1), param1.type);
                _loc_5 = RemarkRoleCfgObj.getInstance().getLevelUp(_loc_2 + 2, param1.type);
                if (int(_loc_4) != -1)
                {
                    _loc_9 = new RemarkRoleInfo();
                    _loc_9.setInfo(_loc_4, param1.type);
                    _loc_3 = this.repaintInfo(_loc_9);
                    if (_loc_5 != -1)
                    {
                        this.addGapLine(this._box.y + _loc_3.y + _loc_3.height);
                    }
                }
                if (int(_loc_5) != -1)
                {
                    _loc_10 = new RemarkRoleInfo();
                    _loc_10.setInfo(_loc_5, param1.type);
                    _loc_3 = this.repaintInfo(_loc_10);
                }
                _loc_6 = ToolKit.getNewDO("excisionLine1") as Bitmap;
                _loc_6.x = 10;
                _loc_6.y = this._box.y + this._box.height + 8;
                this._content.addChild(_loc_6);
                this._lines.push(_loc_6);
                _loc_7 = new TextField();
                _loc_8 = _loc_7.defaultTextFormat;
                _loc_8.leading = 1;
                _loc_8.font = "SimSun";
                _loc_8.align = "left";
                _loc_8.size = 12;
                _loc_8.leading = 2;
                _loc_7.filters = [FrameworkGlobal.BLACK_FILTER];
                _loc_7.autoSize = "left";
                _loc_7.filters = [FrameworkGlobal.BLACK_FILTER];
                _loc_7.defaultTextFormat = _loc_8;
                _loc_7.selectable = false;
                _loc_7.textColor = 16748800;
                _loc_7.y = this._box.y + this._box.height + 23;
                if (param1.type == RemarkModel.REMARK)
                {
                    _loc_7.text = this.REMARK_TOTAL.replace("{1}", param1.param);
                }
                else if (param1.type == RemarkModel.INTENSIFY)
                {
                    _loc_7.text = this.INTENSIFY_TOTAL.replace("{1}", param1.param);
                }
                this._content.addChild(_loc_7);
                this._backImg.width = 32 + this._content.width;
                this._backImg.height = 24 + this._content.height;
                addEventListener(Event.REMOVED_FROM_STAGE, this.removeFromStage);
            }
            return;
        }// end function

        public function removeFromStage(event:Event) : void
        {
            remove();
            return;
        }// end function

        protected function addGapPoint(param1:int, param2:int = 1) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < param2)
            {
                
                _loc_4 = ToolKit.getNew("generalTextPoint") as Sprite;
                _loc_4.x = 8;
                _loc_4.y = (param1 + 1) + _loc_3 * 15;
                this._content.addChild(_loc_4);
                this._points.push(_loc_4);
                _loc_3++;
            }
            return;
        }// end function

        protected function addGapLine(param1:int) : void
        {
            var _loc_2:* = ToolKit.getNewDO("excisionLine") as Bitmap;
            _loc_2.x = 10;
            _loc_2.y = param1 + this._gap;
            this._content.addChild(_loc_2);
            this._lines.push(_loc_2);
            return;
        }// end function

    }
}
