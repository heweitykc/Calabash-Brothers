package com.game.shop.model
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.model.vo.*;

    public class ShopItemsInfo extends Object
    {
        private var _shopModelId:int;
        private var _npcId:int;
        private var _title:String;
        private var _shopItemList:Vector.<ShopItemInfo>;

        public function ShopItemsInfo()
        {
            this._title = LanguageCfgObj.getInstance().getByIndex("11131");
            this._shopItemList = new Vector.<ShopItemInfo>;
            return;
        }// end function

        public function get npcId() : int
        {
            return this._npcId;
        }// end function

        public function set npcId(param1:int) : void
        {
            this._npcId = param1;
            return;
        }// end function

        public function get shopModelId() : int
        {
            return this._shopModelId;
        }// end function

        public function set shopModelId(param1:int) : void
        {
            this._shopModelId = param1;
            return;
        }// end function

        public function get title() : String
        {
            return this._title;
        }// end function

        public function set title(param1:String) : void
        {
            this._title = param1;
            return;
        }// end function

        public function get shopItemList() : Vector.<ShopItemInfo>
        {
            return this._shopItemList;
        }// end function

        public function set shopItemList(param1:Vector.<ShopItemInfo>) : void
        {
            this._shopItemList = param1;
            this._shopItemList.sort(this.sortByIndex);
            return;
        }// end function

        private function sortByIndex(param1:ShopItemInfo, param2:ShopItemInfo) : int
        {
            if (param1.q_index < param2.q_index)
            {
                return -1;
            }
            if (param1.q_index > param2.q_index)
            {
                return 1;
            }
            return 0;
        }// end function

    }
}
