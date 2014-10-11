package com.game.store.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.player.events.*;
    import com.game.player.model.*;
    import com.game.store.control.*;
    import com.game.store.events.*;
    import com.game.store.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class StorePanel extends BaseBox
    {
        private var storeOpenGridView:StoreOpenGridView;
        private var btnTrim:BaseButton;
        private var btnClose:BaseButton;
        private var backOperat:Sprite;
        private var btnOperat:BaseButton;
        private var txtUseGrid:TextField;
        private var vecTabs:Vector.<BaseButton>;
        private var tabButtons:Buttons;
        private var gridHBox:HBox;
        private var vecGrids:Vector.<StoreItem>;
        private var _storePage:int = 0;
        private var _selectItem:StoreItem;
        private var _delayHandle:uint;
        private var _doubleClickDelay:uint;
        private var delayHandler:uint = 0;
        private var downTime:int = 30;

        public function StorePanel()
        {
            this.backOperat = new Sprite();
            this.vecTabs = new Vector.<BaseButton>(5, true);
            _combinedBox = ["com.game.backpack.view::BackPackPanel", "com.game.store.view.openGridView"];
            loadDisplay("res/backStorage.swf");
            return;
        }// end function

        public function get storePage() : int
        {
            return this._storePage;
        }// end function

        public function set storePage(param1:int) : void
        {
            if (this._storePage != param1)
            {
                this._storePage = param1;
                this.freshStorage();
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("backStorage");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_4:* = null;
            this.vecGrids = new Vector.<StoreItem>(StoreModel.MAX_GRID_COUNT, true);
            this.btnTrim = new BaseButton(getDisplayChildByName("btn_trim"));
            this.btnTrim.setText(LanguageCfgObj.getInstance().getByIndex("11281"));
            this.btnClose = new BaseButton(getDisplayChildByName("btn_close"));
            this.btnOperat = new BaseButton(ObjectPool.CheckOutByName("menu_btn"));
            this.btnOperat.setText(LanguageCfgObj.getInstance().getByIndex("11282"));
            this.btnOperat.y = 3;
            this.btnOperat.x = 3;
            var _loc_1:* = ObjectPool.CheckOutByName("menu_bg") as Sprite;
            _loc_1.height = 26;
            this.backOperat.addChild(_loc_1);
            this.backOperat.addChild(this.btnOperat);
            this.txtUseGrid = getDisplayChildByName("txt_use");
            this.txtUseGrid.mouseEnabled = false;
            this.tabButtons = new Buttons();
            this.tabButtons.horizontal = true;
            this.tabButtons.intervalX = 0;
            this.tabButtons.intervalY = 0;
            this.tabButtons.move(50 - 6, 70 - 18);
            addChild(this.tabButtons);
            var _loc_2:* = ["Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ"];
            var _loc_3:* = 0;
            while (_loc_3 < 3)
            {
                
                _loc_4 = new BaseButton(getDisplayChildByName("tabBtn" + _loc_3.toString()), true);
                this.vecTabs[_loc_3] = _loc_4;
                _loc_4.setText("<p align = \'center\'><b>" + _loc_2[_loc_3] + "</b></p>");
                this.tabButtons.add(_loc_4);
                _loc_3++;
            }
            this.initGridBox();
            this.storeOpenGridView = new StoreOpenGridView();
            this.storeOpenGridView.dragBarH = 40;
            this.storeOpenGridView.callClose = this.unLockStorePanel;
            return;
        }// end function

        private function initGridBox() : void
        {
            var _loc_2:* = null;
            this.gridHBox = new HBox();
            this.gridHBox.oneRow = StoreModel.MAX_GRID_ROW;
            this.gridHBox.intervalX = 2;
            this.gridHBox.intervalY = 2;
            this.gridHBox.move(15, 83);
            this.addChild(this.gridHBox);
            var _loc_1:* = 0;
            while (_loc_1 < StoreModel.MAX_GRID_COUNT)
            {
                
                _loc_2 = new StoreItem();
                _loc_2.place = Params.ITEM_PLACE_STORE;
                _loc_2.gridId = _loc_1 + 1;
                _loc_2.accpetKey = [Params.ITEM_PLACE_STORE, Params.ITEM_PLACE_BACKPACK];
                _loc_2.parentContainer = this;
                _loc_2.isMenu = false;
                this.gridHBox.add(_loc_2, false, 0, 0);
                this.vecGrids[_loc_1] = _loc_2;
                _loc_1++;
            }
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClick);
            this.doubleClickEnabled = true;
            this.addEventListener(MouseEvent.DOUBLE_CLICK, this.doubleClickHandler);
            this.addEventListener("rightClick", this.MouseRightClickHandler);
            this.tabButtons.addEvtListener(Event.CHANGE, this.onTabChange);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            EquipsObj.getInstance().addEvtListeners([EquipEvent.TAKE_OFF, EquipEvent.WEAR, EquipEvent.EQUIPSTRENTH], this.recountValue);
            return;
        }// end function

        protected function MouseRightClickHandler(event:MouseEvent) : void
        {
            if (event.target is StoreItem)
            {
                this.moveToBackPack(event.target as StoreItem);
            }
            return;
        }// end function

        private function doubleClickHandler(event:MouseEvent) : void
        {
            if (event.target is StoreItem)
            {
                this.moveToBackPack(event.target as StoreItem);
            }
            return;
        }// end function

        private function moveToBackPack(param1:StoreItem) : void
        {
            if (param1.info)
            {
                StoreDispatcher.dispatch().dispatchEvent(new StoreEvent(StoreEvent.ITEM_MOVE_TO_BACKPACK, {info:param1.info}));
            }
            return;
        }// end function

        private function onTabChange(event:Event) : void
        {
            this.storePage = event.target.selectIndex;
            return;
        }// end function

        public function updateStorage() : void
        {
            this.freshStorage();
            this.updateItemCount();
            return;
        }// end function

        private function freshStorage() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            this.cleanStorage();
            this.cleanStorageEffect();
            this.freshLock();
            var _loc_1:* = StoreModel.getInstance().getItemsListByPage(this.storePage);
            if (!_loc_1)
            {
                return;
            }
            var _loc_2:* = _loc_1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = _loc_1[_loc_3] as PropInfo;
                if (_loc_4)
                {
                    _loc_5 = StoreModel.getInstance().getIndexFromGridId(_loc_4.gridId);
                    _loc_6 = this.vecGrids[_loc_5];
                    _loc_6.info = _loc_4;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function freshLock() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = StoreModel.getInstance().getLockFirstIndexFromPage(this.storePage);
            var _loc_3:* = 0;
            while (_loc_3 < StoreModel.MAX_GRID_COUNT)
            {
                
                _loc_2 = this.vecGrids[_loc_3];
                _loc_2.lock = _loc_3 >= _loc_1 ? (true) : (false);
                _loc_3++;
            }
            return;
        }// end function

        private function mouseClick(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (event.target is StoreItem)
            {
                _loc_2 = getTimer();
                if (_loc_2 - this._doubleClickDelay < 300)
                {
                    this.doubleClickHandler(event);
                }
                this._doubleClickDelay = _loc_2;
                _loc_3 = event.target as StoreItem;
                this.clickStoreItem(_loc_3);
                return;
            }
            switch(event.target)
            {
                case this.btnTrim:
                {
                    this.trimStore();
                    break;
                }
                case this.btnClose:
                {
                    this.close();
                    break;
                }
                case this.btnOperat:
                {
                    if (this._selectItem)
                    {
                        this._selectItem.dispatchEvent(new MouseEvent("rightClick"));
                        this.backOperat.parent.removeChild(this.backOperat);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this.backOperat.parent)
            {
                this.backOperat.parent.removeChild(this.backOperat);
            }
            return;
        }// end function

        private function openStoreOpenGrid() : void
        {
            this.addChild(this.storeOpenGridView);
            this.storeOpenGridView.x = -20;
            this.storeOpenGridView.y = 200;
            this.lockStorePanel();
            return;
        }// end function

        private function lockStorePanel() : void
        {
            return;
        }// end function

        private function unLockStorePanel() : void
        {
            this.cleanStorageEffect();
            return;
        }// end function

        private function clickStoreItem(param1:StoreItem) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (param1.info)
            {
                this.addChild(this.backOperat);
                this.backOperat.x = this.mouseX;
                this.backOperat.y = this.mouseY;
                this._selectItem = param1;
            }
            else if (this.backOperat.parent)
            {
                this.backOperat.parent.removeChild(this.backOperat);
            }
            this.cleanStorageEffect();
            if (param1.lock)
            {
                _loc_2 = StoreModel.getInstance().getPageFromGridId(StoreModel.getInstance().cellnum);
                if (_loc_2 < this._storePage)
                {
                    _loc_3 = 0;
                }
                else
                {
                    _loc_3 = StoreModel.getInstance().getIndexFromGridId((StoreModel.getInstance().cellnum + 1));
                }
                _loc_4 = StoreModel.getInstance().getIndexFromGridId(param1.gridId);
                _loc_5 = _loc_3;
                while (_loc_5 <= _loc_4)
                {
                    
                    this.vecGrids[_loc_5].isEffect = true;
                    _loc_5++;
                }
                this.storeOpenGridView.count = StoreModel.getInstance().getGridIdFromIndexAndPage((_loc_4 + 1), this._storePage) - StoreModel.getInstance().cellnum + 1;
                this.openStoreOpenGrid();
            }
            return;
        }// end function

        private function trimStore() : void
        {
            var delayCall:Function;
            delayCall = function () : void
            {
                if (downTime <= 0)
                {
                    clearTimeout(delayHandler);
                    delayHandler = 0;
                    btnTrim.filters = [];
                    btnTrim.setText(LanguageCfgObj.getInstance().getByIndex("11281"));
                    downTime = 30;
                }
                else
                {
                    delayHandler = setTimeout(delayCall, 1000);
                    btnTrim.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11968"), [downTime]));
                }
                var _loc_2:* = downTime - 1;
                downTime = _loc_2;
                return;
            }// end function
            ;
            if (!this.delayHandler)
            {
                StoreControl.getInstance().arrangeStorage();
                this.btnTrim.filters = [ColorFilter.getGrayFilter()];
                this.delayCall();
            }
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            StoreControl.getInstance().reqStoreGetItems();
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        public function updateItemInfo(param1:PropInfo) : void
        {
            var _loc_2:* = StoreModel.getInstance().getIndexFromGridId(param1.gridId);
            var _loc_3:* = StoreModel.getInstance().getPageFromGridId(param1.gridId);
            if (_loc_3 == this._storePage)
            {
                this.vecGrids[_loc_2].info = param1;
            }
            this.updateItemCount();
            return;
        }// end function

        private function updateItemCount() : void
        {
            this.txtUseGrid.text = StoreModel.getInstance().count + "/" + StoreModel.getInstance().cellnum;
            return;
        }// end function

        public function updateItemChangeInfo(param1:PropInfo) : void
        {
            var _loc_2:* = StoreModel.getInstance().getIndexFromGridId(param1.gridId);
            var _loc_3:* = StoreModel.getInstance().getPageFromGridId(param1.gridId);
            if (this._storePage == _loc_3)
            {
                this.vecGrids[_loc_2].info = param1;
            }
            return;
        }// end function

        public function removeItemInfo(param1:PropInfo) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = StoreModel.getInstance().getIndexFromGridId(param1.gridId);
            var _loc_3:* = StoreModel.getInstance().getPageFromGridId(param1.gridId);
            if (this._storePage == _loc_3)
            {
                _loc_4 = this.vecGrids[_loc_2].info;
                if (!_loc_4 || _loc_4.itemId.equal(param1.itemId))
                {
                    this.vecGrids[_loc_2].info = null;
                }
            }
            this.updateItemCount();
            return;
        }// end function

        public function unLockGrid() : void
        {
            this.storeOpenGridView.close();
            this.freshLock();
            this.cleanStorageEffect();
            this.updateItemCount();
            return;
        }// end function

        private function cleanStorage() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this.vecGrids.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this.vecGrids[_loc_2];
                _loc_3.info = null;
                _loc_2++;
            }
            return;
        }// end function

        private function cleanStorageEffect() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this.vecGrids.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this.vecGrids[_loc_2];
                _loc_3.isEffect = false;
                _loc_2++;
            }
            return;
        }// end function

        private function recountValue(event:EquipEvent) : void
        {
            var _loc_2:* = this.vecGrids.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.vecGrids[_loc_3].desideIcon();
                _loc_3++;
            }
            return;
        }// end function

    }
}
