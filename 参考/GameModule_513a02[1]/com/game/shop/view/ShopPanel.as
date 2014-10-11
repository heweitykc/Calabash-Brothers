package com.game.shop.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.scroller.*;
    import com.game.shop.control.*;
    import com.game.shop.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ShopPanel extends BaseBox
    {
        protected var _scroll:ScrollPanel;
        protected var _container:HBox;
        private var _info:ShopItemsInfo;
        private var _oneKey:BaseButton;
        private var _sellBtn:BaseButton;
        private var _checkBtn:BaseButton;
        private var _curlist:Vector.<ShopItemInfo>;
        private var _closeBtn:BaseButton;
        private var _shopModelId:int;
        private var _npcId:int;
        private var _holder:Sprite;
        private var _checked:Boolean;
        private var txt_title:TextField;
        private var _isSell:Boolean;
        private var _batBtn:BaseButton;

        public function ShopPanel()
        {
            _combinedBox = ["com.game.backpack.view::BackPackPanel", "com.game.backpack.view::OneKeyPanel", "com.game.shop.view::ShopBuyPanel", "com.game.shop.view::OneKeyPanel"];
            loadDisplay("res/shop.swf");
            return;
        }// end function

        public function get info() : ShopItemsInfo
        {
            return this._info;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("shoppanel");
            this.initUI();
            this.addListener();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._container = new HBox();
            this._container.intervalX = 2;
            this._container.intervalY = -2;
            this._container.oneRow = 2;
            this._scroll = new ScrollPanel(418, 410);
            this._holder = getDisplayChildByName("holder");
            this._scroll.content = this._container;
            addChild(this._scroll);
            this._scroll.x = this._holder.x;
            this._scroll.y = this._holder.y;
            this._oneKey = new BaseButton(getDisplayChildByName("btn_onekey"));
            this._oneKey.setText(LanguageCfgObj.getInstance().getByIndex("11140"));
            this._sellBtn = new BaseButton(getDisplayChildByName("btn_sell"));
            this._sellBtn.setText(LanguageCfgObj.getInstance().getByIndex("11141"));
            this._checkBtn = new BaseButton(getDisplayChildByName("check_btn"), true);
            this._batBtn = new BaseButton(getDisplayChildByName("check_btn1"), true);
            this._checkBtn.setText(LanguageCfgObj.getInstance().getByIndex("11142"));
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this.txt_title = getDisplayChildByName("txt_title") as TextField;
            this.txt_title.defaultTextFormat = new TextFormat("宋体", 16, 16750848, true, null, null, null, null, "center", null, null, null, 30);
            if (this._curlist)
            {
                this.update();
            }
            return;
        }// end function

        private function addListener() : void
        {
            this._sellBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._oneKey.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._checkBtn.addEvtListener(MouseEvent.CLICK, this.__check);
            this._batBtn.addEvtListener(MouseEvent.CLICK, this.__groupCheck);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            return;
        }// end function

        private function __groupCheck(event:MouseEvent) : void
        {
            ShopController.getInstance().autoGroup = !ShopController.getInstance().autoGroup;
            return;
        }// end function

        public function cancelSell() : void
        {
            this._sellBtn.setText(LanguageCfgObj.getInstance().getByIndex("11141"));
            this._isSell = false;
            return;
        }// end function

        private function __check(event:MouseEvent) : void
        {
            this._checked = this._checkBtn.selected;
            if (this._checked)
            {
                this.curlist = this.getLimitedList();
            }
            else
            {
                this.curlist = this._info.shopItemList;
            }
            this.update();
            return;
        }// end function

        public function getLimitedList() : Vector.<ShopItemInfo>
        {
            var _loc_1:* = new Vector.<ShopItemInfo>;
            var _loc_2:* = 0;
            while (_loc_2 < this._info.shopItemList.length)
            {
                
                if (this._info.shopItemList[_loc_2].showLevel <= UserObj.getInstance().playerInfo.level && PropUtil.canUseByJobKind(this._info.shopItemList[_loc_2].prop.q_job_limit, UserObj.getInstance().playerInfo.jobkind))
                {
                    _loc_1.push(this._info.shopItemList[_loc_2]);
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._sellBtn:
                {
                    this._isSell = !this._isSell;
                    if (this._isSell)
                    {
                        this._sellBtn.setText(LanguageCfgObj.getInstance().getByIndex("11144"));
                        ShopController.getInstance().screenSell();
                    }
                    else if (!this._isSell)
                    {
                        this._sellBtn.setText(LanguageCfgObj.getInstance().getByIndex("11141"));
                        ShopController.getInstance().cancelSell();
                    }
                    if (this._isSell)
                    {
                        FrameworkGlobal.stage.addEventListener("rightClick", this.__stageRightClick, false, 0, true);
                    }
                    break;
                }
                case this._oneKey:
                {
                    ShopController.getInstance().openOneKey();
                    break;
                }
                case this._closeBtn:
                {
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __stageRightClick(event:MouseEvent) : void
        {
            FrameworkGlobal.stage.removeEventListener("rightClick", this.__stageRightClick);
            ShopController.getInstance().cancelSell();
            return;
        }// end function

        public function set info(param1:ShopItemsInfo) : void
        {
            this._info = param1;
            this.curlist = this._info.shopItemList;
            this._shopModelId = this._info.shopModelId;
            if (this._container)
            {
                this.update();
            }
            return;
        }// end function

        override public function finalize() : void
        {
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this._checkBtn.selected = false;
                if (this._info && this._info.shopItemList)
                {
                    this.curlist = this._info.shopItemList;
                }
            }
            return;
        }// end function

        private function update() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_1:* = this._curlist.length;
            var _loc_2:* = _loc_1 - this._container.length;
            if (_loc_2 > 0)
            {
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_4 = new ShopItem();
                    this._container.add(_loc_4);
                    _loc_3++;
                }
            }
            else
            {
                _loc_2 = -_loc_2;
                _loc_5 = this._container.length;
                _loc_3 = _loc_5 - 1;
                while (_loc_3 >= _loc_5 - _loc_2)
                {
                    
                    this._container.removeByIndex(_loc_3);
                    _loc_3 = _loc_3 - 1;
                }
            }
            _loc_3 = 0;
            while (_loc_3 < this._container.length)
            {
                
                this._container.getContent(_loc_3).info = this._curlist[_loc_3];
                _loc_3++;
            }
            this._scroll.scrollTo(0);
            this._scroll.updateThumb();
            this.txt_title.text = this._info.title;
            return;
        }// end function

        public function set curlist(param1:Vector.<ShopItemInfo>) : void
        {
            this._curlist = param1;
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            ShopController.getInstance().cancelSell();
            return;
        }// end function

    }
}
