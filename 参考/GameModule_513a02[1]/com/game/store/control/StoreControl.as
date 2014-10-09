package com.game.store.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.role.control.*;
    import com.game.store.events.*;
    import com.game.store.message.*;
    import com.game.store.model.*;
    import com.game.store.protocol.*;
    import com.game.store.view.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import interfaces.*;

    public class StoreControl extends Object
    {
        private var _panel:StorePanel;
        private var _protocol:StoreProtocol;
        private var _model:StoreModel;
        private var _disPatcher:StoreDispatcher;
        private static var _instance:StoreControl;

        public function StoreControl()
        {
            this._protocol = new StoreProtocol();
            this._disPatcher = StoreDispatcher.dispatch();
            this._model = StoreModel.getInstance();
            this.initEvents();
            return;
        }// end function

        public function get view() : StorePanel
        {
            if (!this._panel)
            {
                this._panel = new StorePanel();
                Global.popManager.addPop(this._panel);
            }
            return this._panel;
        }// end function

        private function initEvents() : void
        {
            this._disPatcher.addEventListener(StoreEvent.ITEM_ADDED_TO_STORE, this.addItemToStore);
            this._disPatcher.addEventListener(StoreEvent.ITEM_MOVE_INNER_STORE, this.moveInnerStore);
            this._disPatcher.addEventListener(StoreEvent.ITEM_MOVE_TO_BACKPACK, this.moveToBackPack);
            this._disPatcher.addEventListener(StoreEvent.ITEM_MOVE_TO_STORE, this.moveToStore);
            this._disPatcher.addEventListener(StoreEvent.ITEM_REMOVE_FROM_STORE, this.removeFromStore);
            return;
        }// end function

        private function addItemToStore(event:StoreEvent) : void
        {
            return;
        }// end function

        public function openStoragePayGold() : void
        {
            var storeNPC:int;
            if (this._panel && this._panel.parent)
            {
                this._panel.close();
                return;
            }
            var obj:* = VipCfgObj.getInstance().getVipInfo(UserObj.getInstance().playerInfo.vipid);
            if (obj && obj.q_storage > 0)
            {
                storeNPC = GlobalCfgObj.getInstance().getStoreOpenNPC();
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12209"), LanguageCfgObj.getInstance().getByIndex("11635"), [storeNPC], function (param1:int) : void
            {
                if (storeNPC)
                {
                    NpcControl.getInstance().npcFindPath(storeNPC);
                }
                return;
            }// end function
            );
            }
            else
            {
                this.reqOpenStore();
            }
            return;
        }// end function

        public function openStorageFree() : void
        {
            this.view.openOrClose();
            return;
        }// end function

        public function backOpenStore(param1:ResOpenStoreMessage) : void
        {
            if (param1.result == 1)
            {
                this.view.open();
            }
            return;
        }// end function

        public function storeItemInfosBack(param1:ResStoreItemInfosMessage) : void
        {
            this._model.cellnum = param1.cellnum;
            this._model.setInfo(param1.items);
            this.view.updateStorage();
            return;
        }// end function

        public function storeCellTimeBack(param1:ResStoreCellTimeMessage) : void
        {
            return;
        }// end function

        public function storeItemAddBack(param1:ResStoreItemAddMessage) : void
        {
            var _loc_2:* = this._model.addItem(param1.item);
            this._panel.updateItemInfo(_loc_2);
            return;
        }// end function

        public function storeItemChangeBack(param1:ResStoreItemChangeMessage) : void
        {
            var _loc_2:* = this._model.getInfoById(param1.item.itemId);
            this._panel.removeItemInfo(_loc_2);
            _loc_2 = this._model.itemUpdate(param1.item);
            this._panel.updateItemChangeInfo(_loc_2);
            return;
        }// end function

        public function storeItemRemoveBack(param1:ResStoreItemRemoveMessage) : void
        {
            var _loc_2:* = this._model.removeItem(param1.itemId);
            this._panel.removeItemInfo(_loc_2);
            return;
        }// end function

        public function storeOpenCellResultBack(param1:ResStoreOpenCellResultMessage) : void
        {
            if (param1.isSuccess == 1)
            {
                this._model.cellnum = param1.cellId;
            }
            this._panel.unLockGrid();
            return;
        }// end function

        public function reqStoreGetItems() : void
        {
            this._protocol.reqStoreGetItems();
            return;
        }// end function

        public function reqStoreOpenCell(param1:int) : void
        {
            this._protocol.reqStoreOpenCell(param1);
            return;
        }// end function

        public function arrangeStorage() : void
        {
            this._protocol.reqStoreClearUp();
            return;
        }// end function

        private function moveInnerStore(event:StoreEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.info;
            var _loc_4:* = _loc_2.targetItem;
            var _loc_5:* = _loc_3.itemId;
            var _loc_6:* = _loc_3.num;
            var _loc_7:* = StoreItem(_loc_4).gridId;
            this._protocol.reqStoreMoveItem(_loc_5, _loc_7, _loc_6);
            return;
        }// end function

        private function moveToBackPack(event:StoreEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.info;
            var _loc_4:* = _loc_3.gridId;
            this._protocol.reqStoreToBag(_loc_4);
            return;
        }// end function

        private function moveToStore(event:StoreEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.info;
            var _loc_4:* = _loc_3.gridId;
            this._protocol.reqBagToStore(_loc_4);
            return;
        }// end function

        private function removeFromStore(event:StoreEvent) : void
        {
            return;
        }// end function

        public function reqStoreMoney(param1:int, param2:Boolean) : void
        {
            return;
        }// end function

        public function reqOpenStore() : void
        {
            this._protocol.reqOpenStore();
            return;
        }// end function

        public static function getInstance() : StoreControl
        {
            if (!_instance)
            {
                _instance = new StoreControl;
            }
            return _instance;
        }// end function

    }
}
