package com.game.shop.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.game.backpack.model.*;
    import com.game.guide.control.*;
    import com.game.shop.control.*;
    import com.game.shop.events.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;

    public class OneKeyPanel extends BaseBox
    {
        private var _list:Array;
        private var _confirmBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _cancelBtn:BaseButton;
        private var _itemList:Vector.<OneKeyItem>;
        private var _bg:Sprite;
        private var _hbox:HBox;

        public function OneKeyPanel()
        {
            _combinedBox = ["com.game.backpack.view::BackPackPanel"];
            loadDisplay("res/onekeypanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("onekeypanel");
            this.initUI();
            this.addListener();
            super.displayReady();
            return;
        }// end function

        public function get list() : Array
        {
            return this._list;
        }// end function

        public function set list(param1:Array) : void
        {
            this._list = param1;
            if (UILoaded)
            {
                this.setInfo();
            }
            if (this._list.length == 0 && BackpackObj.getInstance().isFullForCount)
            {
                FunGuideControl.getInstance().addGuide(FunGuideControl.getInstance().ITEM_EXPANSION);
            }
            return;
        }// end function

        public function addListener() : void
        {
            addEvtListener(ShopEvent.CANCEL_SOLD, this.__cancelSellItem);
            this._confirmBtn.addEvtListener(MouseEvent.CLICK, this.__confirmClick);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__closeClick);
            this._cancelBtn.addEvtListener(MouseEvent.CLICK, this.__closeClick);
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this._itemList = new Vector.<OneKeyItem>;
            var _loc_1:* = 0;
            while (_loc_1 < 10)
            {
                
                _loc_2 = new OneKeyItem(getDisplayChildByName("item_" + _loc_1));
                this._itemList.push(_loc_2);
                _loc_1++;
            }
            this._confirmBtn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._cancelBtn = new BaseButton(getDisplayChildByName("btn_cancel"));
            this._closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("11132"));
            this._cancelBtn.setText(LanguageCfgObj.getInstance().getByIndex("11133"));
            if (this._list)
            {
                this.setInfo();
            }
            return;
        }// end function

        private function setInfo() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < 10)
            {
                
                if (this._list[_loc_1])
                {
                    this._itemList[_loc_1].info = this._list[_loc_1];
                }
                else
                {
                    this._itemList[_loc_1].info = null;
                }
                _loc_1++;
            }
            return;
        }// end function

        private function __closeClick(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function __confirmClick(event:MouseEvent) : void
        {
            var _loc_2:* = new Vector.<long>;
            var _loc_3:* = 0;
            while (_loc_3 < this._list.length)
            {
                
                _loc_2.push(this._list[_loc_3].itemId);
                _loc_3++;
            }
            if (_loc_2.length > 0)
            {
                ShopController.getInstance().sell(_loc_2);
                _loc_3 = 0;
                while (_loc_3 < this._list.length)
                {
                    
                    this._itemList[_loc_3].info = null;
                    _loc_3++;
                }
                this._list.splice(0);
            }
            this.close();
            return;
        }// end function

        private function __cancelSellItem(event:ShopEvent) : void
        {
            this.removeList(event.target.info);
            event.target.info = null;
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            var _loc_1:* = 0;
            while (_loc_1 < 10)
            {
                
                if (this._itemList[_loc_1].info)
                {
                    this._itemList[_loc_1].info = null;
                }
                _loc_1++;
            }
            return;
        }// end function

        private function removeList(param1:PropInfo) : void
        {
            var _loc_2:* = this._list.indexOf(param1);
            if (_loc_2 != -1)
            {
                this._list.splice(_loc_2, 1);
            }
            return;
        }// end function

    }
}
