package com.game.auction.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.auction.control.*;
    import com.game.auction.events.*;
    import com.game.auction.model.*;
    import com.game.chat.consts.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class MineBoothContainer extends Component
    {
        private var _container:HBox;
        private var _addedBtn:BaseButton;
        private var _offBtn:BaseButton;
        private var _status:String;
        public const NORMAL:String = "normal";
        public const OFF:String = "off";
        public const ADD:String = "add";
        private var _info:Vector.<AuctionItemInfo>;
        private var TEMPLATE:String;
        private var _templateTxt:TextField;

        public function MineBoothContainer(param1)
        {
            this._status = this.NORMAL;
            this.TEMPLATE = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11656"), [UserObj.getInstance().playerInfo.name]);
            super(param1);
            this.initUI();
            this.addListener();
            AuctionControl.getInstance().mineContainer = this;
            if (AuctionObj.getInstance().selfStalls)
            {
                this.update();
            }
            else
            {
                this.update();
                AuctionControl.getInstance().openMystallsInfo();
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
            return;
        }// end function

        public function get info() : Vector.<AuctionItemInfo>
        {
            return this._info;
        }// end function

        public function set info(param1:Vector.<AuctionItemInfo>) : void
        {
            this._info = param1;
            this.update();
            return;
        }// end function

        public function update() : void
        {
            var _loc_2:* = 0;
            var _loc_6:* = null;
            this._info = AuctionObj.getInstance().selfStalls;
            var _loc_1:* = this._info == null ? (0) : (this._info.length);
            var _loc_3:* = false;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_1)
            {
                
                _loc_6 = this._info[_loc_5];
                if (_loc_6.item.itemModelId == -1)
                {
                    this._container.getContent(8).info = _loc_6;
                    _loc_3 = true;
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
            AuctionControl.getInstance().sellNum = _loc_2;
            _loc_5 = _loc_2;
            while (_loc_5 <= 7)
            {
                
                this._container.getContent(_loc_5).info = null;
                _loc_5++;
            }
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = null;
            this._container = new HBox();
            this._container.intervalY = 1;
            this._container.oneRow = 2;
            this._container.x = getDisplayChildByName("item_0").x;
            this._container.y = getDisplayChildByName("item_0").y;
            var _loc_1:* = 0;
            while (_loc_1 < 8)
            {
                
                _loc_3 = new AuctionGoodItem(getDisplayChildByName("item_" + _loc_1));
                _loc_3.isMine = true;
                this._container.add(_loc_3);
                _loc_1++;
            }
            var _loc_2:* = new AuctionCurrencyItem(getDisplayChildByName("item_8"), 1);
            _loc_2.isMine = true;
            this._container.add(_loc_2);
            addChild(this._container);
            this._offBtn = new BaseButton(getDisplayChildByName("btn_off"));
            this._offBtn.setText(LanguageCfgObj.getInstance().getByIndex("10280"));
            this._addedBtn = new BaseButton(getDisplayChildByName("btn_added"));
            this._addedBtn.setText(LanguageCfgObj.getInstance().getByIndex("10281"));
            return;
        }// end function

        private function addListener() : void
        {
            this._offBtn.addEvtListener(MouseEvent.CLICK, this.__offClick);
            this._addedBtn.addEvtListener(MouseEvent.CLICK, this.__addedClick);
            addEvtListener(StallsEvent.BOARD, this.__board, false);
            addEvtListener(StallsEvent.SELECTEDGOOD, this.__selected, true);
            return;
        }// end function

        private function __board(event:StallsEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (event.data == null)
            {
                return;
            }
            if (this._status != this.OFF)
            {
                _loc_2 = AuctionObj.getInstance().preBoardTime;
                _loc_3 = getTimer();
                if (_loc_2 == 0 || _loc_3 - _loc_2 >= AuctionObj.BOARD_GAP)
                {
                    if (UserObj.getInstance().playerInfo.level >= ChatConst.SPEAK_LEVEL)
                    {
                        AuctionObj.getInstance().preBoardTime = _loc_3;
                        AuctionControl.getInstance().board(event.data.info);
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("12354"));
                    }
                }
                else
                {
                    _loc_4 = (AuctionObj.BOARD_GAP - (_loc_3 - _loc_2)) / 1000;
                    Global.popManager.addedToSystem(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11894"), [(_loc_4 + 1)]));
                }
            }
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
                    AuctionControl.getInstance().downLoad(event.data.info.itemId);
                }
            }
            else if (event.data.info)
            {
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
                AuctionControl.getInstance().openCurrencyPanel(_loc_2);
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
                AuctionControl.getInstance().closeAdd();
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
                AuctionControl.getInstance().changeToAdd();
                Global.primaryCursorManager.showSellIcon();
                this._addedBtn.setText(LanguageCfgObj.getInstance().getByIndex("10288"));
            }
            else if (this._status == this.OFF)
            {
                this._status = this.ADD;
                AuctionControl.getInstance().changeToAdd();
                Global.primaryCursorManager.showSellIcon();
                this._addedBtn.setText(LanguageCfgObj.getInstance().getByIndex("10288"));
                this._offBtn.setText(LanguageCfgObj.getInstance().getByIndex("10280"));
            }
            else if (this._status == this.ADD)
            {
                this._status = this.NORMAL;
                AuctionControl.getInstance().closeAdd();
                Global.primaryCursorManager.hide();
                this._addedBtn.setText(LanguageCfgObj.getInstance().getByIndex("10281"));
            }
            return;
        }// end function

    }
}
