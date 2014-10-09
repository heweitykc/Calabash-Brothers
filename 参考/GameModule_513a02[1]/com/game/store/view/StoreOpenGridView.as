package com.game.store.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.store.control.*;
    import com.game.store.model.*;
    import com.model.*;
    import flash.events.*;
    import flash.text.*;

    public class StoreOpenGridView extends BaseBox
    {
        private var btnClose:BaseButton;
        private var btnBuy:BaseButton;
        private var btnMaxGrid:BaseButton;
        private var btnReduceOne:BaseButton;
        private var btnAddedOne:BaseButton;
        private var txtCount:TextField;
        private var txtCost:TextField;
        private var _count:int;
        private var _isCanBuy:Boolean;
        public var callClose:Function;

        public function StoreOpenGridView(param1 = null, param2:String = null)
        {
            initBaseBoxUI("openGridView");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this.btnAddedOne = new BaseButton(getDisplayChildByName("btnAddedOne"));
            this.btnBuy = new BaseButton(getDisplayChildByName("btnBuy"));
            this.btnBuy.setText(LanguageCfgObj.getInstance().getByIndex("11280"));
            this.btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this.btnMaxGrid = new BaseButton(getDisplayChildByName("btnMaxGrid"));
            this.btnReduceOne = new BaseButton(getDisplayChildByName("btnReduceOne"));
            this.txtCost = getDisplayChildByName("txtCost");
            this.txtCount = getDisplayChildByName("txtCount");
            this.txtCount.maxChars = 3;
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.txtCount.addEventListener(Event.CHANGE, this.txtCountHandler);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btnAddedOne:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.count + 1;
                    _loc_2.count = _loc_3;
                    break;
                }
                case this.btnBuy:
                {
                    this.clicBuy();
                    break;
                }
                case this.btnClose:
                {
                    this.close();
                    break;
                }
                case this.btnMaxGrid:
                {
                    this.clickBtnMaxGrid();
                    break;
                }
                case this.btnReduceOne:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.count - 1;
                    _loc_2.count = _loc_3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function clickBtnMaxGrid() : void
        {
            this.count = StoreModel.getInstance().getCanOpenMaXGridCount();
            return;
        }// end function

        private function clicBuy() : void
        {
            var _loc_1:* = StoreModel.getInstance().cellnum + this._count;
            StoreControl.getInstance().reqStoreOpenCell(_loc_1);
            return;
        }// end function

        protected function txtCountHandler(event:Event) : void
        {
            if (int(this.txtCount.text) < 1)
            {
                this.txtCount.text = "1";
            }
            this._count = int(this.txtCount.text);
            this.setTxtCount();
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set count(param1:int) : void
        {
            var _loc_2:* = StoreModel.getInstance().getCanOpenMaXGridCount();
            this._count = param1;
            this._count = this._count < 1 ? (1) : (this._count);
            this._count = this._count > _loc_2 ? (_loc_2) : (this._count);
            this.txtCount.text = this._count.toString();
            this.setTxtCount();
            return;
        }// end function

        private function setTxtCount() : void
        {
            var _loc_1:* = StoreModel.getInstance().cellnum + this._count;
            var _loc_2:* = StoreModel.getInstance().getOpenCellCost(_loc_1);
            if (UserObj.getInstance().playerInfo.gold < _loc_2)
            {
                this.btnBuy.filters = [ColorFilter.getGrayFilter()];
            }
            else
            {
                this.btnBuy.filters = [];
            }
            this.txtCost.text = _loc_2.toString();
            return;
        }// end function

        private function get isCanBuy() : Boolean
        {
            return this._isCanBuy;
        }// end function

        private function set isCanBuy(param1:Boolean) : void
        {
            this._isCanBuy = param1;
            return;
        }// end function

        override public function close() : void
        {
            this.txtCount.text = "0";
            this.txtCost.text = "0";
            this.btnBuy.filters = [];
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            if (this.callClose != null)
            {
                this.callClose();
            }
            return;
        }// end function

    }
}
