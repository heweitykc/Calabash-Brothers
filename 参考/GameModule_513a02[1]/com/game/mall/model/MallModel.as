package com.game.mall.model
{
    import __AS3__.vec.*;
    import com.game.shop.model.*;
    import com.model.*;

    public class MallModel extends Object
    {
        private var _mallList:Object;
        private var _modelType:String;
        private var _shop:Object;
        public static const GENERAL:String = "general";
        public static const ENHANCE:String = "enhance";
        public static const BUFF:String = "buff";
        public static const BINDDIAMOND:String = "binddiamond";
        public static const VIP:String = "vip";
        public static const PAGESIZE:int = 9;
        public static const kind:Object = {1:GENERAL, 2:ENHANCE, 3:BUFF, 4:BINDDIAMOND, 5:VIP};
        public static const mallIds:Array = [30001, 30004, 30005, 30002, 30003];
        public static const jobHot:Array = [30006, 30007, 30008, 30009, 30010, 30011, 30012, 30013, 30014, 30015, 30016, 30017];
        private static var _inst:MallModel;

        public function MallModel()
        {
            this._modelType = GENERAL;
            this._shop = new Object();
            this._shop[GENERAL] = mallIds[0];
            this._shop[ENHANCE] = mallIds[1];
            this._shop[BUFF] = mallIds[2];
            this._shop[BINDDIAMOND] = mallIds[3];
            this._shop[VIP] = mallIds[4];
            return;
        }// end function

        public function get shop() : Object
        {
            return this._shop;
        }// end function

        public function set shop(param1:Object) : void
        {
            this._shop = param1;
            return;
        }// end function

        public function get modelType() : String
        {
            return this._modelType;
        }// end function

        public function set modelType(param1:String) : void
        {
            this._modelType = param1;
            return;
        }// end function

        public function get mallList() : Object
        {
            return this._mallList;
        }// end function

        public function set mallList(param1:Object) : void
        {
            this._mallList = param1;
            return;
        }// end function

        public function getHot() : Vector.<ShopItemInfo>
        {
            if (!this._mallList || this._mallList[jobHot[(UserObj.getInstance().playerInfo.job - 1)]] == null)
            {
                return null;
            }
            var _loc_1:* = (this._mallList[jobHot[(UserObj.getInstance().playerInfo.job - 1)]] as ShopItemsInfo).shopItemList;
            return _loc_1;
        }// end function

        public function getList(param1:int) : ShopItemsInfo
        {
            return this._mallList[param1];
        }// end function

        public function set list(param1:ShopItemsInfo) : void
        {
            if (this._mallList == null)
            {
                this._mallList = new Object();
            }
            this._mallList[param1.shopModelId] = param1;
            return;
        }// end function

        public function getListTotal() : int
        {
            if (!this._mallList || this._mallList[this._shop[this._modelType]] == null)
            {
                return 0;
            }
            return (this._mallList[this._shop[this._modelType]] as ShopItemsInfo).shopItemList.length;
        }// end function

        public function getCurShopModel() : int
        {
            return this._shop[this.modelType];
        }// end function

        public function getPageByIndex(param1:String, param2:int, param3:int = 9) : Vector.<ShopItemInfo>
        {
            if (!this._mallList || this._mallList[this._shop[param1]] == null)
            {
                return null;
            }
            var _loc_4:* = (this._mallList[this._shop[this._modelType]] as ShopItemsInfo).shopItemList.slice((param2 - 1) * param3, param2 * param3);
            return (this._mallList[this._shop[this._modelType]] as ShopItemsInfo).shopItemList.slice((param2 - 1) * param3, param2 * param3);
        }// end function

        public static function getInstance() : MallModel
        {
            var _loc_1:* = new MallModel;
            _inst = new MallModel;
            return _inst || _loc_1;
        }// end function

    }
}
