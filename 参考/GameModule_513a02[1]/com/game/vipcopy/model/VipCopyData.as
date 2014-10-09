package com.game.vipcopy.model
{
    import com.game.zones.model.*;

    public class VipCopyData extends Object
    {
        private var _curSelect:int = 1;
        public static var copyMapIdArray:Array = [700001, 700002, 700003];
        private static var _instance:VipCopyData;

        public function VipCopyData()
        {
            return;
        }// end function

        public function getCopyLeftNum(param1:int) : int
        {
            var _loc_2:* = ZonesModel.getInstance().getCopyLeftNum(param1);
            return _loc_2;
        }// end function

        public function get curSelect() : int
        {
            return this._curSelect;
        }// end function

        public function set curSelect(param1:int) : void
        {
            this._curSelect = param1;
            return;
        }// end function

        public static function getInstance() : VipCopyData
        {
            if (_instance == null)
            {
                _instance = new VipCopyData;
            }
            return _instance;
        }// end function

    }
}
