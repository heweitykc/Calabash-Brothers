package com.game.goldRaffle.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.scroller.*;
    import com.game.backpack.view.*;
    import com.game.goldRaffle.control.*;
    import com.game.goldRaffle.view.component.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class TreasureHousePanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var _allPackBtn:BaseButton;
        private var _capacityTxt:TextField;
        private var _scrollpanel:ScrollPanel;
        private var _bagSp:Sprite;
        private var _bagContainer:HBox;
        private var _arrangeBtn:BaseButton;
        private var _grc:GoldRaffleControl;
        private var timeDown:int;
        private var relativeBtn:BaseButton;

        public function TreasureHousePanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this._grc = GoldRaffleControl.getInstance();
            super(param1, param2, param3, param4);
            loadDisplay(GoldRafflesPanel.SWF);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("goldRaffles_treasureHouse");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._bagContainer = new HBox();
            this._bagContainer.intervalX = 1;
            this._bagContainer.intervalY = 2;
            this._bagContainer.oneRow = 7;
            this._bagContainer.y = 4;
            this._bagSp = new Sprite();
            this._bagSp.addChild(this._bagContainer);
            this.btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this._allPackBtn = new BaseButton(getDisplayChildByName("allPackBtn"));
            this._arrangeBtn = new BaseButton(getDisplayChildByName("arrangeBtn"));
            this._arrangeBtn.setText("整理");
            this._allPackBtn.setText("全部取走");
            this._capacityTxt = getDisplayChildByName("capacityTxt");
            this._scrollpanel = new ScrollPanel(350, 385);
            this._scrollpanel.content = this._bagSp;
            this._scrollpanel.move(16, 88);
            addChild(this._scrollpanel);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this._bagContainer.addEventListener("rightClick", this.__pack);
            return;
        }// end function

        private function __pack(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event.target is TreasureBoxItem)
            {
                _loc_2 = event.target as TreasureBoxItem;
                if (_loc_2.info)
                {
                    GoldRaffleControl.getInstance().reqGoldRaffleBoxUseItemToServer(_loc_2.gridId, 2);
                }
            }
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(event.target)
            {
                case this.btnClose:
                {
                    this.close();
                    break;
                }
                case this._allPackBtn:
                {
                    this._grc.reqGoldRaffleBoxUseItemToServer(-1);
                    break;
                }
                case this._arrangeBtn:
                {
                    this._grc.reqGoldRaffleBoxArrangeToServer();
                    this.timeDown = 30;
                    this._arrangeBtn.setText(this.timeDown.toString() + "秒");
                    this._arrangeBtn.enabled = false;
                    Ticker.registerTimer(1, this.updateArangeBtn, null, 30);
                    break;
                }
                default:
                {
                    if (event.target is TreasureBoxItem)
                    {
                        _loc_2 = event.target as TreasureBoxItem;
                        if (_loc_2.info)
                        {
                            if ((_loc_2.info as PropInfo).q_ui == 0)
                            {
                                ItemPopMenu.instance.show(_loc_2.info as PropInfo, FrameworkGlobal.stage, 0, 0, ItemPopMenu.TREASURE1, null, _loc_2.gridId);
                            }
                            else
                            {
                                ItemPopMenu.instance.show(_loc_2.info as PropInfo, FrameworkGlobal.stage, 0, 0, ItemPopMenu.TREASURE2, null, _loc_2.gridId);
                            }
                        }
                    }
                    break;
                }
            }
            return;
        }// end function

        private function updateArangeBtn() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this.timeDown - 1;
            _loc_1.timeDown = _loc_2;
            if (this.timeDown > 0)
            {
                this._arrangeBtn.setText(this.timeDown.toString() + "秒");
            }
            else
            {
                this._arrangeBtn.setText("整理");
                this._arrangeBtn.enabled = true;
                Ticker.killTimer(this.updateArangeBtn);
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            GoldRaffleControl.getInstance().reqOpenGoldRaffleBoxInfo();
            return;
        }// end function

        private function arrangBoxes() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (this.isOpen && UILoaded)
            {
                _loc_1 = this._grc.rewardslist;
                _loc_2 = _loc_1.length;
                this._bagContainer.reset();
                _loc_3 = 0;
                while (_loc_3 < this.maxGrid())
                {
                    
                    _loc_4 = new TreasureBoxItem();
                    this._bagContainer.add(_loc_4, false, 0, 0);
                    (this._bagContainer.getContent(_loc_3) as TreasureBoxItem).setInfo(null);
                    _loc_3++;
                }
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    (this._bagContainer.getContent(_loc_1[_loc_3].grididx) as TreasureBoxItem).setGridinfo(_loc_1[_loc_3]);
                    _loc_3++;
                }
                this._scrollpanel.updateThumb();
                this._scrollpanel.scrollToBottom();
            }
            return;
        }// end function

        public function addBoxes(param1:Vector.<GoldRaffleGridInfo>) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (this.isOpen && UILoaded)
            {
                _loc_2 = param1.length;
                _loc_3 = this.maxGrid() - this._bagContainer.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_5 = new TreasureBoxItem();
                    _loc_5.setInfo(null);
                    this._bagContainer.add(_loc_5, false, 0, 0);
                    _loc_4++;
                }
                _loc_4 = 0;
                while (_loc_4 < _loc_2)
                {
                    
                    (this._bagContainer.getContent(param1[_loc_4].grididx) as TreasureBoxItem).setGridinfo(param1[_loc_4]);
                    _loc_4++;
                }
                this._capacityTxt.text = this._grc.chestsCapacity + "/" + this._grc.CHESTS_MAX_CAPACITY;
                this._scrollpanel.updateThumb();
                this._scrollpanel.scrollToBottom();
            }
            return;
        }// end function

        private function maxGrid() : int
        {
            var _loc_1:* = this._grc.rewardslist.length;
            _loc_1 = _loc_1 < 56 ? (56) : (Math.ceil(_loc_1 / 7) * 7);
            return _loc_1;
        }// end function

        public function updateInfo() : void
        {
            if (!this._capacityTxt)
            {
                return;
            }
            this._capacityTxt.text = this._grc.chestsCapacity + "/" + this._grc.CHESTS_MAX_CAPACITY;
            this.arrangBoxes();
            return;
        }// end function

        public function updateCapacity() : void
        {
            if (!this._capacityTxt)
            {
                return;
            }
            this._capacityTxt.text = this._grc.chestsCapacity + "/" + this._grc.CHESTS_MAX_CAPACITY;
            return;
        }// end function

        public function removeItem(param1:int = -1, param2:int = 2) : void
        {
            var _loc_3:* = this._bagContainer.getContent(param1) as TreasureBoxItem;
            if (param2 == 1)
            {
                _loc_3.setDes();
            }
            else if (param2 == 2)
            {
                (this._grc.chestsCapacity - 1);
                this._grc.updateChestsCapacity();
                _loc_3.setInfo(null);
            }
            return;
        }// end function

        public function setRealitiveBtn(param1:BaseButton) : void
        {
            this.relativeBtn = param1;
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.relativeBtn.setSelected(false);
            return;
        }// end function

        override public function open() : void
        {
            this.relativeBtn.setSelected(true);
            super.open();
            return;
        }// end function

    }
}
