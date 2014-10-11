package com.game.stalls.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.stalls.control.*;
    import com.game.stalls.events.*;
    import com.game.stalls.model.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.text.*;

    public class MineBoothContainer extends Component
    {
        private var _container:HBox;
        private var _titleNameTxt:TextField;
        private var _changeNameBtn:BaseButton;
        private var _addedBtn:BaseButton;
        private var _offBtn:BaseButton;
        private var _status:String;
        public const NORMAL:String = "normal";
        public const OFF:String = "off";
        public const ADD:String = "add";
        private var _info:StallsInfo;
        private var TEMPLATE:String;
        private var _templateTxt:TextField;

        public function MineBoothContainer(param1)
        {
            this._status = this.NORMAL;
            this.TEMPLATE = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11656"), [UserObj.getInstance().playerInfo.name]);
            super(param1);
            this.initUI();
            this.addListener();
            StallsControl.getInstance().mineContainer = this;
            if (StallsObj.getInstance().selfStalls)
            {
                this.update();
            }
            else
            {
                StallsControl.getInstance().openMystallsInfo();
            }
            return;
        }// end function

        public function reset() : void
        {
            this._status = this.NORMAL;
            if (this._offBtn)
            {
                this._offBtn.setText(LanguageCfgObj.getInstance().getByIndex("10280"));
                this._addedBtn.setText(LanguageCfgObj.getInstance().getByIndex("10281"));
            }
            this.changeName();
            return;
        }// end function

        public function get info() : StallsInfo
        {
            return this._info;
        }// end function

        public function set info(param1:StallsInfo) : void
        {
            this._info = param1;
            this.update();
            return;
        }// end function

        public function update() : void
        {
            var _loc_2:* = 0;
            var _loc_6:* = null;
            this._info = StallsObj.getInstance().selfStalls;
            if (this._info == null)
            {
                return;
            }
            var _loc_1:* = this._info.stallsgoodsinfo.length;
            var _loc_3:* = false;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_1)
            {
                
                _loc_6 = this._info.stallsgoodsinfo[_loc_5];
                if (_loc_6.prop.itemModelId == -1)
                {
                    this._container.getContent(8).info = _loc_6;
                    _loc_3 = true;
                }
                else if (_loc_6.prop.itemModelId == -2)
                {
                    this._container.getContent(9).info = _loc_6;
                    _loc_4 = true;
                }
                else
                {
                    this._container.getContent(_loc_2).info = _loc_6;
                    _loc_2++;
                }
                _loc_5++;
            }
            if (!_loc_3)
            {
                this._container.getContent(8).info = null;
            }
            if (!_loc_4)
            {
                this._container.getContent(9).info = null;
            }
            StallsControl.getInstance().sellNum = _loc_2;
            _loc_5 = _loc_2;
            while (_loc_5 <= 7)
            {
                
                this._container.getContent(_loc_5).info = null;
                _loc_5++;
            }
            this.changeName();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = null;
            this._titleNameTxt = getDisplayChildByName("txt_titleName");
            this._titleNameTxt.textColor = 16766079;
            this._titleNameTxt.maxChars = 16;
            this._container = new HBox();
            this._container.oneRow = 2;
            this._container.x = getDisplayChildByName("item_0").x;
            this._container.y = getDisplayChildByName("item_0").y;
            var _loc_1:* = 0;
            while (_loc_1 < 8)
            {
                
                _loc_3 = new BoothGoodItem(getDisplayChildByName("item_" + _loc_1));
                _loc_3.isMine = true;
                this._container.add(_loc_3);
                _loc_1++;
            }
            var _loc_2:* = new BoothCurrencyItem(getDisplayChildByName("item_8"), 1);
            _loc_2.isMine = true;
            this._container.add(_loc_2);
            _loc_2 = new BoothCurrencyItem(getDisplayChildByName("item_9"), 2);
            _loc_2.isMine = true;
            this._container.add(_loc_2);
            addChild(this._container);
            this._offBtn = new BaseButton(getDisplayChildByName("btn_off"));
            this._offBtn.setText(LanguageCfgObj.getInstance().getByIndex("10280"));
            this._addedBtn = new BaseButton(getDisplayChildByName("btn_added"));
            this._addedBtn.setText(LanguageCfgObj.getInstance().getByIndex("10281"));
            this._changeNameBtn = new BaseButton(getDisplayChildByName("btn_changename"));
            this._changeNameBtn.setText(LanguageCfgObj.getInstance().getByIndex("11219"));
            return;
        }// end function

        private function addListener() : void
        {
            this._offBtn.addEvtListener(MouseEvent.CLICK, this.__offClick);
            this._addedBtn.addEvtListener(MouseEvent.CLICK, this.__addedClick);
            this._changeNameBtn.addEventListener(MouseEvent.CLICK, this.__changeTitle);
            this._titleNameTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn);
            addEvtListener(StallsEvent.SELECTEDGOOD, this.__selected, true);
            return;
        }// end function

        private function __selected(event:StallsEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._status == this.OFF)
            {
                if (event.data.info)
                {
                    StallsControl.getInstance().downLoad(event.data.info.prop.itemId, event.data.info.prop.num);
                }
            }
            else if (event.data.info)
            {
                StallsControl.getInstance().changeStallsGoods(event.data.info);
            }
            else if (event.data.type == 1 || event.data.type == 2)
            {
                _loc_2 = new StallsGoodInfo();
                _loc_3 = new PropInfo();
                _loc_3.itemModelId = -event.data.type;
                _loc_2.prop = _loc_3;
                _loc_2.pos = 0;
                _loc_2.pricegold = 0;
                _loc_2.priceyuanbao = 0;
                _loc_2.isNew = true;
                StallsControl.getInstance().openCurrencyPanel(_loc_2);
            }
            return;
        }// end function

        private function __focusIn(event:FocusEvent) : void
        {
            if (this._templateTxt && this._templateTxt.parent)
            {
                this._templateTxt.parent.removeChild(this._templateTxt);
            }
            return;
        }// end function

        private function __changeTitle(event:Event) : void
        {
            StallsControl.getInstance().changeTitle(this._titleNameTxt.text);
            return;
        }// end function

        private function __offClick(event:MouseEvent) : void
        {
            if (this._status == this.NORMAL)
            {
                this._status = this.OFF;
                Global.primaryCursorManager.showSellIcon();
                this._offBtn.setText(LanguageCfgObj.getInstance().getByIndex("10284"));
            }
            else if (this._status == this.OFF)
            {
                this._status = this.NORMAL;
                Global.primaryCursorManager.hide();
                this._offBtn.setText(LanguageCfgObj.getInstance().getByIndex("10280"));
            }
            else if (this._status == this.ADD)
            {
                this._status = this.OFF;
                StallsControl.getInstance().closeAdd();
                Global.primaryCursorManager.showSellIcon();
                this._offBtn.setText(LanguageCfgObj.getInstance().getByIndex("10284"));
                this._addedBtn.setText(LanguageCfgObj.getInstance().getByIndex("10281"));
            }
            return;
        }// end function

        private function __addedClick(event:MouseEvent) : void
        {
            if (this._status == this.NORMAL)
            {
                this._status = this.ADD;
                StallsControl.getInstance().changeToAdd();
                Global.primaryCursorManager.showSellIcon();
                this._addedBtn.setText(LanguageCfgObj.getInstance().getByIndex("10288"));
            }
            else if (this._status == this.OFF)
            {
                this._status = this.ADD;
                StallsControl.getInstance().changeToAdd();
                Global.primaryCursorManager.showSellIcon();
                this._addedBtn.setText(LanguageCfgObj.getInstance().getByIndex("10288"));
                this._offBtn.setText(LanguageCfgObj.getInstance().getByIndex("10280"));
            }
            else if (this._status == this.ADD)
            {
                this._status = this.NORMAL;
                StallsControl.getInstance().closeAdd();
                Global.primaryCursorManager.hide();
                this._addedBtn.setText(LanguageCfgObj.getInstance().getByIndex("10281"));
            }
            return;
        }// end function

        public function changeName() : void
        {
            var _loc_1:* = null;
            if (this._info == null || this._info.stallsname == "" || this._info.stallsname == null)
            {
                if (this._templateTxt == null)
                {
                    this._templateTxt = new TextField();
                    this._templateTxt.autoSize = "left";
                    this._templateTxt.mouseEnabled = false;
                    this._templateTxt.x = this._titleNameTxt.x;
                    this._templateTxt.y = this._titleNameTxt.y - 2;
                    _loc_1 = this._templateTxt.defaultTextFormat;
                    _loc_1.font = "SimSun";
                    this._templateTxt.defaultTextFormat = _loc_1;
                }
                if (this._templateTxt.parent == null)
                {
                    addChild(this._templateTxt);
                }
                this._templateTxt.htmlText = this.TEMPLATE;
            }
            else
            {
                if (this._templateTxt && this._templateTxt.parent)
                {
                    this._templateTxt.parent.removeChild(this._templateTxt);
                }
                this._titleNameTxt.text = this._info.stallsname;
            }
            return;
        }// end function

    }
}
